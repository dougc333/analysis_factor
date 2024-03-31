import Grid from "@mui/material/Grid"
import { ChartContainer, LinePlot, ScatterPlot } from "@mui/x-charts"
import {useState} from 'react'
import useSWR from 'swr'
import axios from "axios"
import cloneDeep from 'clone-deep'

const ENDPOINT = './nlsy.json'

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

// type whichCenter = {
//   calcX:boolean,
//   calcY:boolean
// }
const Centering = () => {
  const [graphData, setGraphData] = useState(Array<MCSPCS>)
  
  useSWR(ENDPOINT, key=>{
    console.log("key",key)
    axios.get(key).then(r=>r.data).then(myData =>myData.map( (data:jsonType) => {return {id: parseInt(data["ID"]),x:parseInt(data["MCS2000"]),y:parseInt(data["PCS2000"])}})).then(myData=>setGraphData(myData))
  })

  console.log("graphdata",graphData)

  function avgX(){   
    console.log("avgX graphData:",graphData)
    const sumX = graphData.reduce((acc,value)=>{
      acc=acc+value.x
      return acc+=value.x
    },0)
    console.log("sumX:",sumX, "avgX:",sumX/graphData.length,"graphData.length:",graphData.length)
    return sumX/graphData.length
  }
  function avgY(){
    const sumY = graphData.reduce((acc,value)=>{
    return acc+=value.y
    },0)
    console.log("sumY:",sumY, "avgY:",sumY/graphData.length,"graphData.length:",graphData.length )
    return sumY/graphData.length
  }


  function CenterX(){
      console.log("xAvg:",avgX(), "yAvg:",avgY())
      const xAvg = avgX()
      //const yAvg = avgY()
      const tmpData = [...graphData]
      tmpData.forEach(data=> data.x-=xAvg)
      setGraphData(tmpData)
  }

  function CenterY(){
    console.log("xAvg:",avgX(), "yAvg:",avgY())
    //const xAvg = avgX()
    const yAvg = avgY()
    const tmpData = [...graphData]
    tmpData.forEach(data=>  data.y-=yAvg)
    setGraphData(tmpData)
}


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
            },
            {
              type:"line", 
              data:  [1,2,3,4,5000,6000,7000,8000,9000,10000]
            },
          ]}
          xAxis={[
            {
              data: [0, 500, 1000, 1500, 2000,4000,6000,8000,10000,20000],
              scaleType: 'linear',
              id: 'x-axis-id',
            },
          ]} 

        >
        <ScatterPlot/>
        <LinePlot></LinePlot>

        </ChartContainer>
        <button onClick={CenterX}>CenterX</button>
        <button onClick={CenterY}>CenterY</button>
      </Grid>
      <Grid item sm={8}>bar</Grid>

    </Grid>
  )
}

export default Centering