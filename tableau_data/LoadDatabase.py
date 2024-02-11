import sqlalchemy
import psycopg2
from io import BytesIO
import pandas as pd
from sqlalchemy import create_engine

class LoadDatabase:
  def __init__(self,csv_files, tables):
    self.csv_files = csv_files
    self.table_names = tablesn
    #self.LoadTables()
  
  def LoadTables(self):
    engine = create_engine('postgresql+psycopg2://postgres:asdf@localhost:5432/TestDatabase')
    print(engine)
    data_frames = []
    for x in csv_files:
      data_frames.append(pd.read_csv(x,encoding = "ISO-8859-1"))
      #df2 = pd.read_csv((),encoding = "ISO-8859-1")
      #df3 = pd.read_csv((),encoding = "ISO-8859-1")
    
    #print(df)
    for idx,df in enumerate(data_frames):
      dfsql = df.to_sql(self.table_names[idx], engine)
      print(f"numRows {table_names[idx]}: {dfsql}")
    #dfsql2 = df2.to_sql('People', engine)
    #dfsql3 = df3.to_sql('Return', engine)
   
    # print("-------")
    # print("numRows table People:",dfsql2)
    # print("numRows table Return:","-------")
    # print(dfsql3)
    
  def barcharts(self):
    conn = psycopg2.connect(database="TestDatabase",
                        host="localhost",
                        user="postgres",
                        password="asdf",
                        port="5432")
    cursor = conn.cursor()
    result = cursor.execute("""SELECT index, "Row ID", "Order ID", "Order Date", "Ship Date", "Ship Mode", "Customer ID", "Customer Name", "Segment", "Country", "City", "State", "Postal Code", "Region", "Product ID", "Category", "Sub-Category", "Product Name", "Sales", "Quantity", "Discount", "Profit"
	FROM public."Orders";""")
    # for record in cursor:
    #   print(record)
    sum14 = cursor.execute("""SELECT  "Order Date",  "Profit"
	FROM public."Orders" """)
    for record in cursor:
      print(record)
    cursor.close()
    conn.close()
    
# files=['/Users/dc/analysis_factor/tableau_data_superstore/sample_-_superstoreutf8/Orders-Table.csv',
#        '/Users/dc/analysis_factor/tableau_data_superstore/sample_-_superstoreutf8/People-Table.csv',
#        '/Users/dc/analysis_factor/tableau_data_superstore/sample_-_superstoreutf8/Returns-Table.csv'
#       ]
files=['/Users/dc/rossman_data/store.csv', '/Users/dc/rossman_data/train.csv']
table_names = ['Store,','train']
ld = LoadDatabase(files, tablenames)
# ld.barcharts()