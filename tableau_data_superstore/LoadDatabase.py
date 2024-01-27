import sqlalchemy
import psycopg2
from io import BytesIO
import pandas as pd
from sqlalchemy import create_engine

class LoadDatabase:
  def __init__(self):
    """"""
    #self.LoadTables()
  
  def LoadTables(self):
    engine = create_engine('postgresql+psycopg2://postgres:asdf@localhost:5432/TestDatabase')
    print(engine)
    df1 = pd.read_csv(('/Users/dc/analysis_factor/tableau_data_superstore/sample_-_superstoreutf8/Orders-Table.csv'),encoding = "ISO-8859-1")
    df2 = pd.read_csv(('/Users/dc/analysis_factor/tableau_data_superstore/sample_-_superstoreutf8/People-Table.csv'),encoding = "ISO-8859-1")
    df3 = pd.read_csv(('/Users/dc/analysis_factor/tableau_data_superstore/sample_-_superstoreutf8/Returns-Table.csv'),encoding = "ISO-8859-1")
    
    #print(df)
    dfsql1 = df1.to_sql('Orders', engine)
    dfsql2 = df2.to_sql('People', engine)
    dfsql3 = df3.to_sql('Return', engine)
    print("numRows table Orders:",dfsql1)
    print("-------")
    print("numRows table People:",dfsql2)
    print("numRows table Return:","-------")
    print(dfsql3)
    
  def barcharts(self):
    conn = psycopg2.connect(database="TestDatabase",
                        host="localhost",
                        user="postgres",
                        password="asdf",
                        port="5432")
    cursor = conn.cursor()
    result = cursor.execute("""SELECT index, "Row ID", "Order ID", "Order Date", "Ship Date", "Ship Mode", "Customer ID", "Customer Name", "Segment", "Country", "City", "State", "Postal Code", "Region", "Product ID", "Category", "Sub-Category", "Product Name", "Sales", "Quantity", "Discount", "Profit"
	FROM public."Orders";""")
    for record in cursor:
      print(record)
    sum14 = cursor.execute("""SELECT index, "Row ID", "Order ID", "Order Date", "Ship Date", "Ship Mode", "Customer ID", "Customer Name", "Segment", "Country", "City", "State", "Postal Code", "Region", "Product ID", "Category", "Sub-Category", "Product Name", "Sales", "Quantity", "Discount", "Profit"
	FROM public."Orders" where "Order Date" """)
    cursor.close()
    conn.close()
    
ld = LoadDatabase()
ld.barcharts()