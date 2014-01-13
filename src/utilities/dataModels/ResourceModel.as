package utilities.dataModels {
	import flash.geom.Point;
	import utilities.Saving_And_Loading.SharedObjects;
	import utilities.Saving_And_Loading.SavedData;
	import utilities.dataModels.LevelProgressModel;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Engine.Game;
	public class ResourceModel {
		private var coins:int = 0;
		private var coinsRequiredForExtraLife:int = 63;
		private var premiumCoins:int = 0;
		private static var _instance:ResourceModel;
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
			//trace(resourceData);
		}
		
		public static function getInstance():ResourceModel {
			if(ResourceModel._instance == null){
				ResourceModel._instance = new ResourceModel(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function loadSavedData():void {
			//return midMissionProgress;
			resourceData = SavedData.getInstance().getResourceData();
		}
		
		public function getCoins():int {
			return coins;
		}
		
		public function getPremiumCoins():int {
			return premiumCoins;
		}
		
		public function setCoins(amount:int):void {
			coins = amount;
			upadteSavedDatas();
		}
		
		public function addCoins(amount:int):void {
			coins += amount;
			if (coins >= coinsRequiredForExtraLife) {
				//add Extra Life
				Game.setLives(Game.getLives() + 1);
				//play feedback animation thing
				AvatarManager.getInstance().createExtraLifeTextFeecbackText();
				coins -= coinsRequiredForExtraLife;
			}
			upadteSavedDatas();
		}
		
		public function setPremiumCoins(amount:int):void {
			premiumCoins = amount;
			upadteSavedDatas();
		}
		
		public function addPremiumCoins(amount:int):void {
			premiumCoins += amount;
			upadteSavedDatas();
		}
	}
}
class SingletonEnforcer{}