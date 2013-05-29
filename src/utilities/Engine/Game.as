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
	import utilities.Audio.SoundManager;
	import utilities.Actors.Avatar;
	import utilities.Mathematics.QuadTree;
	
	public class Game extends MovieClip{
		public static var theGame:Game;
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
		import utilities.Engine.Combat.AnimationManager;
		public static var avatar:Avatar;
		private static var quadTree:QuadTree;
		private static var gamePaused:Boolean = true;
		private static var framesSinceGameStart:int = 0;
		private static var cameraWindow:CameraWindow;
		
		//public var player:Player;
		public var hero:MovieClip;
		//Not adding objects directly to stage so that I can manipulate the world globally when needed
		//usually for things like zooming in and out, recentering the camera, etc.
		public static var gameContainer:MovieClip;
		
		public function Game():void{
			theGame = this;
			createGameContainer();
			setUpCameraWindow();
			createQuadTree();
		}
		
		private static function createGameContainer():void{
			gameContainer = new utilities.Screens.GameContainer();
			Main.theStage.addChild(gameContainer);
			
		}
		
		private static function setUpCameraWindow():void {
			cameraWindow = new CameraWindow();
			Main.theStage.addChild(cameraWindow);
		}
		
		private static function createQuadTree():void{
			quadTree = new utilities.Mathematics.QuadTree();
		}
		
		//star the game from various places, such as a loaded game, new game, restarted game, etc.
		public static function startGame(startLocation:String):void{
			switch(startLocation){
				case "debug":
				
					trace("Started Game: From debug method");
					createManagersAndControllers();
					LevelManager.getInstance().createLevel("lvl_02");
					enableMasterLoop();
					break;
				case "start":
					trace("Started Game: From the Start Screen");
					createManagersAndControllers();
					trace(LevelManager.getInstance());
					LevelManager.getInstance().createLevel("lvl_02");
					enableMasterLoop();
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
			trace("master loop");
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
		}
		
		
		public function moveGameContainer(avatar:MovieClip):void {
			var cameraBuffer:int = 25;
			var cameraSpeed:int = 12;
			var avatarVels:Point = new Point();
			avatarVels = avatar.getVelocity();
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
			}
			if (avatarPoint.y < cameraWindow.y) {
				gameContainer.y -= avatar.getVelocity().y;
				
			}
			if (avatarPoint.y + avatar.height > cameraWindow.y + cameraWindow.height) {
				gameContainer.y -= avatar.getVelocity().y;
				
			}
		}
		
		public static function resetGameContainerCoordinates():void {
			gameContainer.x = 0;
			gameContainer.y = 0;
		}
		
		private static function masterLoop(event:Event):void{
			if (!gamePaused) {
				framesSinceGameStart ++;
				AvatarManager.updateLoop();
				BulletManager.updateLoop();
				EnemyManager.updateLoop();
				LootManager.updateLoop();
				//updateCombatManager();
				UIManager.updateLoop();
				//LevelManager.updateLoop();
			}else{
				//can use this section for when the game is paused but I still need to update UI stuff
			}
		}
		
		//pause the update loops
		//pause any other specific things like, spawnTimes, decayRates etc. that are dependent on getTimer
		public static function pauseGame():void{
			gamePaused = true;
			bulletManager.pauseAllBulletTimes()
		}
		
		public static function resumeGame():void{
			gamePaused = false;
			bulletManager.resumeAllBulletTimes();
		}
		
		public static function getBulletManager():Object{
			return bulletManager;
		}
		
		public static function getGameContainer():MovieClip{
			return gameContainer;
		}
		
		public static function getGameContainerCoordinates():Point{
			var gameContainerPoint:Point = new Point(gameContainer.x,gameContainer.y);
			return gameContainerPoint;
		}
		
		public static function deselectAllActors():void {
			trace("Game: deselectAllActors");
			AvatarManager.getInstance().deselectActors();
			trace("EnemyManager:",EnemyManager);
			//EnemyManager.getInstance().deselectActors();
		}
		
		public static function getAnimationManager():AnimationManager {
			return animationManager;
		}
	}
}