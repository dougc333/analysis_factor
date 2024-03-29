import Grid from "@mui/material/Grid"
import { ChartContainer, ScatterPlot } from "@mui/x-charts"
import {useState} from 'react'
import useSWR from 'swr'
import axios from "axios"

const ENDPOINT = './mcs2000.json'

type MCSPCS = {
  id: number,
  x:number, 
  y:number
}

type jsonType = {
  ID:string,
  MCS2000:string,
  PCS2000:string
}

const Centering = () => {
  const [graphData, setGraphData] = useState(Array<MCSPCS>)

  useSWR(ENDPOINT, key=>{
    console.log("key",key)
    axios.get(key).then(r=>r.data).then(myData =>myData.map( (data:jsonType) => {return {id: parseInt(data["ID"]),x:parseInt(data["MCS2000"]),y:parseInt(data["PCS2000"])}})).then(myData=>setGraphData(myData))
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