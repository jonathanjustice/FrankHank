package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import flash.display.DisplayObject;
	import utilities.Engine.Combat.EnemyManager;
	public class GoonEnemy extends Enemy{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
	//	private var xVelocity:Number=5;//velocity
	//	private var yVelocity:Number=0;
		private var isGravitySystemEnabled:Boolean = true;
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_goon.swf";
		public function GoonEnemy(newX:int, newY:int) {
			this.x = newX,
			this.y = newY;
			setUp();
			health = 1;
			xVelocity = -5;
			defineGraphics("goon",false);
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			addActorToGameEngine(graphic,EnemyManager.enemies);
		}
		
		public override function updateLoop():void {
			setPreviousPosition();
			applyGravity(isGravitySystemEnabled);
			//trace("AFS Enemy update loop");
			setQuadTreeNode();
			applyVector();
			//doStuffToEnemyOverTime();
			checkForDamage();
			checkForDeathFlag();
		}
		
		public override function applyVector():void {
			this.x += xVelocity;
			this.y += yVelocity;
		}
		
	}
}