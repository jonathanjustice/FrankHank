package utilities.Actors{
	import flash.display.MovieClip;
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import utilities.Engine.Combat.EnemyManager;
	import flash.display.DisplayObject;
	public class TankEnemy extends Enemy{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		private var isGravitySystemEnabled:Boolean = true;
		//private var hitbox:MovieClip;
		private var hitzone:MovieClip;
		private var originalXVelocity:int=0;
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_tank.swf";
		public function TankEnemy(newX:int, newY:int) {
			this.x = newX;
			this.y = newY;
			xVelocity = -5;
			originalXVelocity = xVelocity;
			health = 2;
			maximumHealth = 2;
			setUp();
			defineGraphics("tank", false);
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			addActorToGameEngine(graphic, EnemyManager.enemies);
		//	hitbox = this.assignedGraphic[0].swf_child.hitbox;
		//	hitzone = this.assignedGraphic[0].swf_child.hitzone;
			playAnimation("walk");
		}
		
		public override function updateLoop():void {
			setPreviousPosition();
			setQuadTreeNode();
			applyVector();
			applyGravity(isGravitySystemEnabled);
			//checkForDamage();
			checkForDeathFlag();
			rechargeHealth();
			
		}
		
		public override function applyVector():void {
			this.y += yVelocity;
			//if vulnerable stop walking around
			if (!getIsVulnerable()) {	
				this.x += xVelocity;
				
			}
			trace("xvel",xVelocity);
			trace("abs svel",Math.abs(xVelocity));
			if (xVelocity > 5) {
				xVelocity -= .5;
			}
			if (xVelocity < -5) {
				xVelocity -= .5;
			}
		}
		
	}
}