package utilities{

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.data.DataProvider;
	
	public class XML_Saver(){
		
		public function XML_Saver(){
			
		}
		
		public function saveFile(){
			var myFile:File = File.documentsDirectory.resolvePath("Air Examples/mylog.xml");
			var localXML:XML;
			myText.text = "";
			
			getXML();
			
			myWriteButton.addEventListener(MouseEvent.CLICK, writeEntry);
		}
		
		function getXML():void{
			if (myFile.exists){
				var myStream:FileStream = new FileStream();
				myStream.open(myFile, FileMode.READ);
				localXML = new XML(myStream.readUTFBytes(myStream.bytesAvailable));
				myStream.close();
			}
			else{
				localXML = <mylog></mylog>;
			}
		}
		
		function saveXML():void{
			var myStream:FileStream = new FileStream();
			myStream.open(myFile, FileMode.WRITE);
			myStream.writeUTFBytes(localXML.toXMLString());
			myStream.close();
		}
		
		function writeEntry(evt:MouseEvent):void{
			localXML.appendChild(<logentry date={new Date()}>{myText.text}</logentry>);
			myText.text = "";
			saveXML();
		}
	}
}