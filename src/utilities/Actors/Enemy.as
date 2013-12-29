package utilities.Actors{
	import flash.display.MovieClip;
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import utilities.Engine.LevelManager;
	import flash.display.DisplayObject;
	public class Enemy extends SelectableActor{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		//public var xVelocity:Number=0;//velocity
		//public var yVelocity:Number=0;
		private var numberOfWallsBeingTouched:int = 0;
		private var isRechargingHealth:Boolean = false;
		private var rechargeHealthTimer:int = 0;
		private var rechargeHealthTime:int = 120;
		private var rechargePause:Boolean = false;
		private var isVulnerable:Boolean = false;
		private var isAttachedToAvatar:Boolean = false;
		private var throwable:Boolean = false;
		private var isBeingThrown:Boolean = false;
		public var originalXVelocity:int;
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "";
		public function Enemy(){
			setUp();
			setCollisionDamage(1);
			originalXVelocity = xVelocity;
			//health=1;
		}
		
		public function setUp():void{
			
			//defineGraphics("frank");
			//trace(get_availableForTargeting());
		}
		
		public function updateLoop():void{
			//setQuadTreeNode();
			applyVector();
			listenForStopFrame();
			//doStuffToEnemyOverTime();
			//checkForDamage();
			//checkForDeathFlag();
			//setPreviousPosition();
		}
		
		public function beThrown():void {
			setIsBeingThrown(true);
			this.y -= 30 ;
			xVelocity = 25;
			yVelocity = -15;
			//applyVector();
			rechargePause = false;
			health = maximumHealth;
			isRechargingHealth = false;
		}
		
		//if the enemy is not stunned, then move forward
		public function applyVector():void {
			this.y += yVelocity;
			if (!isVulnerable) {
				this.x += xVelocity;
			}
			//trace("xvel",xVelocity);
			//trace("abs svel",Math.abs(xVelocity));
			if (Math.abs(xVelocity) > Math.abs(originalXVelocity)) {
				xVelocity *= .99;
				trace("too fast ");
			}
		}
		
		public function setIsBeingThrown(newState:Boolean):void {
			isBeingThrown = newState;
		}
		
		public function getIsBeingThrown():Boolean {
			return isBeingThrown;
		}
		
		public function getThrowable():Boolean {
			return throwable;
		}
		
		public function setThrowable(newState:Boolean):void {
			throwable = newState;
		}
		
		public function getIsAttachedToAvatar():Boolean {
			return isAttachedToAvatar;
		}
		
		public function setAttachToAvatar(newState:Boolean):void {
			isAttachedToAvatar = newState;
		}
		
		public function collidedWithAvatar():void {
			
		}
		
		//direction indicator is useful for determine what direction the enemy is faceing / moving in / shooting in
		//make it invisible if its not being used
		//it's commented out because it't not part of the default graphic anymore
		/*private function set_direction_indicator_visibility(){
			directionIndiactor.visible = false;
		}
		*/
		
		//this records the moment the bullet was created
		public function setSpawnTime():void {
         	spawnTime = getTimer();
			//trace("spawnTime",spawnTime);
        }
		/*
		public function takeDamage(amount:int):void{
			health -= amount;
		}
		*/
		public function markKillWithXpFlag():void{
			markDeathFlag();
			applyXP = true;
		}
		
		public function markDeathWithoutXpFlag():void{
			markDeathFlag();
			applyXP = false;
		}
		
		public function get_apply_XP_flag():Boolean{
			return applyXP;
		}
		
		public function get_xpToApply():int{
			return xpToApply;
		}
		
		public function reverseVelecityX():void {
			
			this.xVelocity *= -1;
		}
		
		public function reverseVelecityY():void {
			this.yVelocity *= -1;
		}
		
		public function setNumberOfWallsBeingTouched(amount:int):void {
			numberOfWallsBeingTouched += amount;
		}
		
		public function getNumberOfWallsBeingTouched():int {
			return numberOfWallsBeingTouched;
		}
		
		//if its damaged, it becomes vulnerable and starts recharging health
		//if it is below max health it recharges until it reaches max health
		public function rechargeHealth():void {
			if (health < maximumHealth) {
				isRechargingHealth = true;
			}
			//recharge health unless recharging is paused, usually due to being stunned / vulnerable
			if (isRechargingHealth) {
				//trace("isRecharging");
				if (rechargePause == false) {
					rechargeHealthTimer++;
				}
			}
			if (rechargeHealthTimer >= rechargeHealthTime) {
				//trace("recharge Time Complete");
				rechargeHealthTimer = 0;
				health++;
				if (health >= maximumHealth) {
					//trace("maxmimum health reached");
					health = maximumHealth;
					isRechargingHealth = false;
					setIsVulnerable(false);
				}
			}
		}
		
		public function getRechargePause():Boolean {
			return rechargePause;
		}
		
		public function setRechargePause(newState:Boolean):void{
			rechargePause = newState;
		}
		public function setIsVulnerable(newState:Boolean):void {
			//trace("setisVulnerable",newState);
			isVulnerable = newState;
			if (isVulnerable == true) {
				playAnimation("vulnerable")
			}
			if (isVulnerable == false) {
				playAnimation("walk")
				
			}
		}
		
		public function getIsVulnerable():Boolean {
			return isVulnerable;
		}
		
		public function startHealthRechargeTimer():void{
			isRechargingHealth = true;
		}
	}
}