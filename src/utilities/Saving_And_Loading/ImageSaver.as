/*******************
 * 
 * 
 * 
 * 
 * THIS ONLY WORKS FOR AIR APPLICATIONS!
 * 
 * If your app can't be AIR, try using a SharedObject, or a better language
 * 
 * 
 * ******************/

package utilities.Saving_And_Loading{
	import flash.display.*;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.*;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	import flash.filesystem.File;
	import com.PNGEncoder;
	import flash.filesystem.*;
	import utilities.Engine.Game;
	public class ImageSaver extends Sprite{
		private var bytes:ByteArray;
        private var fileReference:FileReference;
		var fileReference_loading:FileReference= new FileReference();
        public function ImageSaver() {
		
        }
		
		/*
		The file extension is listed twice because many people will have the default file format 
		configured to not show up when saving, which could cause both usability as well as technical problems
		 *
		 * Pass in a BITMAP, not a bitmapDATA, it converts it to bitmapData for you, so there is less work to do where you sent the data from
		 * 
		 * Example of a valid bitmap that you can use 
		 * 
		 * var bitmap:Bitmap = new Bitmap(new BitmapData(300,300,false,0xFF0000));
		 * var bitmapData:BitmapData = new BitmapData(300,300,false,0xFF0000)
		 * 
		 */
		public function saveImage(bitmapImage:Bitmap):void {
			trace("start saving");
			var bitmapDataToSave:BitmapData = bitmapImage.bitmapData.clone();
			var myByteArray:ByteArray = PNGEncoder.encode(bitmapDataToSave);
			var fileReference:FileReference = new FileReference();
			fileReference.save(myByteArray, "newImage.png.png"); 
		}
		
		public function loadImage(e:MouseEvent):void {
			fileReference_loading.browse([new FileFilter("Images", "*.jpg;*.gif;*.png")]);
			fileReference_loading.addEventListener(Event.SELECT, onFileSelected);
		}
		
		function onFileSelected(e:Event):void {
			fileReference_loading.addEventListener(Event.COMPLETE, onFileLoaded);
			fileReference_loading.load();
		}
		
		function onFileLoaded(e:Event):void {
			var loader:Loader = new Loader();
			loader.loadBytes(e.target.data);
			//do something with the loaded file
			utilities.Engine.Game.gameContainer.addChild(loader);
		}
	}
} 