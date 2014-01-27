package utilities.Actors{
	import flash.display.MovieClip;
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import utilities.Engine.Combat.EnemyManager;
	import flash.display.DisplayObject;
	public class SpiderEnemy extends Enemy{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		private var isGravitySystemEnabled:Boolean = true;
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_spider.swf";
		public function SpiderEnemy(newX:int, newY:int) {
			this.x = newX;
			this.y = newY;
			xVelocity = 5;
			originalXVelocity = xVelocity;
			health = 2;
			maximumHealth = 2;
			setUp();
			defineGraphics();
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			addActorToGameEngine(graphic, EnemyManager.enemies);
			hitbox.visible = false;
		}
		
		public override function updateLoop():void {
			setPreviousPosition();
			setQuadTreeNode();
			applyVector();
			applyGravity(isGravitySystemEnabled);
			//checkForDamage();
			checkForDeathFlag();
			rechargeHealth();
			listenForStopFrame();
			forceHitBoxVisibilityToFalse();
		}
		
		public override function applyVector():void {
			this.y += yVelocity;
			if (!getIsVulnerable()) {
				this.x += xVelocity;
				if (xVelocity > 0) {
					setDirectionToFace("RIGHT");
				}else{
					setDirectionToFace("LEFT");
				}
			}
			//trace("xvel",xVelocity);
			//trace("abs svel",Math.abs(xVelocity));
			if (Math.abs(xVelocity) > Math.abs(originalXVelocity)) {
				xVelocity *= .97;
				//trace("too fast ");
			}
		}
		
	}
}