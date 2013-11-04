package utilities.Saving_And_Loading{//from livedocs
	import flash.events.NetStatusEvent;
    import flash.net.SharedObject;
    import flash.net.SharedObjectFlushStatus;
	import flash.display.*;
	public class SavedData {
		private static var _instance:SavedData;
		private var savedData:Array;
		//gets the shared object,
		//if it doesn't exist, then make a new one and give it a default value
		public function SavedData(singletonEnforcer:SingletonEnforcer){
			savedData = [];
		}
		
		public static function getInstance():SavedData {
			if(SavedData._instance == null){
				SavedData._instance = new SavedData(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function loadSavedData():void {
			SharedObjects.getInstance().saveObjectToDisk(savedData);
			savedData = SharedObjects.getInstance().getSharedObject().data;
		}
		
		public function saveDataToDisk():void {
			SharedObjects.getInstance().saveObjectToDisk(savedData);
		}
		
		public function getProgressData():Array {
			loadSavedData();
			return savedData.progressData;
		}
		
		public function getResourceData():Array {
			loadSavedData();
			return savedData.resourceData;
		}
		
		public function saveProgressData(data:Array):void {
			savedData.progressData = data;
			saveDataToDisk();
		}
		
		public function saveResourceData(data:Array):void {
			savedData.resourceData = data;
			saveDataToDisk();
		}
	}
}
class SingletonEnforcer{}