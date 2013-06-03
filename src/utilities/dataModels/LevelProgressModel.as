package utilities.dataModels {
	public class LevelProgressModel {
		private var midMissionProgress:int = 0;
		private var completedMissionsProgress:int = 0;
		private var remainingLives:int = 0;
		private var remainingContinues:int = 0;
		private static var _instance:LevelProgressModel;
		public function LevelProgressModel(singletonEnforcer:SingletonEnforcer){
			setUp();			
		}
			
		private function setUp():void {
			
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
		}
		
		public function setCompletedMissionsProgress(progress:int):void {
			completedMissionsProgress = progress;
		}
		
		public function setRemainingLives(progress:int):void {
			remainingLives = progress;
		}
		
		public function setRemainingContinues(progress:int):void {
			remainingContinues = progress;
		}
	}
}
class SingletonEnforcer{}