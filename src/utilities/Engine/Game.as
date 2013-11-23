package utilities.Engine{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Actors.CameraWindow;
	import utilities.Engine.Combat.PowerupManager;
	import utilities.GraphicsElements.Animation;
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
	import utilities.Engine.Combat.AnimationManager;
	import utilities.Actors.GameBoardPieces.Art;
	
	public class Game extends MovieClip{
		public static var theGame:Game;
		public static var lives:int = 3;
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
					
					break;
				case "inLevel":
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
					trace("setgamestate: level failed ");
					disableMasterLoop();
					UIManager.getInstance().removeLivesScreen();
				//	LevelManager.getInstance().setIsLevelActive(false);
				//	UIManager.getInstance().openLevelFailedScreen();
					LevelManager.getInstance().levelFailed();
					
					break;
				case "gameOver":
					trace("setGameState: gameOver");
					LevelManager.getInstance().setIsLevelComplete(false);
					UIManager.getInstance().removeLivesScreen();
					UIManager.getInstance().openGameOverScreen();
					LevelManager.getInstance().setIsLevelComplete(true);
					break;
				case "gameWon":
					//doshit
					break;
					
				/*  in-engine cutscenes  */
					
					
				/*  in-level cutscenes  */
				case "startInGameCutScene":
					//doshit
					disableMasterLoop();
					CutSceneManager.getInstance().loadInGameCutScene(filePathName);
					//trace("Game: startInGameCutScene");
					break;	
					
				case "cutSceneCurrentlyLoading_Trigger":
					
					break;
					
				/* capstone cutScenes */
				case "startCutSceneLoad":
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
					trace("LevelManager.getInstance().getIsLevelComplete == true",LevelManager.getInstance().getIsLevelComplete == true);
					if (LevelManager.getInstance().getIsLevelComplete() == false) {
						enableMasterLoop();
					}else if (LevelManager.getInstance().getIsLevelComplete() == true) {
						trace("ELSE level is marked as completed");
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
			trace("enabling master loop");
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
		
		
		public function moveGameContainer(avatar:MovieClip):void {
			var cameraBuffer:int = 25;
			var cameraSpeed:int = 12;
			var avatarVels:Point = new Point();
			avatarVels = avatar.getVelocity();
			//print(String(avatarVels));
			var avatarPoint:Point = new Point();
			avatarPoint.x = avatar.x;
			avatarPoint.y = avatar.y;
			avatarPoint = avatar.parent.localToGlobal(avatarPoint);
			
			if(avatarVels.x > 0){
				cameraWindow.scaleToMotion("right");
			}
			if(avatarVels.x < 0){
				cameraWindow.scaleToMotion("left");
			}
			//running left
			if (avatarPoint.x < cameraWindow.x) {
				
				if (avatarPoint.x < cameraWindow.x - cameraBuffer) {
					if (avatarVels.x >= 0) {
						//do nothing
					}else {
						//trace("moving left");
						gameContainer.x += cameraSpeed;
						
					}
					//
				}
				gameContainer.x -= avatar.getVelocity().x;
				for (var i:int = 0; i < LevelManager.arts.length; i++ ) {
					//trace(LevelManager.arts[i].getParallaxLevel());
					switch(LevelManager.arts[i].getParallaxLevel()) {
						case 0:
							//art += cameraSpeed;
							break;
						case 1:
							LevelManager.arts[i].x -= avatar.getVelocity().x * bg_speed_1;
							break;
						case 2:
							LevelManager.arts[i].x -= avatar.getVelocity().x * bg_speed_2;
							break;
					}
				}
			}
			//running right
			if (avatarPoint.x + avatar.width > cameraWindow.x + cameraWindow.width ) {
				if (avatarPoint.x + avatar.width > cameraWindow.x + cameraWindow.width + cameraBuffer) {
					if (avatarVels.x <= 0) {
						//do nothing
					}else {
						//trace("moving right");
						
						gameContainer.x -= cameraSpeed;
					}
				}
				gameContainer.x -= avatar.getVelocity().x;
				for (var j:int = 0; j < LevelManager.arts.length; j++ ) {
				//	trace(LevelManager.arts[j].getParallaxLevel());
					switch(LevelManager.arts[j].getParallaxLevel()) {
						case 0:
							//art += cameraSpeed;
							break;
						case 1:
							LevelManager.arts[j].x -= avatar.getVelocity().x * bg_speed_1;
							break;
						case 2:
							LevelManager.arts[j].x -= avatar.getVelocity().x * bg_speed_2;
							break;
					}
				}
			}
		
			if (avatarPoint.y < cameraWindow.y) {
				trace("touching top of screen");
				trace(avatar.getAdditionalYVelocity());
				gameContainer.y -= avatar.getVelocity().y + avatar.getAdditionalYVelocity()*10;
				
			}
			if (avatarPoint.y + avatar.height > cameraWindow.y + cameraWindow.height) {
				gameContainer.y -= avatar.getVelocity().y + avatar.getAdditionalYVelocity()*10;
				
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
				//trace("Game: masterLoop: AvatarManager");
				BulletManager.updateLoop();
				//trace("Game: masterLoop: BulletManager");
				EnemyManager.updateLoop();
				//trace("Game: masterLoop: EnemyManager");
				LootManager.updateLoop();
				//trace("Game: masterLoop: LootManager");
				//updateCombatManager();
				UIManager.updateLoop();
				//trace("Game: masterLoop: UIManager");
				LevelManager.getInstance().updateLoop();
				//trace("Game: masterLoop: LevelManager");
				//LevelManager.getInstance().setIsLevelActive(true);
				CheatManager.getInstance().updateLoop();
			}else{
				//can use this section for when the game is paused but I still need to update UI stuff
			}
		}
		
		public static function getLives():int {
			return lives;
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
	}
}