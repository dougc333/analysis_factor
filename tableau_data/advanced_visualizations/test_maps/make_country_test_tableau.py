from collections import defaultdict

import redis

class ParseLocation:
  def __init__(self,fileName:str):
    self.fileName = fileName
    self.country = defaultdict(int)
    self.state = defaultdict(int)
    self.city = defaultdict(int) 
    self.uid={}
    self.parse()
    self.writecsv()
    self.connect_redis()
  def connect_redis(self):
    r = redis.Redis(host='localhost', port=6379, decode_responses=True,username="default", password="admin", db=0)
    r.set("foo","bar")
    print(r.get("foo"))  
  
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
        location = line.split("\t")[3]
        uid = line.split("\t")[0]
        if "," in location:
          if location.count(",")==1:
            print("1 comma in location")
            print(" state:",location.split(",")[0])
            print(" country:",location.split(",")[1])   
            self.uid[uid] = [{"state":location.split(",")[0]},{"country":location.split(",")[1]}]
            self.state[location.split(",")[0]] +=1
            self.country[location.split(",")[1]] += 1  
          elif location.count(",")==2:
            print("2 comma in location")
            print(" city:",location.split(",")[0])
            print(" state:",location.split(",")[1])
            print(" country:",location.split(",")[2])
            self.uid[uid] = [{"city":location.split(",")[0]},{"state":location.split(",")[1]},{"country":location.split(",")[2]}]
            self.city[location.split(",")[0]] += 1
            self.state[location.split(",")[1]] +=1
            self.country[location.split(",")[2]] += 1  
        else:
          print(f'uid:{uid} location is country:{location}')
          self.uid[uid] = {"country":location}
          self.country[location] += 1    
    print(self.uid["1"])
    print("num cities:",len(self.city))
    print("num states:",len(self.state))
    print("num countries:",len(self.country))
    print(self.state)
    fh.close()
    
  def writecsv(self):
    with open("writecountry.csv","w") as fh:
      fh.writelines(["Country",",","num","\n"])
      for country in list(self.country.keys()):
        fh.writelines([country,",",str(self.country[country]),"\n"])
        #print("country:",country," num:", self.country[country])
    
    

p = ParseLocation("/Users/dc/analysis_factor/data/demographics.tsv")

