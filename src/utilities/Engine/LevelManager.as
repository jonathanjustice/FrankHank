﻿package utilities.Engine{
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
		private var isLevelComplete:Boolean = false;
		private static var _instance:LevelManager;
		
		//Singleton Design Pattern features
		public function LevelManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public function setUp():void{
			levels =[];
			createLevel();
			//create_a_bunch_of_walls_forTesting();
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
		
		
		
		public function create_a_bunch_of_walls_forTesting():void{
			var theX:Number = 25;
			var theY:Number = 225;
			for(var i:int=0;i<1;i++){
				theX+=200;
				theY+=100;
				var wall:Wall = new Wall();
				wall.x=theX;
				wall.y=theY;
				levels.push(wall);
				wall.setPreviousPosition();
			}
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
			trace("shit broke");
			//trace("check level objectives");
			//check each level objective to see if its complete
			
			//if all objectives are complete, then stop the level, destroy everything in it, and create a new one
			if (LevelManager._instance.getIsLevelComplete() == true) {
				LevelManager._instance.levelCompleted();
			}
		}
		
		private function levelCompleted():void {
			trace("EnemyManager.enemies", EnemyManager.enemies);
			if (EnemyManager.enemies.length == 0) {
				trace("enemy manager: no enemies left");
				trace("EnemyManager.enemies", EnemyManager.enemies);
				Game.disableMasterLoop();
				LootManager.getInstance().destroyArray(LootManager.lootDrops);
				LootManager.getInstance().destroyArray(LootManager.treasureChests);
				EnemyManager.getInstance().destroyArray(EnemyManager.enemies);
				//PowerupManager.getInstance().destroyArray(PowerupManager.powerups);
				//BulletManager.getInstance().destroyArray(BulletManager.bullets);
				//AvatarManager.getInstance().destroyArray(AvatarManager.avatars);
				//BulletManager.destroyArray(getArray());
				//AvatarManager.destroyArray(getArray());
				//PowerupManager.destroyArray(getArray());
				
			}
		}
		
		private static function createLevel():void{
			level = new utilities.Actors.GameBoardPieces.Level();
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
