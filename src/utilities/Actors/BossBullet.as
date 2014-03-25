
package utilities.Actors{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import utilities.Actors.Actor;
	import utilities.Actors.Behaviors.SpeedyBullet;
	import utilities.Actors.Behaviors.Behavior_HeatSeeking;
	import utilities.Actors.Behaviors.Behavior_Blob;
	import utilities.Actors.Stats.WeaponStats;
	import utilities.Mathematics.QuadTree;
	import utilities.Engine.Combat.BulletManager;
	import utilities.Engine.Game;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Input.KeyInputManager;

	import utilities.Mathematics.MathFormulas;
	public class BossBullet extends Actor{
		
		//private var gameContainer;
		private var speed:Number=10;
		private var velocityMultiplier:Number=20;//used for setting initialy velocity
		private var pausedTime:Number = 0;//for pausing the game
		private var gamePausedAtTime:Number = 0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2500;
		private var oldTarget:MovieClip;
		public var damage:Number=1;
		public var deltaX:Number = 0;
		public var deltaY:Number = 0;
		public var bossBulletSpawnPoint:Point;
		
		public var bounceTime:int = 0;
		public var maxBounceTime:int = 8;
		public var isActive:Boolean = false;
		public var spawnNode:int = 0;
		
		//public var xDiff:Number=0;
		//public var yDiff:Number=0;
		private var filePath:String = "../src/assets/actors/swf_bullet.swf";
		public function BossBullet(){
			setUp();
			setMaxGravity(0);
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			addActorToGameEngine(graphic, BulletManager.bossBullets);
			//setBossBulletLocationAndVector();
		}
		
		public function assignSpawnPoint(newSpawnPoint:int):void {
			spawnNode = newSpawnPoint;
		}
		
		public function setSpawnPoint(newSpawnPoint:int):void {
				bossBulletSpawnPoint = new Point();
			if (newSpawnPoint == 0) {
				bossBulletSpawnPoint.x = (EnemyManager.getInstance().getBosses()[0].x + EnemyManager.getInstance().getBosses()[0].assignedGraphic[0].swf_child.anim.bulletSpawnZero.x);
				bossBulletSpawnPoint.y = (EnemyManager.getInstance().getBosses()[0].y + EnemyManager.getInstance().getBosses()[0].assignedGraphic[0].swf_child.anim.bulletSpawnZero.y+64);
				xVelocity = -2;
				yVelocity = 2;
				}
			if (newSpawnPoint == 1) {
				bossBulletSpawnPoint.x = (EnemyManager.getInstance().getBosses()[0].x + EnemyManager.getInstance().getBosses()[0].assignedGraphic[0].swf_child.anim.bulletSpawnOne.x);
				bossBulletSpawnPoint.y = (EnemyManager.getInstance().getBosses()[0].y + EnemyManager.getInstance().getBosses()[0].assignedGraphic[0].swf_child.anim.bulletSpawnOne.y+64);
				xVelocity = 0;
				yVelocity = 2;
			
				}
			if (newSpawnPoint == 2) {
				bossBulletSpawnPoint.x = (EnemyManager.getInstance().getBosses()[0].x + EnemyManager.getInstance().getBosses()[0].assignedGraphic[0].swf_child.anim.bulletSpawnTwo.x);
				bossBulletSpawnPoint.y = (EnemyManager.getInstance().getBosses()[0].y + EnemyManager.getInstance().getBosses()[0].assignedGraphic[0].swf_child.anim.bulletSpawnTwo.y+64);
				xVelocity = 2;
				yVelocity = 2;
			}
			
			setSpawnTime();
			this.x = bossBulletSpawnPoint.x;
			this.y = bossBulletSpawnPoint.y;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		//newX:int, newY:int
		public function setUp():void {
			defineGraphics("bullet",false);
		}
		
		//the enter frame, does everything
		public function updateLoop():void {
			if (isActive == false) {
				setSpawnPoint(spawnNode);
				isActive = true;
			}else{
				setPreviousPosition();
				applyVector();
				//doStuffToBulletOverTime();
				checkForLeaveBounday();
				checkForLifespanExpired();
				checkForDeathFlag();
				//trace(target);
			}
			
		}
		
		private function doStuffToBulletOverTime():void{
			//guess which function hasn't been written yet
			//I bet you just guessed right
		}
		
		//apply velocity 
		private function applyVector():void {
			this.x += xVelocity;
			this.y += yVelocity;
		}
		
		private function checkForLeaveBounday():void{
			//if the bullet leaves the boundaries of the game
			//currently deprecated
		}
		
		//if the game is paused, pause the bullets
		public function pauseBulletTime():void{
			gamePausedAtTime = getTimer();
			//trace("gamePausedAtTime",gamePausedAtTime);
		}
		
		//if the game has been unpaused, resume the bullets activities
		public function resumeBulletTime():void{
			var currentTime:uint = getTimer();
			pausedTime = currentTime - gamePausedAtTime;
			trace("gamePausedAtTime",gamePausedAtTime);
			trace("currentTime",currentTime);
			trace("pausedTime",pausedTime);
		}
		
		private function checkForLifespanExpired():void{
			//get timer from the BulletManager and see if the bullet has been alive too long
			var currentTime:uint = getTimer();
			if(currentTime > spawnTime + pausedTime + lifeSpan){
				pausedTime = 0;
				markDeathFlag();
			}
		}
		
		public function getDamage():int {
			return damage;
		}
		
		public override function defineProperties():void {
			
		}
		
		//this records the moment the bullet was created
		 private function setSpawnTime():void {
           spawnTime = getTimer();
        }
		
		
		public function reverseVelecityX():void {
			
			this.xVelocity *= -1;
		}
		
		public function reverseVelecityY():void {
			this.yVelocity *= -1;
		}
	}
}