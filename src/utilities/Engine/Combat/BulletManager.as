/*
FYI:
access other managers:Game.manager name



*/


package utilities.Engine.Combat{
	import utilities.Input.KeyInputManager;
	import utilities.Engine.DefaultManager;
	import utilities.Actors.Actor;
	import utilities.Actors.Avatar;
	import utilities.Actors.Bullet;
	import utilities.Engine.Game;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class BulletManager {
		
		public static var bullets:Array;
		public static var enemyBullets:Array;
		private var gameTimer:Timer = new Timer(0,0);
		private static var currentDelay:int = 0;
		private static var delay:int = 10;
		private static var _instance:BulletManager;
		
		public function BulletManager(singletonEnforcer:SingletonEnforcer){
			setUp();			
		}
		
		public static function getInstance():BulletManager {
			if(BulletManager._instance == null){
				BulletManager._instance = new BulletManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
		}
		
		public function setUp():void{
			gameTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			bullets =[];
		}
		
		private function timerHandler(e:TimerEvent):void{
			
		}
		
		public static function updateLoop():void{
			
			for each(var bullet:Bullet in bullets){
				bullet.updateLoop();
			}
			for each(var enemyBullet:Bullet in enemyBullets){
				bullet.updateLoop();
			}
			if_shooting_create_a_new_bullet();
		}
		
		public static function if_shooting_create_a_new_bullet():void {
			currentDelay ++;
			if(KeyInputManager.getRightBracket() == true){
				Game.resumeGame();
				if (currentDelay >= delay) {
					if(bullets.length == 0){//one bullet at a time mode
						currentDelay = 0;
						createNewBullet();
					}
					//trace("BulletManager: createBullet");
				}
			}
		}
		
		public static function createEnemyBullet():void {
			var newBullet:Bullet = new Bullet()
			bullets.push(newBullet);
		}
		
		public static function createNewBullet():void{
			var newBullet:Bullet = new Bullet()
			bullets.push(newBullet);
		}
		
		/*THIS SHOULD BE FURTHER ABSTRACTED*/
		//pause the bullets & the times at which they were create(for if they have a lifespan)
		//pass in the array and possibly the type, if no type is passed, then it should just pause everything in the array
		public function pauseAllBulletTimes():void{
			for each(var bullet:utilities.Actors.Bullet in bullets){
				bullet.pauseBulletTime();
			}
		}
		
		public function getArrayLength():int{
			return bullets.length-1;
		}
		
		public function getArray():Array{
			return bullets;
		}
		
		public function testFunction():void{
			trace("BulletManager: testFunction");
		}
		
		//resume the bullets & the times at which they were paused
		public function resumeAllBulletTimes():void{
			/*for each(var bullet:utilities.Actor.Bullet in bullets){
				bullet.resumeBulletTime();
			}*/
		}
		
	}
}
class SingletonEnforcer{}