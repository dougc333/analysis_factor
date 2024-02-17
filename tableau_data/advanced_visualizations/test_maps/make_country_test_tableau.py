from collections import defaultdict
import csv

class ParseLocation:
  def __init__(self,fileName:str):
    self.fileName = fileName
    self.country = defaultdict(int) 
    self.parse()
    self.writecsv()
  
  
  def parse(self):
    with open(self.fileName) as fh:
      header = fh.readline()
      print(header)
      fields = header.split("\t")
      print(fields[3])
      
      while True:
        line = fh.readline()
        if not line: 
          break
        testCountry = line.split("\t")[3]
        if "," in testCountry:
          print("not country:",testCountry)
        else:
          print('testCountry:',testCountry)
          self.country[testCountry] += 1
      #print(self.country)
      #print(len(self.country))
    fh.close()
    
  def writecsv(self):
    with open("writecountry.csv","w") as fh:
      fh.writelines(["Country",",","num","\n"])
      for country in list(self.country.keys()):
        fh.writelines([country,",",str(self.country[country]),"\n"])
        #print("country:",country," num:", self.country[country])
    
    

p = ParseLocation("./demographics.tsv")

