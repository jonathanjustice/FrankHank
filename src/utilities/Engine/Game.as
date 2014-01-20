package utilities.Engine{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Actors.CameraWindow;
	import utilities.Engine.Combat.PowerupManager;
	import utilities.GraphicsElements.Animation;
	import utilities.Saving_And_Loading.JsonParser;
	import utilities.Screens.GameContainer;
	import utilities.Engine.ResourceManager;
	import utilities.Engine.Builders.LevelBuilder;
	import utilities.Engine.Builders.LootManager;
	import utilities.Engine.Combat.CombatManager;
	import utilities.Engine.Combat.BulletManager;
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Engine.Combat.AnimationManager;
	import utilities.Engine.Combat.SaveDataManager;
	import utilities.Engine.CheatManager;
	import utilities.Audio.SoundManager;
	import utilities.Actors.Avatar;
	import utilities.Mathematics.QuadTree;
	import utilities.dataModels.LevelProgressModel;
	import utilities.dataModels.ResourceModel;
	import utilities.Engine.Combat.AnimationManager;
	import utilities.Actors.GameBoardPieces.Art;
	import utilities.customEvents.*;
	import utilities.Input.KeyInputManager;
	
	public class Game extends MovieClip{
		public static var theGame:Game;
		public static var lives:int = 3;
		public static var coins:int = 0;
		public static var originaLives:int = 3;
		public static var resourceManager:ResourceManager;
		public static var powerupManager:PowerupManager;
		public static var animationManager:AnimationManager;
		public static var avatarManager:AvatarManager;
		public static var bulletManager:BulletManager;
		public static var enemyManager:EnemyManager;
		public static var combatManager:CombatManager;
		public static var lootManager:LootManager;
		public static var levelBuilder:LevelBuilder;
		public static var levelManager:LevelManager;
		public static var soundManager:SoundManager;
		public static var saveDataManager:SaveDataManager;
		public static var cheatManager:CheatManager;
		public static var avatar:Avatar;
		private static var quadTree:QuadTree;
		private static var gamePaused:Boolean = true;
		private static var framesSinceGameStart:int = 0;
		private static var cameraWindow:CameraWindow;
		private static var gameState:String = "boot";
		private static var bg_speed_0:Number = 0;
		private static var bg_speed_1:Number = -0.25;
		private static var bg_speed_2:Number = -0.35;
		public static var jsonParser:JsonParser;
		private static var lerpMultiplier:Point = new Point;
		private static var lerpMultiplier_followAvatar:Number = .35;
		private static var lerpMultiplier_cameraLock:Number = .05;
		
		public var desiredX:Number = 0;
		public var desiredY:Number = 0;
		public var lerping:Boolean = false;
		//public var player:Player;
		public var hero:MovieClip;
		//Not adding objects directly to stage so that I can manipulate the world globally when needed
		//usually for things like zooming in and out, recentering the camera, etc.
		public static var gameContainer:MovieClip;
		
		public function Game():void {
			originaLives = lives;
			theGame = this;
			createGameContainer();
			setUpCameraWindow();
			createQuadTree();
			jsonParser = new JsonParser();
			Main.theStage.addEventListener(StateMachineEvent.TEST_EVENT, testEvent);
			Main.theStage.addEventListener(StateMachineEvent.BOOT, boot);
		}
		
		public function testEvent(e:StateMachineEvent):void {
			//trace("testEvent Fired in Game!")
		}
		
		public function boot(e:StateMachineEvent):void {
			//trace("boot Fired in Game!")
		}
		
		public static function setGameState(newState:String,filePathName:String =""):void {
			gameState = newState;
			switch(gameState) {
				case "boot":
					//doshit
					break;
				case "startScreen":
					UIManager.openStartScreen();
					resetGameValues();
					break;
				case "continueCodeScreen":
					UIManager.openContinueCodeScreen();
					resetGameValues();
					break;
				case "startLevelLoad":
					//doshit
					//trace("startLevelLoad");
					UIManager.getInstance().openLoadingScreen();
					LevelManager.getInstance().loadLevel();
					
					break;
				case "levelCurrentlyLoading":
					//trace("levelCurrentlyLoading");
					break;
				case "levelFullyLoaded":
					//trace("levelFullyLoaded");
					LevelManager.getInstance().setIsLevelActive(true);
					UIManager.getInstance().openLivesScreen();
					UIManager.getInstance().closeLoadingScreen();
					enableMasterLoop();
					setLerpMultiplier(lerpMultiplier_followAvatar, lerpMultiplier_followAvatar);
					UIManager.getInstance().getLivesScreen().setScreenVisibility(true);
					break;
				case "inLevel":
					//doshit
					break;
				case "lockCamera":
					setLerpMultiplier(lerpMultiplier_cameraLock, lerpMultiplier_cameraLock);
					//everything else is the same, just camera doesn't track
					break;
					//in engine cutscenes
				case "activateBoss":
					//trace("do boss stuff son");
					setLerpMultiplier(lerpMultiplier_cameraLock, lerpMultiplier_cameraLock);
					//setLerpMultiplier(lerpMultiplier_cameraLock, lerpMultiplier_cameraLock);
					//everything else is the same, just camera doesn't track
					break;
					//in engine cutscenes
					
					
					
					
					
				case "lockCameraAndAutomateAvatar":
					KeyInputManager.setIsKeysEnabled(false);
					setLerpMultiplier(lerpMultiplier_cameraLock, lerpMultiplier_cameraLock);
					var cameraLockZone:MovieClip = LevelManager.getInstance().getTriggers_cameraLocks()[0];
					var actorPoint:Point = new Point();
					actorPoint.x = cameraLockZone.x + cameraLockZone.width/2;
					actorPoint.y = cameraLockZone.y + cameraLockZone.height / 2;
					//trace("actorPoint",actorPoint)
					//actorPoint = cameraLockZone.parent.localToGlobal(actorPoint);
					AvatarManager.getAvatar().setLerpTarget(actorPoint);
					AvatarManager.getAvatar().setLerping(true);
					//doshit
					break;
				case "unlockAvatar":
					KeyInputManager.setIsKeysEnabled(true);
					setLerpMultiplier(lerpMultiplier_cameraLock, lerpMultiplier_cameraLock);
					//var cameraLockZone:MovieClip = LevelManager.getInstance().getTriggers_cameraLocks()[0];
				//	var actorPoint:Point = new Point();
					//actorPoint.x = cameraLockZone.x + cameraLockZone.width/2;
					//actorPoint.y = cameraLockZone.y + cameraLockZone.height / 2;
					//trace("actorPoint",actorPoint)
					//actorPoint = cameraLockZone.parent.localToGlobal(actorPoint);
					//AvatarManager.getAvatar().setLerpTarget(actorPoint);
					//AvatarManager.getAvatar().setLerping(true);
					//doshit
					break;
					
					
					
					
					
					
				case "levelComplete":
					LevelManager.getInstance().setIsLevelActive(false);
					UIManager.getInstance().openLevelCompleteScreen();
					LevelManager.getInstance().setIsLevelComplete(false);
					break;
				case "died":
					//doshit
					break;
				case "levelFailed":
					//trace("setGameState: level failed ");
					disableMasterLoop();
					UIManager.getInstance().removeLivesScreen();
					LevelManager.getInstance().levelFailed();
					
					break;
				case "gameOver":
					//trace("setGameState: gameOver");
					LevelManager.getInstance().setIsLevelComplete(false);
					UIManager.getInstance().removeLivesScreen();
					UIManager.getInstance().openGameOverScreen();
					LevelManager.getInstance().setIsLevelComplete(true);
				
					break;
				case "gameWon":
					//doshit
					break;
					
					
					
				/*  in-level cutscenes  */
				case "startInGameCutScene":
					//doshit
					//trace("Game: startInGameCutScene");
					//trace("Game: filePathName",filePathName);
					disableMasterLoop();
					CutSceneManager.getInstance().loadInGameCutScene(filePathName);
					//trace("Game: startInGameCutScene");
					break;	
					
				case "cutSceneCurrentlyLoading_Trigger":
					
					break;
					
				/* capstone cutScenes */
				case "startIntroCutSceneLoad":
					//doshit
					trace("Game: startIntroCutSceneLoad : 1");
					disableMasterLoop();
					CutSceneManager.getInstance().loadCutScene("swf_cutScene_intro");
					trace("Game: startIntroCutSceneLoad : 2");
					break;
				case "startCutSceneLoad":
					UIManager.getInstance().getLivesScreen().setScreenVisibility(false);
					//doshit
					//trace("Game: startCutSceneLoad");
					disableMasterLoop();
					CutSceneManager.getInstance().loadSceneBasedOnLevelProgress();
					
					break;
				case "cutSceneCurrentlyLoading":
					//trace("Game: cutSceneCurrentlyLoading");
					break;
				case "cutSceneFullyLoaded":
					//trace("Game: cutSceneFullyLoaded");
					CutSceneManager.getInstance().setIsSceneActive(true);
					//enableMasterLoop();
					break;
				case "inCutScene":
					//trace("Game: inCutScene");
					//doshit
					break;
				case "cutSceneComplete":
					//trace("Game: cutSceneComplete");
					CutSceneManager.getInstance().setIsSceneActive(false);
					CutSceneManager.getInstance().setIsSceneComplete(false);
					if (LevelManager.getInstance().getIsLevelComplete() == false) {
						enableMasterLoop();
					}else if (LevelManager.getInstance().getIsLevelComplete() == true) {
						//trace("ELSE level is marked as completed");
						UIManager.getInstance().openLevelCompleteScreen();	
					}
					break;
				case "inLevelCutScene":
					//trace("Game: inLevelCutScene");
					UIManager.getInstance().openLetterBox();
					//CutSceneManager.getInstance().setIsSceneActive(true);
					//enableMasterLoop();
					break;
				case "worldMap":
					//doshit
					break;
					
					
			}
		}
		
		public static function getGameState():String {
			return gameState;
		}
		
		private static function createGameContainer():void {
			gameContainer = new utilities.Screens.GameContainer();
			Main.theStage.addChildAt(gameContainer,0);
			
		}
		
		private static function setUpCameraWindow():void {
			cameraWindow = new CameraWindow();
			Main.theStage.addChild(cameraWindow);
		}
		
		private static function createQuadTree():void{
			quadTree = new utilities.Mathematics.QuadTree();
		}
		
		private static function resetGameValues():void {
			setLives(originaLives);
			LevelManager.getInstance().setIsLevelFailed(false);
			//AvatarManager.getInstance().getAvatar().resetHealth();
		}
		
		//star the game from various places, such as a loaded game, new game, restarted game, etc.
		public static function startGame(startLocation:String):void {
			
			switch(startLocation){
				case "debug":
					
					//trace("Started Game: From debug method");
					createManagersAndControllers();
					setGameState("startLevelLoad")
					break;
				case "introCutScene":
					//trace("Started Game: From the Start Screen");
					createManagersAndControllers();
					setGameState("startLevelLoad")
					break;
					
				case "start":
					//trace("Started Game: From the Start Screen");
					createManagersAndControllers();
					setGameState("startLevelLoad")
					break;
				case "pause":
					enableMasterLoop();
					break;
				case "restart":
					//stop the loop while I clear everything out of it
					disableMasterLoop();
					//clear everything so it can be resetup
					clearGame();
					//recreate everything
					//restart the loop
					enableMasterLoop();
					break;
			}
			Main.returnFocusToGampelay();
		}
		
		public static function getFramesSinceGameStart():int {
			return framesSinceGameStart;
		}
		
		public static function setFramesSinceGameStart():void {
			framesSinceGameStart = 0;
		}
		
		public static function enableMasterLoop():void {
			//trace("enabling master loop");
			gamePaused=false;
			gameContainer.addEventListener(Event.ENTER_FRAME, masterLoop);
		}
		
		public static function disableMasterLoop():void{
			gamePaused=true;
			gameContainer.removeEventListener(Event.ENTER_FRAME, masterLoop);
		}
		
		//clear everything out of the arrays
		//useful for restarting a level or the game
		public static function clearGame():void{
			
		}
		
		private static function createManagersAndControllers():void {
			LevelProgressModel.getInstance();
			PowerupManager.getInstance();
			AnimationManager.getInstance();
			ResourceManager.getInstance();
			LevelManager.getInstance();
			LevelBuilder.getInstance();
			AvatarManager.getInstance();
			BulletManager.getInstance();
			EnemyManager.getInstance();
			CombatManager.getInstance();
			LootManager.getInstance();
			SoundManager.getInstance();
			SaveDataManager.getInstance();
			AnimationManager.getInstance();
			CheatManager.getInstance();
		}
		
		public function shakeCamera():void {
			trace("camera is shaking");
		}
		
		
		public function moveGameContainer(actor:MovieClip):void {
			var cameraBuffer:int = 25;
			var cameraSpeed:int = 12;
			var actorPoint:Point = new Point();
			if (getGameState() == "lockCamera" || getGameState() == "lockCameraAndAutomateAvatar") {
				var cameraLockZone:MovieClip = LevelManager.getInstance().getCameraLockZone();
				//use the trigger block
				actorPoint.x = cameraLockZone.x + cameraLockZone.width/2;
				actorPoint.y = cameraLockZone.y + cameraLockZone.height / 2;
			}else {
				//use the player instead
				actorPoint.x = actor.x;
				actorPoint.y = actor.y;
			}
		
			actorPoint = actor.parent.localToGlobal(actorPoint);
			
			
			//gameContainer.x -= avatar.getVelocity().x;
			
			lerping = false;
			if (actorPoint.x < cameraWindow.x) {
				//trace("LEFT");
				lerping = true;
				desiredX = actorPoint.x;
				lerpX();
			}
			if (actorPoint.x  > cameraWindow.x + cameraWindow.width) {	
				//trace("RIGHT");
				lerping = true;
				desiredX = actorPoint.x - cameraWindow.width;
				lerpX();
			}
			
			if (actorPoint.y < cameraWindow.y) {
				//trace("TOP");
				lerping = true;
				desiredY = actorPoint.y;
				lerpY();
			}
			if (actorPoint.y + actor.height  > cameraWindow.y + cameraWindow.height) {	
				//trace("BOTTOM");
				lerping = true;
				desiredY = actorPoint.y + actor.height - cameraWindow.height;
				lerpY();
			}
			//lerpToPosition();
		}
		
		public static function setLerpMultiplier(newXMultiplier:Number, newYMultiplier:Number):void {
			lerpMultiplier.x = newXMultiplier;
			lerpMultiplier.y = newYMultiplier;
		}
		
		public function lerpY():void {
			if(lerping){
				var lerpAmountY:Number = (cameraWindow.y - desiredY) * lerpMultiplier.y;
				gameContainer.y += lerpAmountY;
			}
		}
		
		public function lerpX():void {
			if (lerping) {
				var lerpAmountX:Number = (cameraWindow.x - desiredX) * lerpMultiplier.x;
				gameContainer.x += lerpAmountX;
				for (var i:int = 0; i < LevelManager.arts.length; i++ ) {
				//trace(LevelManager.arts[i].getParallaxLevel());
					switch(LevelManager.arts[i].getParallaxLevel()) {
						case 0:
							//art += cameraSpeed;
							break;
						case 1:
							LevelManager.arts[i].x += lerpAmountX * bg_speed_1;
							break;
						case 2:
							LevelManager.arts[i].x += lerpAmountX * bg_speed_2;
							break;
					}
				}
			}
		}
		
		public static function resetGameContainerCoordinates():void {
			//trace("resetGameContainerCoordinates");
			gameContainer.x = 0;
			gameContainer.y = 0;
		}
		
		private static function masterLoop(event:Event):void {
			//trace("Game: masterLoop: before check for game paused");
			if (!gamePaused) {
				framesSinceGameStart ++;
				//trace("Game: masterLoop: before any update loops");
				AvatarManager.updateLoop();
				BulletManager.updateLoop();
				EnemyManager.updateLoop();
				LootManager.updateLoop();
				//updateCombatManager();
				UIManager.updateLoop();
				LevelManager.getInstance().updateLoop();
				CheatManager.getInstance().updateLoop();
				EffectsManager.getInstance().updateLoop();
			}else{
				//can use this section for when the game is paused but I still need to update UI stuff
			}
		}
		
		public static function getLives():int {
			return lives;
		}
		
		public static function getCoins():int {
			coins = ResourceModel.getInstance().getCoins();
			return coins;
		}
		
		public static function getContinueCode():String {
			var continueCode:String = "sddf-sdfsdfsdf-asdasdasd"
			return continueCode;
		}
		
		public static function setLives(newAmount:int):void {
			lives = newAmount;
			if (lives <= 0 ){
				//do game over stuff
			}
		}
		
		//pause the update loops
		//pause any other specific things like, spawnTimes, decayRates etc. that are dependent on getTimer
		public static function pauseGame():void{
			gamePaused = true;
			BulletManager.getInstance().pauseAllBulletTimes()
		}
		
		public static function resumeGame():void{
			gamePaused = false;
			BulletManager.getInstance().resumeAllBulletTimes();
		}
		
		public static function getBulletManager():Object{
			return BulletManager.getInstance();
		}
		
		public static function getGameContainer():MovieClip{
			return gameContainer;
		}
		
		public static function getGameContainerCoordinates():Point{
			var gameContainerPoint:Point = new Point(gameContainer.x,gameContainer.y);
			return gameContainerPoint;
		}
		
		public static function deselectAllActors():void {
			//trace("Game: deselectAllActors");
			AvatarManager.getInstance().deselectActors();
			//trace("EnemyManager:",EnemyManager);
			//EnemyManager.getInstance().deselectActors();
		}
		
		public static function getAnimationManager():AnimationManager {
			return animationManager;
		}
		
		public function getJsonParser():JsonParser {
			return jsonParser;
		}
	}
}