package utilities.Engine.Combat{
	
	import utilities.Actors.Powerup_default;
	import utilities.Actors.Powerup_doubleJump;
	import utilities.Actors.Powerup_shoot;
	import utilities.Actors.Powerup_invincible;
	import utilities.Engine.DefaultManager;
	import utilities.Engine.BasicManager;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Engine.IManager;
	import utilities.Mathematics.MathFormulas;
	import utilities.Engine.LevelManager;
	public class PowerupManager extends BasicManager{
		public static var powerups:Array;
		
		private var avatar:Point = new Point();
		
		
		private static var numnum:Number = 0;
		private static var _instance:PowerupManager;
		
		public function PowerupManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public static function getInstance():PowerupManager {
			if(PowerupManager._instance == null){
				PowerupManager._instance = new PowerupManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
		}
		
	
		
		public function setUp():void{
			numnum = 0;
			powerups = [];
			//createNewPowerup();
		}
		
		public function updateLoop():void{
			
			
		}
		
		public function deselectActors():void {
			//trace("enenmyManager: deselectActors");
			for each(var powerup:MovieClip in powerups) {
				//trace("powerup to deselect:",powerup);
				powerup.deselectActor();
			}
		}
		
		public function getArrayLength():int{
			return powerups.length;
		}
		
		public function getObjectAtIndex(index:int):Object{
			return powerups[index];
		}
		
		public function getArray():Array{
			return powerups;
		}
		
		//shitty placeholder enemy creation
		public static function createNewPowerup():void {
			var powerup:Powerup_doubleJump = new Powerup_doubleJump();
			var powerup1:Powerup_shoot = new Powerup_shoot();
			var powerup2:Powerup_invincible = new Powerup_invincible();
			//var powerup:Powerup_default = new Powerup_default();
			
			powerups.push(powerup);
			powerups.push(powerup1);
			powerups.push(powerup2);
		
			//give the enemy some placeholder properties
			
			powerup.x = 250;
			powerup.y = 0;
			powerup1.x = 350;
			powerup1.y = 0;
			powerup2.x = 450;
			powerup2.y = 0;
		}
	}
}
class SingletonEnforcer{}