zpackage utilities.Engine{
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
	import utilities.dataModels.ResourceModel;
	import utilities.Actors.Coin;
	import utilities.Actors.Loot;
	import flash.geom.Point;
	import flash.events.*;
	import utilities.customEvents.*;
	public class LevelManager extends BasicManager implements IManager{
		private var tempArray:Array = new Array();
		public static var level:MovieClip;
		public static var levels:Array;
		public static var walls:Array;
		
		public static var triggerableWalls:Array;
		public static var triggers:Array;
		public static var triggers_endZones:Array;
		
		public static var triggers_cutScenes:Array;
		public static var triggers_cameraLocks:Array;
		public static var triggers_activateBosses:Array;
		public static var arts:Array;
		public static var coins:Array;
		public static var savePoints:Array;
		private var isLevelComplete:Boolean = false;
		private var isLevelFailed:Boolean = false;
		private static var _instance:LevelManager;
		private var isLevelActive:Boolean = false;
		private var cameraLockZone:MovieClip = new MovieClip();
		
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
			triggers = [];
			triggerableWalls = [];
			triggers_endZones = [];
			triggers_cutScenes = [];
			triggers_cameraLocks = [];
			triggers_activateBosses = [];
		}
		
		public static function getInstance():LevelManager {
			if(LevelManager._instance == null){
				LevelManager._instance = new LevelManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function activateTriggerableWall(newIndex:int):void {
			//trace("newIndex", newIndex);
			//trace(triggerableWalls);
			//trace(triggerableWalls[newIndex]);
   			triggerableWalls[newIndex].setIsActive(true);
		}
		
		
		//Interface features
		public function getTriggers_cutScenes():Array{
			return triggers_cutScenes;
		}
		
		public function getTriggers_cameraLocks():Array{
			return triggers_cameraLocks;
		}
		
		public function getTriggers_activateBosses():Array{
			return triggers_activateBosses;
		}
		
		public function setCameraLockZone(newLockZone:MovieClip):void {
			cameraLockZone = newLockZone;
		}
		
		public function getCameraLockZone():MovieClip {
			return cameraLockZone;
		}
		
		public function getTriggers_endZones():Array{
			return triggers_endZones;
		}
		
		public function getTriggers():Array{
			return triggers;
		}
		
		public function getWalls():Array{
			return walls;
		}
		
		public function getTriggerableWalls():Array {
			return triggerableWalls;
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
			for each(var wall:MovieClip in walls){
				wall.updateLoop();
			}
			/*for each(var savePoint:SavePoint in savePoints){
				savePoint.updateLoop();
			}*/
			//checkLevelObjectives();
			LevelManager._instance.checkLevelObjectives();
			LevelManager._instance.checkLevelFailed();
		}
		
		public function checkLevelObjectives():void {
			//print("check level objectives");
			//check each level objective to see if its complete
			
			//if all objectives are complete, then stop the level, destroy everything in it, and create a new one
			if (LevelManager._instance.getIsLevelComplete() == true) {
				LevelManager._instance.levelCompleted();
			}
		}
		
		public function checkLevelFailed():void {
			if (LevelManager._instance.getIsLevelFailed() == true) {
				LevelManager._instance.levelFailed();
			}
		}
		
		public function setIsLevelActive(activeStatus:Boolean):void {
			isLevelActive = activeStatus;
			isLevelComplete = false;
			isLevelFailed = false;
		}
		
		public function getisLevelActive():Boolean {
			return isLevelActive;
		}
		
		private function levelCompleted():void {
			ResourceModel.getInstance().updateSavedDatas();
			//trace("levelCompleted");
			clearLevel();
		//	if (EnemyManager.enemies.length == 0) {
				LevelProgressModel.getInstance().setCompletedMissionsProgress(LevelProgressModel.getInstance().getCompletedMissionsProgress() + 1);
				Game.setGameState("startCutSceneLoad");
				
		//	}
		}
		
		public function levelFailed():void {
			ResourceModel.getInstance().updateSavedDatas();
			Game.setLives(Game.getLives() - 1);
			clearLevel();
			if (Game.getLives() >= 0 ) {
				//print("Game.getLives() was >= 0");
				//print("AvatarManager.getInstance()" + String(AvatarManager.getInstance()));
				//LevelManager._instance.setIsLevelComplete(false);
				//LevelManager._instance.setIsLevelActive(false);
				
				LevelProgressModel.getInstance().setCompletedMissionsProgress(LevelProgressModel.getInstance().getCompletedMissionsProgress());
				Game.setGameState("startLevelLoad");
				LevelManager._instance.setIsLevelFailed(false);
			}
			/*else if (Game.getLives() <= 0) {
				setIsLevelFailed(false);
				LevelProgressModel.getInstance().setCompletedMissionsProgress(LevelProgressModel.getInstance().getCompletedMissionsProgress());
				LevelManager._instance.setIsLevelComplete(false);
				//Game.setGameState("startLevelLoad");
			}*/
			
			
		}
		
		private function clearLevel():void {
			Game.disableMasterLoop();
			EffectsManager.getInstance().destroyArray(EffectsManager.effects);
			LootManager.getInstance().destroyArray(LootManager.lootDrops);
			LootManager.getInstance().destroyArray(LootManager.treasureChests);
			EnemyManager.getInstance().destroyArray(EnemyManager.enemies);
			LevelManager.getInstance().destroyArray(LevelManager.arts);
			LevelManager.getInstance().destroyArray(LevelManager.coins);
			LevelManager.getInstance().destroyArray(LevelManager.savePoints);
			LevelManager.getInstance().destroyArray(LevelManager.triggers);
			PowerupManager.getInstance().destroyArray(PowerupManager.powerups);
			BulletManager.getInstance().destroyArray(BulletManager.bullets);
			AvatarManager.getInstance().destroyArray(AvatarManager.avatars);
			LevelManager.getInstance().destroyArray(LevelManager.levels);
			LevelManager.getInstance().destroyArray(LevelManager.walls);
			//LevelManager.getInstance().destroyArray(LevelManager.triggerableWalls);
			LevelManager.getInstance().destroyArray(LevelManager.triggers_endZones);
			LevelManager.getInstance().destroyArray(LevelManager.triggers_cutScenes);
			LevelManager.getInstance().destroyArray(LevelManager.triggers_cameraLocks);
			LevelManager.getInstance().destroyArray(LevelManager.triggers_activateBosses);
			Game.resetGameContainerCoordinates();
			Game.setFramesSinceGameStart();
		}
		
		
		public function loadMissionCompleteScreen():void {
			
		}
		
		
		
		
		public function testEvent(e:StateMachineEvent):void {
			//trace("testEvent Fired!")
		}
		
		public function loadLevel():void {
			//addEventListener(StateMachineEvent.TEST_EVENT, testEvent);
			Main.theStage.dispatchEvent(new StateMachineEvent("testEvent"));
			Main.theStage.dispatchEvent(new StateMachineEvent("boot"));
			
			//Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","bananas"));
			
			LevelManager._instance.setIsLevelComplete(false);
			var levelName:String = String(LevelProgressModel.getInstance().getCompletedMissionsProgress() + 1 );
			levelName = "lvl_" + levelName;
			//print("levelName:" +levelName);
			level = new utilities.Actors.GameBoardPieces.Level(levelName);
			levels.push(level);
			Game.setGameState("levelCurrentlyLoading");
		}
		
		public function deselectActors():void {
			//print("levels:", levels);
			for (var a:int = 1; a < walls.length; a++) {
				walls[a].deselectActor();
			}
			for (var b:int = 1; b < walls.length; b++) {
				walls[b].deselectActor();
			}
		}
		
		public function getLevel():Object{
			return levels[0];
		}
		
		public function getIsLevelComplete():Boolean{
			return isLevelComplete;
		}
	
		public function setIsLevelComplete(completeState:Boolean):void {
			
			//trace("SETTING IS LEVEL COMPLETE");
			//trace(completeState);
			isLevelComplete = completeState;
			//print("setIsLevelComplete");
		}
		
		public function getIsLevelFailed():Boolean{
			return isLevelFailed;
		}
		
		public function setIsLevelFailed(failedState:Boolean):void{
			isLevelFailed = failedState;
		}
	}
}

class SingletonEnforcer{}
