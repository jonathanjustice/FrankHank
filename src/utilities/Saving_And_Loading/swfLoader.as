package utilities.Saving_And_Loading{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import utilities.objects.GameObject;

	public class swfLoader extends GameObject {
		private var object:MovieClip;
		
		public function swfLoader() {
			
		}
		
		//creater a new loader object
		//create a new request
		//add listener for completing the load
		//add a listener for loading progress being updated, usually for a progress bar or load percentage
		//file path format "../lib/Test_swf.swf"
		public function beginLoad(object_to_add_swf_to:MovieClip,filePath:String):void {
			object = object_to_add_swf_to;
			//print(String(object_to_add_swf_to));
			var newLoader:Loader = new Loader();
			var newRequest:URLRequest = new URLRequest(filePath);
			newLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
			newLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			newLoader.load(newRequest);
		}
		
		//when the load is complete, assign the loaded swf to the object that requested it
		public function loadCompleteHandler(loadEvent:Event):void {
			object.assignGraphic(loadEvent.currentTarget.content);
		}
		
		//when loading progress is updated, do something, here trace the percent loaded
		public function loadProgressHandler(loadProgress:ProgressEvent):void{
			var percentLoaded:Number = loadProgress.bytesLoaded/loadProgress.bytesTotal;
			//trace(percentLoaded);
			
			//add a check to ensure that all graphics are completely loaded before allowing the game to continue running
		}
	}
}
