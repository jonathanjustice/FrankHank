package utilities.Actors{
	import flash.display.MovieClip;
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import utilities.Engine.Combat.EnemyManager;
	import flash.display.DisplayObject;
	public class BossEnemy extends Enemy{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		private var isGravitySystemEnabled:Boolean = false;
		private var isActivated:Boolean = false;
		
		//private var hitbox:MovieClip;
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_boss.swf";
		public function BossEnemy(newX:int, newY:int) {
			trace("new boss activated");
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
			addActorToGameEngine(graphic, EnemyManager.bosses);
			//playAnimation("walk");
		}
		
		public override function updateLoop():void {
			setPreviousPosition();
			setQuadTreeNode();
			//applyVector();
			applyGravity(isGravitySystemEnabled);
			//checkForDamage();
			checkForDeathFlag();
			rechargeHealth();
			listenForStopFrame();
			
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
			//	trace("too fast ");
			}
		}
		
	}
}