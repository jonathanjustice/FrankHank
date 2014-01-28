package utilities.Engine{
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Actors.SelectableActor;
	import utilities.Engine.DefaultManager;
	import utilities.Screens.GameScreens.CutScene
	import utilities.Actors.GameBoardPieces.Level;
	import flash.events.Event;
	import utilities.customEvents.*;
	
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
				playMusicBasedOnSceneName(currentCutSceneName);
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
		
		//based on arbitrary scene name passed in
		public function loadCutScene(newSceneName:String ):void {
			currentCutSceneName = newSceneName;
			var sceneName:String = newSceneName;
			//print(sceneName);
			loadSceneFromName(sceneName);
			Game.setGameState("cutSceneCurrentlyLoading"); 
		}
		
		public function loadInGameCutScene(newSceneName:String ):void {
			currentCutSceneName = newSceneName;
			var sceneName:String = "swf_cutScene_level_" + newSceneName + "_mid";
			loadSceneFromName(sceneName);
			Game.setGameState("cutSceneCurrentlyLoading_Trigger"); 
		}
		
		public function loadSceneBasedOnLevelProgress():void {
			var sceneName:String = String(LevelProgressModel.getInstance().getCompletedMissionsProgress());
			currentCutSceneName = sceneName;
			sceneName = "swf_cutScene_" + sceneName;
			loadSceneFromName(sceneName);
			Game.setGameState("cutSceneCurrentlyLoading"); 
		}
		
		public function loadSceneFromName(sceneName:String):void {
			Main.theStage.dispatchEvent(new SoundEvent("SOUND_FADE_OUT","ALL"));
			scene = new utilities.Screens.GameScreens.CutScene(sceneName);
			currentCutSceneName = sceneName;
			cutScenes.push(scene);
		}
		
		private function playMusicBasedOnSceneName(sceneName:String):void {
			switch(sceneName) {
				case "swf_cutScene_intro":
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","CUTSCENE_SONG_1"));
					break;
				case "swf_cutScene_1":
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","CUTSCENE_SONG_2"));
					break;
				case "swf_cutScene_2":
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","CUTSCENE_SONG_2"));
					break;
				case "swf_cutScene_3":
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","CUTSCENE_SONG_2"));
					break;
				case "swf_cutScene_4":
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","CUTSCENE_SONG_2"));
					break;
				case "swf_cutScene_5":
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","CUTSCENE_SONG_2"));
					break;
				case "swf_cutScene_level_1_mid":
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","CUTSCENE_SONG_2"));
					break;
			}
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
