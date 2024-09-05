from sqlalchemy import create_engine, text 
import pandas as pd


def search(sql: str, engine):
    conn = engine.connect()
    answer = pd.read_sql(sql=text(sql), 
                        con=conn)
    conn.close()
    return answer