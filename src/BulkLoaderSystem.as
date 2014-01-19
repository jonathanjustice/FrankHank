package{
	/**
	* Multiple photo example
	*/
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

		public function BulkLoaderSystem ():void{
			trace("BulkLoaderMultiplePhoto constructor");
			startLoad();
		}

		private function startLoad():void{
			trace("BulkLoaderMultiplePhoto exits");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			container = new MovieClip();
			addChild(container);
			// photos thanks to the Wiki Commons
			itemsToLoad[0] = "../src/photos/bun_1.jpg";
			itemsToLoad[1] = "../src/photos/bun_2.jpg";
			itemsToLoad[2] = "../src/photos/bun_3.jpg";
			itemsToLoad[3] = "../src/photos/bun_4.jpg";
			itemsToLoad[4] = "../src/photos/bun_5.jpg";
			
			// start a new bulkloader
			bulkLoader = new BulkLoader("main-site", BulkLoader.LOG_VERBOSE);
			
			for (var i:int = 0; i < itemsToLoad.length; i++) {
				// use a loop to "add" each photo to the loader with a unique id
				bulkLoader.add(itemsToLoad[i], { id:"itemsToLoad-" + i, priority:10 - i } );
				bulkLoader.get("itemsToLoad-" + i).addEventListener(BulkLoader.COMPLETE, onItemLoaded, false, 0, true);
				bulkLoader.get("itemsToLoad-" + i).addEventListener(BulkLoader.ERROR, onItemError, false, 0, true);
			}
				// start the loading
				bulkLoader.start();
		} 
			
		private function onItemError(e:Event):void {
			trace("item load error:" + e.target);
		} 	 	
		
		private function onItemLoaded(e:Event):void {
			trace("the current item loaded is..." + e.currentTarget.id);
			var counter:Array = e.currentTarget.id.split("photo-");
			trace("counter[1] is " + counter[1]);
			// outputs just the "count" of the photo
			// bulkloader loads each image by the id
			var image : Bitmap = bulkLoader.getBitmap(e.currentTarget.id);
			//Add the image to the holder
			container.addChild(image); 
			// remove the listener for the bulkloader so it doesn't suck up memory
			e.target.removeEventListener(BulkLoader.COMPLETE, onItemLoaded);
		}
	}
}
