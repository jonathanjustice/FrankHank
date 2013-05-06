package utilities{
	import flash.display.Sprite;
	public class xmlLoader extends Sprite{
		import flash.events.EventDispatcher;
		import flash.events.Event;
		import flash.events.IOErrorEvent;
		import flash.events.IEventDispatcher;
		import flash.events.ErrorEvent;
		import flash.net.URLRequest;
		import flash.net.*;
		import flash.display.Bitmap;
		import flash.display.Loader;
		
		//XMLs
		public static var xmlsLoading:Array=[];
		private static var returnClass;
		
		public function xmlLoader(){
			//dont do stuff in the constructor

		}
		
		//this prints out the error when you make a mistake with your xml file locations
		private static function errorHandler( event:ErrorEvent ):void{
			trace( "you did bad, this is what happened: " + event.toString() +" You probably fucked up the file path." );
		}
		
		//take the file path and load the sml
		//listen for load completed and for error handling
		public static function loadNewXML(filePath:String):void{
			xmlsLoading.push(false);
			var newXML:XML;//prepare new xml var
			var xmlLoader:URLLoader = new URLLoader();//create instance of loader class
			xmlLoader.load(new URLRequest(filePath));//request the xml file
			xmlLoader.addEventListener( IOErrorEvent.IO_ERROR, errorHandler );
			xmlLoader.addEventListener(Event.COMPLETE, loadXML);//listen for xml finished loading
		}
		
		//pass the file that needs to have the xmls to this function, when loading is complete, the xmls will be send back
		public static function designateReturnClass(file){
			returnClass = file;
		}
		
		//xml is finished loading
		private static function loadXML(e:Event):void {
			var newXML = new XML(e.target.data);
			returnClass.returnXML(newXML);
			//trace(newXML.quest[0].id);//ignore the root node, because as3 makes sense
		}
	}
}