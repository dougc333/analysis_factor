const graphData=
[
{x:1, y:10,id:1},
{x:2, y:11,id:2},
{x:3, y:12,id:3},
{x:4, y:13,id:4},
]

const sumX = graphData.reduce((acc,value)=>{
	return acc+=value.x
},0)
console.log("sumX:",sumX)
const avgX = sumX/graphData.length

console.log(avgX)
graphData.forEach(data=>{data.x-=1})
console.log("GraphData:",graphData)

