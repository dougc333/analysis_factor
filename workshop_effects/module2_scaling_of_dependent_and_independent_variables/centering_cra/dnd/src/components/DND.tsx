

import { PropsWithChildren, DragEvent } from 'react'
type DragAndDropClass = {
  className?:string
  onFilesDropped: (files:Array<File>)=>void
}

const DND = ({className,children,onFilesDropped}:PropsWithChildren<DragAndDropClass>) => {
  //when you drop file
  function onDrop(event:DragEvent<HTMLDivElement>){
    event.preventDefault()
    console.log(event)
    const items = event.dataTransfer.items
    const files = event.dataTransfer.files
    if (items){
      //use items
      processItems([...items])
    }else if (files){
      //use files
      processFiles([...files])
    }
  }
  function processItems(items:Array<DataTransferItem>){
    //console.log("items not filtered:",items)
    //console.log(items.map((x,index)=>console.log("kind:",x.kind, "index:",index," type:",x.type,"getAsString:",x.getAsString(x=>console.log("x:",x)))))
    console.log(items.map((item)=>item.type==="text/plain" ? item.getAsString(s=>console.log("match:",s)) : console.log("no match")
      ))
    const files = items.filter((item)=>item.kind==="file").map((item)=>item.getAsFile()).filter((file):file is File=>file!==null)
    
    console.log("item[0].getAsFile:",items[0].getAsFile()?.name)
    processFiles(files)
  }
  function processFiles(files:Array<File>){
    console.log("process Files:",files[0]?.name)
    onFilesDropped(files)
  }
  //
  function onDrag(event:DragEvent<HTMLDivElement>){
    event.preventDefault()

  }
  
  return (
    <div className={className} onDragOver={onDrag} onDrop={onDrop}>{children}</div>
  )
}

export default DND