package{
	/**
	* Multiple photo example
	*/
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.display.Bitmap;

	// import the bulkloader classes
	import br.com.stimuli.loading.*;

	public class BulkLoaderSystem extends MovieClip{

		private var bulkLoader:BulkLoader;
		private var bulkLoaderName:String = "main";

		// vectors are like arrays, but more strict
		// in this example everything the the vector "array"
		// must be a string
		private var itemsToLoad:Array = new Array();

		private var moveThis:Bitmap;

		private var container:MovieClip;

		private var click:Boolean = false;
		private var clickCounter:int = 1;
		private var object:MovieClip;
		private var objectsToReturnSwfsTo:Array = new Array();


		public function BulkLoaderSystem ():void{
			bulkLoader = new BulkLoader("main-site", BulkLoader.LOG_VERBOSE);
			objectsToReturnSwfsTo = [];
		}
		
		public function beginLoad(object_to_add_swf_to:MovieClip, filePath:String):void {
			objectsToReturnSwfsTo.push(object_to_add_swf_to);
			itemsToLoad.push(filePath);
			var loadId:String = String(itemsToLoad.length - 1);
				bulkLoader.add(itemsToLoad[loadId], { id: loadId, priority:10 - int(loadId) } );
				bulkLoader.get(loadId).addEventListener(BulkLoader.COMPLETE, onItemLoaded, false, 0, true);
				bulkLoader.get(loadId).addEventListener(BulkLoader.ERROR, onItemError, false, 0, true);
				bulkLoader.start();
		} 
			
		private function onItemError(e:Event):void {
			trace("item load error:" + e.target);
		} 	 	
		
		private function onItemLoaded(e:Event):void {
			//trace("the current item loaded is..." + e.currentTarget.id);
			var image : MovieClip = bulkLoader.getMovieClip(e.currentTarget.id);
			e.target.removeEventListener(BulkLoader.COMPLETE, onItemLoaded);
			var index:int = 0;
			index = int(e.currentTarget.id);
			objectsToReturnSwfsTo[index].assignGraphic(image);
		}
	}
}
