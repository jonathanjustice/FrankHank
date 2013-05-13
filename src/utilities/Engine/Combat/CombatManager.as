package utilities.Engine.Combat{
	
	import utilities.Engine.DefaultManager;
	import utilities.Engine.Combat.BulletManager;
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Engine.Game;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import utilities.Input.KeyCodes;
	import flash.geom.Point;
	public class CombatManager {
		private static var _instance:CombatManager;
		public function CombatManager(singletonEnforcer:SingletonEnforcer){
			setUp();			
		}
		
		public static function getInstance():CombatManager {
			if(CombatManager._instance == null){
				CombatManager._instance = new CombatManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
		}
		
		
		public function setUp():void{
			
		}
		/*
		public override function updateLoop(){
			updateBulletManager();
			updateEnemyManager();
			updateLootManager();
		}
		*/
		private function updateBulletManager():void{
			trace(Main);
			trace(Main.game);
			//trace(Main.game.theGame);
			trace(Main.game.getBulletManager());
			trace(Main.game.theGame.bulletManager);
			//trace("bulletManager",Main.game.bulletManager);
			//var avatarLocation:Point = new Point(Main.game.avatar.getX(),Main.game.avatar.getY());
			//Game.bulletManager.updateLoops(Main.keyInputManager.getRightBracket());
		}
			
		private function updateEnemyManager():void{
			//var avatarLocation:Point = new Point(Main.avatar.x,Main.avatar.y);
			//EnemyManager.updateLoop();
		}
		
		private function updateLootManager():void{
			//var avatarLocation:Point = new Point(Main.avatar.x,Main.avatar.y);
			//LootManager.updateLoop();
		}
		
	}
}

class SingletonEnforcer{}