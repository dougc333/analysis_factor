import Grid from "@mui/material/Grid"
import { ChartContainer, LinePlot, ScatterPlot,ChartsXAxis } from "@mui/x-charts"
import {useEffect, useState} from 'react'
import useSWR from 'swr'
import axios from "axios"

const ENDPOINT = './nlsy.json'

type MCSPCS = {
  id: number,
  x:number, 
  y:number
}

type jsonType = {
  index:number,
  MCS2000:number,
  PCS2000:number
}

// type whichCenter = {
//   calcX:boolean,
//   calcY:boolean
// }
const Centering = () => {
  const [graphData, setGraphData] = useState(Array<MCSPCS>)
  const [xData,setXData] = useState(Array<number>)

  useSWR(ENDPOINT, key=>{
    console.log("key",key)
    axios.get(key).then(r=>r.data).then(myData =>myData.map( (data:jsonType) => {return {id: data["index"],x:data["MCS2000"],y:data["PCS2000"]}})).then(myData=>setGraphData(myData))
  })
  useEffect(()=>{
    const arr = calcRegressionLine(4513.7705,.129,500)
    console.log("arr:",arr)
    setXData(arr)
  },[])

  
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

  function calcRegressionLine(intercept:number, coeff:number,step_size:number){
    console.log("calcRegressionLine")
    const arr=[]
    for (let i=0;i<14;i++){
      arr.push(intercept+step_size*coeff*i)
    }
    return arr
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
              data: xData
            },
          ]}
          xAxis={[
            {
              data: [0, 500, 1000, 1500, 2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000],
              scaleType: 'linear',
              id: 'x-axis-id',
            },
          ]} 

        >
        <ScatterPlot/>
        <LinePlot></LinePlot>
        <ChartsXAxis label="MCS2000" position="bottom" axisId="x-axis-id" />
        </ChartContainer>
        <button onClick={CenterX}>CenterX</button>
        <button onClick={CenterY}>CenterY</button>
        
      </Grid>
      <Grid item sm={8}>bar</Grid>

    </Grid>
  )
}

export default Centering