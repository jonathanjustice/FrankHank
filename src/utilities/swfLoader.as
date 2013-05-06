package utilities{
	import flash.display.Sprite;
	public class swfLoader extends Sprite{
		import flash.events.EventDispatcher;
		import flash.events.Event;
		import flash.events.IOErrorEvent;
		import flash.events.IEventDispatcher;
		import flash.events.ErrorEvent;
		import flash.net.URLRequest;
		import flash.net.*;
		import flash.display.Bitmap;
		import flash.display.Loader;
		
		//swfs
		public static var swfsLoading:Array=[];
		private static var returnClass;
		
		public function swfLoader(){
			//

		}
		
		//this prints out the error when you make a mistake with your xml file locations
		private static function errorHandler( event:ErrorEvent ):void{
			trace( "you did bad, this is what happened: " + event.toString() +" You probably fucked up the file path or file name." );
		}
		
		//take the file path and load the sml
		//listen for load completed and for error handling
		public static function loadNewSWF(filePath:String):void{
			swfsLoading.push(false);
			var newSWF;;//prepare new xml var
			var swfLoader:URLLoader = new URLLoader();//create instance of loader class
			swfLoader.load(new URLRequest(filePath));//request the xml file
			swfLoader.addEventListener( IOErrorEvent.IO_ERROR, errorHandler );
			swfLoader.addEventListener(Event.COMPLETE, loadSWF);//listen for xml finished loading
		}
		
		//pass the file that needs to have the xmls to this function, when loading is complete, the xmls will be send back
		public static function designateReturnClass(file){
			returnClass = file;
		}
		
		//I dont understand how to do this correctly. need to verify that swf is loaded completely before it gets used
		//xml is finished loading
		private static function loadSWF(e:Event):void {
			var newSWF = new XML(e.target.data);
			returnClass.returnSWF(newSWF);
			//trace(newXML.quest[0].id);//ignore the root node, because as3 makes sense
		}
	}
}