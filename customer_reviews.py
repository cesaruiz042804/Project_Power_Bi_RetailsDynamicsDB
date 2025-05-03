import pandas as pd
import pyodbc
import nltk
from nltk.sentiment import SentimentIntensityAnalyzer

nltk.download('vader_lexicon')

def fetch_data_from_sql():
    conn_str = (
        "Driver={SQL Server};"
        "Server=DESKTOP-ES7TD17\\SQL_EXPRESS;"  # Replace with your server name
        "Database=RetailDynamicsDB;"  # Replace with your database name
        "Trusted_Connection=yes;"
    )
    
    conn = pyodbc.connect(conn_str)
    
    query = "SELECT CustomerReviewsID, CustomerID, ProductID, ReviewDate, Rating, ReviewText FROM CustomerReviews"  # Replace with your actual SQL query
    df = pd.read_sql(query, conn)
    
    conn.close()
    
    return df

customer_reviews_df = fetch_data_from_sql()

sia = SentimentIntensityAnalyzer()

def calculate_sentiment(review):
    scores = sia.polarity_scores(review)
    return scores['compound']

def categorize_sentiment(score, rating):
    if score > 0.05:
        if rating >= 4:
            return 'Positive'
        elif rating == 3:
            return 'Mixed Positive'
        else:
            return 'Mixed Negative'
    elif score < -0.05:
        if rating <= 2:
            return 'Negative'
        elif rating == 3:
            return 'Mixed Negative'
        else:
            return 'Mixed Positive'
    else:
        if rating >= 4:
            return 'Positive'
        elif rating <= 2:
            return 'Negative'
        else:
            return 'Neutral'
        
def sentiment_bucket(score):
    if score >= 0.5:
        return '0.5 to 1.0'
    elif 0.0 <= score < 0.5:
        return '0.0 to 0.49'
    elif -.05 <= score < 0.0:
        return '-0.49 to 0.0'
    else:
        return '-1.0 to -0.5'

customer_reviews_df['SentimentScore'] = customer_reviews_df['ReviewText'].apply(calculate_sentiment)

customer_reviews_df['SentimentCategory'] = customer_reviews_df.apply(
    lambda row: categorize_sentiment(row['SentimentScore'], row['Rating']), axis=1
)
      
customer_reviews_df['SentimentBucket'] = customer_reviews_df['SentimentScore'].apply(sentiment_bucket)  

print(customer_reviews_df.head())

customer_reviews_df.to_csv('fact_customer_reviews_with_sentiment.csv', index=False)
    
    
   
   
   
   
   
"""
import pandas as pd: Importa la librería pandas y la asigna el alias pd. pandas es fundamental 
para la manipulación y análisis de datos, proporcionando estructuras de datos como los DataFrames.
import pyodbc: Importa la librería pyodbc. Esta librería permite la conexión a bases de datos 
ODBC (Open Database Connectivity), como SQL Server, desde Python.
import nltk: Importa la librería nltk (Natural Language Toolkit). Es una librería poderosa para 
el procesamiento del lenguaje natural (NLP), que incluye herramientas para tareas como análisis 
de sentimientos, tokenización, etc.
from nltk.sentiment.vader import SentimentIntensityAnalyzer: Específicamente, importa la clase 
SentimentIntensityAnalyzer del módulo vader dentro de nltk.sentiment. 
VADER (Valence Aware Dictionary and sEntiment Reasoner) es una herramienta de 
análisis de sentimientos léxico y basado en reglas, especialmente ajustada para el sentimiento expresado en redes sociales.
"""
