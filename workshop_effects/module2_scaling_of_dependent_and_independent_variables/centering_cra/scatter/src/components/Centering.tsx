import Grid from "@mui/material/Grid"
import { ChartContainer, ScatterPlot } from "@mui/x-charts"
import {useState,useEffect} from 'react'

type MCSPCS = {
  ID:number,
  MCS2000: number,
  PCS2000:number
}

type S = {
  id:string,
  MCS2000: string,
  PCS2000:string
}

const Centering = () => {
  //const [graphData, setGraphData] = useState(Array<MCSPCS>)
  const [moreData, setMoreData] = useState(Array<S>)
  useEffect(()=>{
    // fetch('./format.json').then((res)=>res.json()).then(
    //   x=>setGraphData(x))
    fetch('./mcs2000.json').then(res=>res.json()).then((x)=>(x.map(y=>{
      console.log("y:",y)
      console.log("moreData length:",moreData.length)
      const foo= [...moreData,{id:y["ID"],MCS2000:y["MCS2000"], PCS2000:y["PCS2000"]}]
      console.log("foo:",foo)
      setMoreData(foo)
      console.log("after moreData length:",moreData.length)
      
    })))
  },[])
  
  

  //console.log("graphData:",graphData)
  console.log("moreData:",moreData)
  return (
    <Grid container>
      <Grid item sm={8}>
        <ChartContainer 
          height={700}
          width={500}
          series={[
            {
              type:"scatter",
              data: [{x:1,y:13,id:1},{x:13,y:33,id:2} ,{x:29,y:10,id:3} ,{x:4,y:10,id:4} ,{x:14,y:19,id:5},
                {x:10,y:4,id:6},{x:5,y:6,id:7},{x:11,y:7,id:8},{x:2,y:10,id:9},{x:22,y:5,id:10}]
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