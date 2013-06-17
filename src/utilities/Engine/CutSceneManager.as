package utilities.Engine{
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Actors.SelectableActor;
	import utilities.Engine.DefaultManager;
	import utilities.Screens.GameScreens.CutScene
	import utilities.Actors.GameBoardPieces.Level;
	import flash.events.Event;
	
	import utilities.dataModels.LevelProgressModel;
	import flash.geom.Point;
	public class CutSceneManager extends BasicManager implements IManager{
		public var cutScenes:Array = new Array();
		public static var scene:MovieClip;
		private var isSceneComplete:Boolean = false;
		private static var _instance:CutSceneManager;
		private var isSceneActive:Boolean = false;
		
		//Singleton Design Pattern features
		public function CutSceneManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public function setUp():void{
			
		}
		
		public static function getInstance():CutSceneManager {
			if(CutSceneManager._instance == null){
				CutSceneManager._instance = new CutSceneManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		//Interface features
		public function getArray():Array{
			return cutScenes;
		}
		
		//this doesn't run for now, may never need to.....
		public function updateLoop():void{
			/*for each(var level:Level in levels){
				level.updateLoop();
			}*/
			
			CutSceneManager._instance.checkLevelObjectives();
		}
		
		public function checkLevelObjectives():void {
			//trace("check level objectives");
			//check each level objective to see if its complete
			
			//if all objectives are complete, then stop the level, destroy everything in it, and create a new one
			if (CutSceneManager._instance.getIsSceneComplete() == true) {
				CutSceneManager._instance.sceneCompleted();
			}
		}
		
		public function setIsSceneActive(activeStatus:Boolean):void {
			isSceneActive = activeStatus;
			//print(("isSceneActive: " + String(isSceneActive)));
			cutScenes[0].addEventListener(Event.ENTER_FRAME, playCutScene);
			cutScenes[0].getActorGraphic().assignedGraphics[0].swf_child.play();
		}
		
		public function playCutScene(e:Event):void {
			if (cutScenes[0].checkForCutSceneComplete() == true) {
				cutScenes[0].removeEventListener(Event.ENTER_FRAME, playCutScene);
				sceneCompleted();
				cutScenes = [];
			}
		}
		
		public function getisSceneActive():Boolean {
			return isSceneActive;
		}
		
		private function sceneCompleted():void {
			//trace("LevelManager: Level completed: EnemyManager.enemies", EnemyManager.enemies);
			
			//Game.resetGameContainerCoordinates();
			//loadMissionCompleteScreen
			//loadLevel();
			Game.setGameState("sceneComplete");
			Game.setGameState("startLevelLoad");
			//Game.setFramesSinceGameStart();
			
		}
		
		public function loadMissionCompleteScreen():void {
			
		}
		
		public function loadScene():void {
			//print("loadScene");
			var sceneName:String = String(LevelProgressModel.getInstance().getCompletedMissionsProgress());
			sceneName = "ui_cutScene_" + sceneName;
			//print(sceneName);
			scene = new utilities.Screens.GameScreens.CutScene(sceneName);
			cutScenes.push(scene);
			Game.setGameState("cutSceneCurrentlyLoading"); 
		}
		
		public function deselectActors():void {
			//trace("levels:", levels);
			for (var i:int = 1; i < cutScenes.length; i++) {
				cutScenes[i].deselectActor();
			}
		}
		
		public function getIsSceneComplete():Boolean{
			return isSceneComplete;
		}
		
		public function setIsSceneComplete(completeState:Boolean):void{
			isSceneComplete = completeState;
		}
	}
}

class SingletonEnforcer{}
