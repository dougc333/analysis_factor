#this takes the most memory and fails to run. 
from dataclasses import dataclass
import csv

@dataclass
class Filler:
    pos:int
    len:int
    line_no:int

def find_blanks(line_no, s):
    stack=[]
    for idx in range(0,len(s)):
        #print(s[idx])
        if s[idx]==" ":
            stack.append(" ")
        else:
            if len(stack)>0:
                if idx not in stack_stats:
                    l = []
                    f = Filler(idx,len(stack), line_no)
                    l.append(f)
                    stack_stats[idx] = l 
                else:
                    new_f = Filler(idx, len(stack),line_no)
                    stack_stats[idx].append(new_f)
                stack=[]

stack_stats={} 
#"small.txt"
#
with open("/Users/dc/Desktop/downloaded/Nat2014PublicUS.c20150514.r20151022.txt") as fh:
    lines = fh.readlines()
    for idx in range(0,len(lines)):
        #print("lineno:",idx)
        #print(lines[idx])
        find_blanks(idx,lines[idx])
    print("stack_stats:",stack_stats)
    with open("t.csv","w",newline="\n") as f:
        writer = csv.DictWriter(f, fieldnames=stack_stats.keys())
        writer.writeheader()
        writer.writerow(stack_stats)
    print("done")
