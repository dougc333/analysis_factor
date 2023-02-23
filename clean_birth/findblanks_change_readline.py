from dataclasses import dataclass

@dataclass
class Filler:
    col_num:int 
    pos:int
    text_line_num:int


class ReadData:
    def __init__(self, datafile):
        self.file_name = datafile
        self.process()
        self.stack_stat = {}
        
    def process(self):
        line_no = 0
        with open(self.file_name) as fh:
            line = fh.readline()
            self.parse_line(line_no, line)
            line_no +=1
    
    def parse_line(line_no, s):
        """iterate through s and find the blank spaces. If 1 blank space or  more this is a filler"""
        stack=[] #list to store blank spaces
        
        for idx, ch in enumerate(s):
            if ch == " ":
                stack.append(" ")
            else:
                #not a blank space, if we have any spaces in stack, store this into dict
                if len(stack)>0:
                    self.stack_stat[idx]=Filler(idx, , line_no)
                    stack=[]



datafile = "/Users/dc/Desktop/downloaded/Nat2014PublicUS.c20150514.r20151022.txt"
r = ReadData(datafile)

