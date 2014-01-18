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
		private var currentCutSceneName:String = "";
		
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
				CutSceneManager._instance.cutsceneCompleted();
			}
		}
		
		public function setIsSceneActive(newActiveStatus:Boolean):void {
			isSceneActive = newActiveStatus;
			if(isSceneActive == true){
				cutScenes[0].addEventListener(Event.ENTER_FRAME, playCutScene);
				cutScenes[0].assignedGraphic[0].swf_child.play();
			}
		}
		
		public function playCutScene(e:Event):void {
			if (cutScenes[0].checkForCutSceneComplete() == true) {
				cutScenes[0].removeEventListener(Event.ENTER_FRAME, playCutScene);
				cutsceneCompleted();
				cutScenes = [];
			}
		}
		
		public function getisSceneActive():Boolean {
			return isSceneActive;
		}
		
		private function cutsceneCompleted():void {
			if (currentCutSceneName == "swf_cutScene_intro") {
				Game.startGame("start");
			}else {
				Game.setGameState("cutSceneComplete");
				trace("cutSceneComplete");
				//Game.setGameState("startLevelLoad");
				//Game.setFramesSinceGameStart();
			}
		}
		
		public function loadMissionCompleteScreen():void {
			
		}
		
		public function loadCutScene(newSceneName:String ):void {
			currentCutSceneName = newSceneName;
			var sceneName:String = newSceneName;
			trace("sceneName:---------------------------------------------------------------- ", sceneName );
			//print(sceneName);
			loadSceneFromName(sceneName);
			Game.setGameState("cutSceneCurrentlyLoading"); 
		}
		
		public function loadInGameCutScene(newSceneName:String ):void {
			currentCutSceneName = newSceneName;
			var sceneName:String = "swf_cutScene_level_" + newSceneName + "_mid";
			trace("sceneName:---------------------------------------------------------------- ", sceneName );
			//print(sceneName);
			loadSceneFromName(sceneName);
			Game.setGameState("cutSceneCurrentlyLoading_Trigger"); 
		}
		
		public function loadSceneBasedOnLevelProgress():void {
			//print("loadScene");
			var sceneName:String = String(LevelProgressModel.getInstance().getCompletedMissionsProgress());
			currentCutSceneName = sceneName;
			sceneName = "swf_cutScene_" + sceneName;
			//trace("sceneName: ", sceneName);
			//print(sceneName);
			loadSceneFromName(sceneName);
			Game.setGameState("cutSceneCurrentlyLoading"); 
		}
		
		public function loadSceneFromName(sceneName:String):void {
			scene = new utilities.Screens.GameScreens.CutScene(sceneName);
			currentCutSceneName = sceneName;
			cutScenes.push(scene);
			trace("cutScenes", cutScenes);
			trace("cutScenes[0]", cutScenes[0]);
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
