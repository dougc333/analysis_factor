import Grid from "@mui/material/Grid"
import { ChartContainer, ScatterPlot } from "@mui/x-charts"
import {useState,useEffect} from 'react'
import useSWR from 'swr'
import axios from "axios"

const ENDPOINT = './mcs2000.json'

type MCSPCS = {
  ID: number,
  MCS2000:number, 
  PCS2000:number
}



const Centering = () => {
  const [graphData, setGraphData] = useState(Array<MCSPCS>)
  //const [scatterData, setScatterData] = useState(Array<ScatterData>)

  // function convertData(arg:Array<MCSPCS>): Array<ScatterData>{
  //   console.log("convertData arg:",arg)
  //   const foo = arg.map(data=>setScatterData([...scatterData,{id:parseInt(data["ID"])}])
  //   )
  //   console.log("convertData typeof foo:",(foo))
  // }

  useSWR(ENDPOINT, key=>{
    console.log("key",key)
    axios.get(key).then(r=>r.data).then(myData=>myData.map(data=> {return {id: parseInt(data["ID"]),x:parseInt(data["MCS2000"]),y:parseInt(data["PCS2000"])}})).then(myData=>setGraphData(myData))
    
  })
  console.log("graphdata",graphData)
  
  return (
    <Grid container>
      <Grid item sm={8}>
        <ChartContainer 
          height={700}
          width={500}
          series={[
            {
              type:"scatter", 
              data:  graphData
            }
          ]}
        >
        <ScatterPlot/>
        </ChartContainer>
      </Grid>
      <Grid item sm={8}>bar</Grid>

    </Grid>
  )
}

export default Centering