package utilities.Engine.Combat{
	import br.com.stimuli.loading.lazyloaders.LazyBulkLoader;
	import flash.net.SharedObject;
	import utilities.Saving_And_Loading.ImageSaver;
	import utilities.Saving_And_Loading.SharedObjects;
	import utilities.Engine.DefaultManager;
	import utilities.GraphicsElements.BitmapDataObject;
	import flash.display.*;
	public class SaveDataManager {
		private var sharedObjects:SharedObjects = new SharedObjects();
		//private var imageSaver:ImageSaver = new ImageSaver();
		private static var _instance:SaveDataManager;
		public function SaveDataManager(singletonEnforcer:SingletonEnforcer){
		//	newSaveInstance();
		//	getSaveData();
		}
		
		
		public static function getInstance():SaveDataManager {
			if(SaveDataManager._instance == null){
				SaveDataManager._instance = new SaveDataManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
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
class SingletonEnforcer{}