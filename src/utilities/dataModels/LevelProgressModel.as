package utilities.dataModels {
	import utilities.Saving_And_Loading.SharedObjects;
	import utilities.Saving_And_Loading.SavedData;
	public class LevelProgressModel {
		private var midMissionProgress:int = 0;
		private var completedMissionsProgress:int = 0;
		private var remainingLives:int = 0;
		private var remainingContinues:int = 0;
		private static var _instance:LevelProgressModel;
		private var progressData:Array = new Array();
		public function LevelProgressModel(singletonEnforcer:SingletonEnforcer){
			setUp();			
		}
			
		private function setUp():void {
			
		}
		
		private function upadteSavedDatas():void {
			progressData = [midMissionProgress, completedMissionsProgress, remainingLives, remainingContinues];
			//SharedObjects.getInstance().getSharedObject();
			//SharedObjects.getInstance().saveObjectToDisk(savedDatas);
			//SharedObjects.getInstance().getSharedObject();
			SavedData.getInstance().saveProgressData(progressData);
		}
		
		public function loadSavedData():void {
			//return midMissionProgress;
			progressData = SavedData.getInstance().getProgressData();
		}
		
		public static function getInstance():LevelProgressModel {
			if(LevelProgressModel._instance == null){
				LevelProgressModel._instance = new LevelProgressModel(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function getMidMissionProgress():int {
			return midMissionProgress;
		}
		
		public function getCompletedMissionsProgress():int {
			return completedMissionsProgress;
		}
		
		public function getRemainingLives():int {
			return remainingLives;
		}
		
		public function getRemainingContinues():int {
			return remainingContinues;
		}
		
		public function setMidMissionProgress(progress:int):void {
			midMissionProgress = progress;
			upadteSavedDatas();
		}
		
		public function setCompletedMissionsProgress(progress:int):void {
			completedMissionsProgress = progress;
			upadteSavedDatas();
		}
		
		public function setRemainingLives(progress:int):void {
			remainingLives = progress;
			upadteSavedDatas();
		}
		
		public function setRemainingContinues(progress:int):void {
			remainingContinues = progress;
			upadteSavedDatas();
		}
	}
}
class SingletonEnforcer{}