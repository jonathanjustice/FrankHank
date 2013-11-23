package utilities.Engine{
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Actors.SelectableActor;
	import utilities.Engine.DefaultManager;
	import utilities.Screens.GameScreens.CutScene
	import utilities.Actors.GameBoardPieces.Level;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Input.KeyInputManager;
	import flash.events.Event;
	
	import utilities.dataModels.LevelProgressModel;
	import flash.geom.Point;
	public class CheatManager extends BasicManager implements IManager{
		private static var _instance:CheatManager;
		
		//Singleton Design Pattern features
		public function CheatManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public function setUp():void{
			
		}
		
		public static function getInstance():CheatManager {
			if(CheatManager._instance == null){
				CheatManager._instance = new CheatManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function updateLoop():void {
			
			if (KeyInputManager.getRKey() == true) {
				restartLevel();
			}
			if (KeyInputManager.getWKey() == true) {
				completeLevel();
			}
		}
		
		public static function restartLevel():void {
		//	trace(AvatarManager.getInstance());
		//	trace(AvatarManager.getInstance().getIsAvatarDoubleJumpEnabled());
			//LevelManager.getInstance().setIsLevelActive(false);
			Game.setGameState("levelFailed");
		//	trace();
			//for each(var myAvatar:Avatar in avatars){
		//	trace(AvatarManager.getInstance().getAvatar());
			//trace(AvatarManager.getInstance().getAvatarForCheats());
			//trace();
			//AvatarManager.getInstance().getAvatar().takeDamage(999);
			//myAvatar.takeDamage(EnemyManager.enemies[j].getCollisionDamage() );
		}
		
		public static function completeLevel():void {
			LevelManager.getInstance().setIsLevelComplete(true);
		}
		
	}
}

class SingletonEnforcer{}
