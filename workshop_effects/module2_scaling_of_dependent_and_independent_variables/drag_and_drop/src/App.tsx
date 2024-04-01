import './App.css'
import DND from './components/DND'
import {useState} from 'react'

function App() {
  const [files, setFiles] = useState(Array<File>)

  function callback(newFiles: Array<File>){
    newFiles.map(f=>console.log("file:",f))
    setFiles(newFiles)

  }
  return (
    <>
    <DND className="drag-and-drop" onFilesDropped={callback} >
      <p className='drag-and-drop-hint'>Drop Here</p>
    </DND>
    <ul>
      {files.map(x=><li key={Math.random()}>{x.name}</li>)}
    </ul>
    <p>1</p>
    <div>2</div>
    <div>foobar</div>
    <div>We want type: text/plain</div>

    </>
  )
}

export default App
