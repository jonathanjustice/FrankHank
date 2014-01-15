package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import utilities.Engine.Combat.AnimationManager;
	import flash.utils.getTimer;
	public class JumpingActor extends SelectableActor{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		//private var xVelocity:Number=0;//velocity
		//private var yVelocity:Number = 0;
		private var jumpSpeed:Number = 10;
		private var maxJumpCount:Number = 1;
		private var currentJumpCount:Number = 0;
		private var isJumpingEnabled:Boolean = true;
		public var isDoubleJumpingEnabled:Boolean = false;
		public var isJumping:Boolean = false;
		public var jumpingInputSpeedModifier:Number = 1;
		public var originalJumpingInputSpeedModifier:Number = 1;
		
		
		private var filePath:String = "";
		public function JumpingActor(){
			originalJumpingInputSpeedModifier = jumpingInputSpeedModifier;
		}
		
		public function getisJumpingFromInputManager():void {
			if (!isJumpingEnabled) {
				if (KeyInputManager.getSpace() == false) {
					isJumpingEnabled = true;
					//trace("NO")
				}
			}
			if(isJumpingEnabled){
				if (KeyInputManager.getSpace() == true) {
					checkCurrentjumpCount();
					isJumpingEnabled = false;
					//trace("jump is enabled");
				}
			}
		}
		
		//jumping & double jumping
		public function checkCurrentjumpCount():void {
			if (currentJumpCount < maxJumpCount) {
				jump();
			}
		}
		
		public function toggleDoubleJump(enabled:Boolean):void {
			if (enabled) {
				maxJumpCount = 2;
			}
			if(!enabled){
				maxJumpCount = 1;
			}
		}
		
		public function jump():void {
			startJumpAnimation();
			jumpingInputSpeedModifier = .5;
			setIdleTime(0);
			setIdleImpatientTime(0);
			setIsIdle(false);
			currentJumpCount++;
			if (currentJumpCount == 1) {
				//AnimationManager().updateAnimationState(this,"jump");
			}else if (currentJumpCount == 2) {
				//AnimationManager().updateAnimationState(this,"jumpDouble");
			}
			yVelocity = 0;
			resetGravity();
			modifiyGravity(jumpSpeed);
			isJumping = true;
		}
		
		//called when this collides with a floor
		public function jumpingEnded():void {
			if(isJumping == true){
				endJumpAnimation();
			}
			jumpingInputSpeedModifier = originalJumpingInputSpeedModifier;
			isJumping = false;
			currentJumpCount = 0;
			resetGravity();
			yVelocity = 0;
			//this.idleLogic();
			
			/*if (xVelocity != 0) {
				utilities.Engine.Game.animationManager.updateAnimationState(this, "run");
				setIsIdle(false);
				trace("xVelocity:",xVelocity);
			}*/
			//if the idle time is above 0 then don't do anythhing
		}
		
		public function startJumpAnimation():void {
			//overriden by descendent class
		}
		
		public function endJumpAnimation():void {
			//overriden by descendent class
		}
		
		public function getJumpingInputSpeedModifier():Number {
			return jumpingInputSpeedModifier;
		}
		
		public function getIsJumping():Boolean {
			//trace(isJumping);
			return isJumping;
		}
	}
}