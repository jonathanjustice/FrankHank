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
	import flash.geom.Point;
	public class LevelManager extends BasicManager implements IManager{
		private var tempArray:Array = new Array();
		public static var level:MovieClip;
		public static var levels:Array;
		public static var arts:Array;
		private var isLevelComplete:Boolean = false;
		private static var _instance:LevelManager;
		
		//Singleton Design Pattern features
		public function LevelManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public function setUp():void{
			levels = [];
			arts = [];
		}
		
		public static function getInstance():LevelManager {
			if(LevelManager._instance == null){
				LevelManager._instance = new LevelManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		//Interface features
		public function getArray():Array{
			return levels;
		}
		
		public function getLevelLocation():Point{
			return levels[0].getLevelLocation();
		}
		
		//this doesn't run for now, may never need to.....
		public function updateLoop():void{
			/*for each(var level:Level in levels){
				level.updateLoop();
			}*/
			//checkLevelObjectives();
			LevelManager._instance.checkLevelObjectives();
		}
		
		public function checkLevelObjectives():void {
			//trace("check level objectives");
			//check each level objective to see if its complete
			
			//if all objectives are complete, then stop the level, destroy everything in it, and create a new one
			if (LevelManager._instance.getIsLevelComplete() == true) {
				LevelManager._instance.levelCompleted();
			}
		}
		
		private function levelCompleted():void {
			//trace("EnemyManager.enemies", EnemyManager.enemies);
			if (EnemyManager.enemies.length == 0) {
				//trace("enemy manager: no enemies left");
				//trace("EnemyManager.enemies", EnemyManager.enemies);
				Game.disableMasterLoop();
				LootManager.getInstance().destroyArray(LootManager.lootDrops);
				LootManager.getInstance().destroyArray(LootManager.treasureChests);
				EnemyManager.getInstance().destroyArray(EnemyManager.enemies);
				LevelManager.getInstance().destroyArray(LevelManager.levels);
				LevelManager.getInstance().destroyArray(LevelManager.arts);
				PowerupManager.getInstance().destroyArray(PowerupManager.powerups);
				BulletManager.getInstance().destroyArray(BulletManager.bullets);
				AvatarManager.getInstance().destroyArray(AvatarManager.avatars);
				Game.resetGameContainerCoordinates();
				createLevel("lvl_03");
				Game.enableMasterLoop();
				Game.setFramesSinceGameStart();//this prevents instant complettions if win condition is met by there being no enemies on the board
			}
		}
		
		public function createLevel(levelName:String):void{
			level = new utilities.Actors.GameBoardPieces.Level(levelName);
			levels.push(level);
		}
		
		public function deselectActors():void {
			//trace("levels:", levels);
			for (var i:int = 1; i < levels.length; i++) {
				levels[i].deselectActor();
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
