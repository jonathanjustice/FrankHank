package utilities.dataModels {
	import utilities.Saving_And_Loading.SharedObjects;
	import utilities.Saving_And_Loading.SavedData;
	public class ResourceModel {
		private var coins:int = 0;
		private var premiumCoins:int = 0;
		private static var _instance:LevelProgressModel;
		private var resourceData:Array = new Array();
		public function ResourceModel(singletonEnforcer:SingletonEnforcer){
			setUp();			
		}
		
		private function setUp():void {
			
		}
		
		private function upadteSavedDatas():void {
			resourceData = [coins, premiumCoins];
			//SharedObjects.getInstance().getSharedObject();
			//SharedObjects.getInstance().saveObjectToDisk(savedDatas);
			//SharedObjects.getInstance().getSharedObject();
			SavedData.getInstance().saveProgressData(resourceData);
		}
		
		public static function getInstance():LevelProgressModel {
			if(LevelProgressModel._instance == null){
				LevelProgressModel._instance = new LevelProgressModel(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function loadSavedData():int {
			//return midMissionProgress;
			resourceData = SavedData.getInstance().getResourceData();
		}
		
		public function getCoins():int {
			return coins;
		}
		
		public function getPremiumCoins):int {
			return premiumCoins;
		}
		
		public function setCoins(amount:int):void {
			coins = amount;
			upadteSavedDatas();
		}
		
		public function setPremiumCoins(amount:int):void {
			premiumCoins = amount;
			upadteSavedDatas();
		}
	}
}
class SingletonEnforcer{}