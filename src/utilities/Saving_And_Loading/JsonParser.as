package utilities.Saving_And_Loading {
	import flash.events.*;
	import flash.system.Security;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.ProgressEvent;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import JSON;
	import flash.net.URLLoader;
	
	public class JsonParser {
		private var JSON_ASSETS_SWF:String = new String("../src/assets/json/json_assets_swf.json");
		private var JSON_ASSETS_MP3:String = new String("../src/assets/json/json_assets_mp3.json");
		private static var data_swf:JSON;
		private static var data_mp3:Object;
		private static var data:Object;
		public function JsonParser() {
			trace("hello world");
			loadJSON(JSON_ASSETS_MP3);
		}
		
		//creater a new loader object
		//create a new request
		//add listener for completing the load
		//add a listener for loading progress being updated, usually for a progress bar or load percentage
		protected function loadJSON(json_to_load:String):void{
			var urlRequest:URLRequest  = new URLRequest(json_to_load);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, completeHandler);
			try{
				urlLoader.load(urlRequest);
			} catch (error:Error) {
				trace("Cannot load : " + error.message);
			}
		}

		private static function completeHandler(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			trace("loader", loader);
			trace("completeHandler: " + loader.data);
			data = JSON.parse(loader.data);
			data_mp3 = JSON.parse(loader.data);
			trace("The answer is " + data.sounds[0].name);
			trace("The answer is " + data.sounds[0].name+" ; "+data.sounds[0].filePath+" ; "+data.sounds[0].volume);
			//All fields from JSON are accessible by theit property names here/
			//data_mp3 = data as JSON;
		}
		
		public function getData_mp3():Object {
			return data_mp3;
		}
		
		public function getData_swf():Object {
			return data_swf;
		}
	}
}