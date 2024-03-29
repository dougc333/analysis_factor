import fs from "fs";
import { parse } from 'csv-parse';
const header = ["ID","PCS2000","MCS2000"]


const data = fs.readFileSync("pcs2000_mcs2000.csv", { encoding: 'utf-8' })
parse(data,{
  delimiter:',',
  columns:  header,
},(error, result)=>{
  if (error){
    console.log("error:",error)
  }
  fs.writeFileSync("mcs2000.json",JSON.stringify(result))  
})
