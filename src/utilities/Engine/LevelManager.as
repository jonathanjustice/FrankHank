package utilities.Engine{
	import flash.display.MovieClip;
	import utilities.Actors.SelectableActor;
	import utilities.Engine.DefaultManager;
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Engine.Combat.BulletManager;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Engine.Combat.PowerupManager;
	import utilities.Engine.Builders.LootManager;
	import utilities.Actors.GameBoardPieces.Level;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Actors.GameBoardPieces.Terrain;
	import utilities.dataModels.LevelProgressModel;
	import utilities.Actors.Coin;
	import utilities.Actors.Loot;
	import flash.geom.Point;
	public class LevelManager extends BasicManager implements IManager{
		private var tempArray:Array = new Array();
		public static var level:MovieClip;
		public static var levels:Array;
		public static var walls:Array;
		public static var arts:Array;
		public static var coins:Array;
		public static var savePoints:Array;
		private var isLevelComplete:Boolean = false;
		private static var _instance:LevelManager;
		private var isLevelActive:Boolean = false;
		
		//Singleton Design Pattern features
		public function LevelManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public function setUp():void {
			walls = [];
			levels = [];
			arts = [];
			coins = [];
			savePoints = [];
		}
		
		public static function getInstance():LevelManager {
			if(LevelManager._instance == null){
				LevelManager._instance = new LevelManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		//Interface features
		public function getWalls():Array{
			return walls;
		}
		
		public function getArts():Array{
			return arts;
		}
		
		public function getLevels():Array{
			return levels;
		}
		
		public function getCoins():Array{
			return coins;
		}
		
		public function getSavePoints():Array {
			return savePoints;
		}
		
		public function getLevelLocation():Point{
			return levels[0].getLevelLocation();
		}
		
		//this doesn't run for now, may never need to.....
		public function updateLoop():void{
			/*for each(var level:Level in levels){
				level.updateLoop();
			}*/
			for each(var loot:Loot in coins){
				loot.updateLoop();
			}
			/*for each(var savePoint:SavePoint in savePoints){
				savePoint.updateLoop();
			}*/
			//checkLevelObjectives();
			LevelManager._instance.checkLevelObjectives();
		}
		
		public function checkLevelObjectives():void {
			//print("check level objectives");
			//check each level objective to see if its complete
			
			//if all objectives are complete, then stop the level, destroy everything in it, and create a new one
			if (LevelManager._instance.getIsLevelComplete() == true) {
				LevelManager._instance.levelCompleted();
			}
		}
		
		public function setIsLevelActive(activeStatus:Boolean):void {
			isLevelActive = activeStatus;
			//trace(("isLevelActive:",String(isLevelActive)));
		}
		
		public function getisLevelActive():Boolean {
			return isLevelActive;
		}
		
		private function levelCompleted():void {
			//trace("LevelManager: Level completed: EnemyManager.enemies", EnemyManager.enemies);
			if (EnemyManager.enemies.length == 0) {
				//trace("LevelManager:levelCompleted");
				//trace("enemy manager: no enemies left");
				//trace("EnemyManager.enemies", EnemyManager.enemies);
				Game.disableMasterLoop();
				LootManager.getInstance().destroyArray(LootManager.lootDrops);
				LootManager.getInstance().destroyArray(LootManager.treasureChests);
				EnemyManager.getInstance().destroyArray(EnemyManager.enemies);
				LevelManager.getInstance().destroyArray(LevelManager.arts);
				LevelManager.getInstance().destroyArray(LevelManager.coins);
				LevelManager.getInstance().destroyArray(LevelManager.savePoints);
				PowerupManager.getInstance().destroyArray(PowerupManager.powerups);
				BulletManager.getInstance().destroyArray(BulletManager.bullets);
				AvatarManager.getInstance().destroyArray(AvatarManager.avatars);
				LevelManager.getInstance().destroyArray(LevelManager.levels);
				LevelManager.getInstance().destroyArray(LevelManager.walls);
				Game.resetGameContainerCoordinates();
				LevelProgressModel.getInstance().setCompletedMissionsProgress(LevelProgressModel.getInstance().getCompletedMissionsProgress() + 1);
				//loadMissionCompleteScreen
				//loadLevel();
				Game.setGameState("startCutSceneLoad");
				Game.setFramesSinceGameStart();
				LevelManager._instance.setIsLevelComplete(false)
			}
		}
		
		public function loadMissionCompleteScreen():void {
			
		}
		
		public function loadLevel():void {
			var levelName:String = String(LevelProgressModel.getInstance().getCompletedMissionsProgress() + 1 );
			levelName = "lvl_" + levelName;
			//print("levelName:" +levelName);
			level = new utilities.Actors.GameBoardPieces.Level(levelName);
			levels.push(level);
			Game.setGameState("levelCurrentlyLoading"); 
		}
		
		public function deselectActors():void {
			//print("levels:", levels);
			for (var i:int = 1; i < walls.length; i++) {
				walls[i].deselectActor();
			}
		}
		
		public function getLevel():Object{
			return levels[0];
		}
		
		public function getIsLevelComplete():Boolean{
			return isLevelComplete;
		}
		
		public function setIsLevelComplete(completeState:Boolean):void{
			isLevelComplete = completeState;
		}
	}
}

class SingletonEnforcer{}
