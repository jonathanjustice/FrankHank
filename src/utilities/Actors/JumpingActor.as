package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
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
		
		
		public function JumpingActor(){
			
		}
		
		public function getisJumpingFromInputManager():void {
			if (!isJumpingEnabled) {
				if (Main.keyInputManager.getSpace() == false) {
					isJumpingEnabled = true;
					//trace("NO")
				}
			}
			if(isJumpingEnabled){
				if (Main.keyInputManager.getSpace() == true) {
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
			setIdleTime(0);
			setIdleImpatientTime(0);
			setIsIdle(false);
			currentJumpCount++;
			if (currentJumpCount == 1) {
				utilities.Engine.Game.getAnimationManager().updateAnimationState(this,"jump");
			}else if (currentJumpCount == 2) {
				utilities.Engine.Game.getAnimationManager().updateAnimationState(this,"jumpDouble");
			}
			yVelocity = 0;
			resetGravity();
			modifiyGravity(jumpSpeed);
			isJumping = true;
		}
		
		//called when this collides with a floor
		public function jumpingEnded():void {
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
	}
}