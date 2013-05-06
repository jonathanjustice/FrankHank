package utilities.GraphicsElements{
import flash.display.*;
import flash.display.MovieClip;
import utilities.Engine.Game;
	public class BitmapDataObject extends MovieClip {
		public function BitmapDataObject() {
			
		}
		
		//convert any display object to a bitmap
		public function getBitmapData(imageToSaveToBitmap:DisplayObject):Bitmap{
			if ( bmd ){
				bmd = null;
			}
			var bmd:BitmapData = new BitmapData(imageToSaveToBitmap.width, imageToSaveToBitmap.height,true, 0x00000000);
			bmd.draw(imageToSaveToBitmap);
			var bitmap:Bitmap = new Bitmap(bmd);
			return bitmap;
		}
		
		//convert the stage to a bitmap
		public function getAnImageOfTheStage():Bitmap {
			if (bmd){
				bmd = null;
			}
			var bmd:BitmapData = new BitmapData(1280, 1024,true, 0x00000000);
			bmd.draw(utilities.Engine.Game.gameContainer);
			var bitmap:Bitmap = new Bitmap(bmd);
			return bitmap;
		}
	}
}