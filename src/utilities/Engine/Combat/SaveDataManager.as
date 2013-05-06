package utilities.Engine.Combat{
	import br.com.stimuli.loading.lazyloaders.LazyBulkLoader;
	import flash.net.SharedObject;
	import utilities.Saving_And_Loading.ImageSaver;
	import utilities.Saving_And_Loading.SharedObjects;
	import utilities.Engine.DefaultManager;
	import utilities.GraphicsElements.BitmapDataObject;
	import flash.display.*;
	public class SaveDataManager extends utilities.Engine.DefaultManager {
		private var sharedObjects:SharedObjects = new SharedObjects();
		//private var imageSaver:ImageSaver = new ImageSaver();
		public function SaveDataManager(){
		//	newSaveInstance();
		//	getSaveData();
		}
		
		private function newSaveInstance():void {
			var bitmapDataObject:BitmapDataObject = new BitmapDataObject();
			var bitmap:Bitmap = bitmapDataObject.getAnImageOfTheStage();
			//var bitmap:Bitmap = new Bitmap(new BitmapData(300,300,false,0xFF0000));
			sharedObjects.saveObjectToDisk(bitmap.bitmapData);
		}
		
		private function getSaveData():void {
			var savedData:Object = sharedObjects.getSharedObject();
			if (savedData is BitmapData) {
					var newBitmap:Bitmap = new Bitmap();
					newBitmap.bitmapData = savedData as BitmapData;
					newBitmap.z = 3000;
					utilities.Engine.Game.gameContainer.addChild(newBitmap);
					utilities.Engine.Game.gameContainer.addChildAt(newBitmap,0);
			}
		}
	}
}
