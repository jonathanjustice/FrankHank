package utilities.Saving_And_Loading{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import utilities.objects.GameObject;
	import flash.errors.*;
//	import flash.errors.IOErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.errors.IOError;
	import flash.events.ErrorEvent;

	import flash.media.Sound; 

	public class mp3Loader extends GameObject {
		private var soundObject:Object;
		private var soundToLoad:Sound = new Sound(); 
		public function mp3Loader() {
			
		}
		public function beginLoad(newObject:Object,filePath:String):void {
			soundObject = newObject;
			
			soundToLoad.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler); 
			soundToLoad.addEventListener(Event.COMPLETE, loadCompleteHandler); 
			soundToLoad.addEventListener(IOErrorEvent.IO_ERROR, errorHandler); 
			var req:URLRequest = new URLRequest(filePath); 
			soundToLoad.load(req); 
		}
		
		private function loadProgressHandler(event:ProgressEvent):void { 
			var loadedPct:uint = Math.round(100 * (event.bytesLoaded / event.bytesTotal)); 
			//trace("The sound is " + loadedPct + "% loaded."); 
		} 
		 
		private function loadCompleteHandler(event:Event):void { 
			var localSound:Sound = event.target as Sound; 
			soundObject.assignSound(localSound);
			//localSound.play();
			soundToLoad.removeEventListener(ProgressEvent.PROGRESS, loadProgressHandler); 
			soundToLoad.removeEventListener(Event.COMPLETE, loadCompleteHandler); 
			soundToLoad.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler); 
			 try {
                    soundToLoad.close();
                }
                catch (error:IOError) {
                    trace("Couldn't close stream " + error.message);    
                }
		} 
		
		private function errorHandler(event:IOErrorEvent):void { 
			trace("The sound could not be loaded: " + event.text); 
			trace( "you did bad, this is what happened: " + event.toString() +" You probably fucked up the file path or file name." );
		}
	}
}
