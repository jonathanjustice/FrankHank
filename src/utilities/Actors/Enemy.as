package utilities.Actors{
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
		private var rechargeHealthTime:int = 90;
		private var isVulnerable:Boolean = false;
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "";
		public function Enemy(){
			setUp();
			//health=1;
		}
		
		public function setUp():void{
			addActorToGameEngine();
			setPreviousPosition();
			//defineGraphics("frank");
			//trace(get_availableForTargeting());
		}
		
		public function updateLoop():void{
			//setQuadTreeNode();
			//applyVector();
			//doStuffToEnemyOverTime();
			//checkForDamage();
			//checkForDeathFlag();
			//setPreviousPosition();
		}
		
		//if the enemy is not stunned, then move forward
		public function applyVector():void {
			if (!isVulnerable) {	
				this.x += xVelocity;
				this.y += yVelocity;
			}
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
				isVulnerable = true;
			}
			if (isRechargingHealth) {
				//trace("isRecharging");
				rechargeHealthTimer++;
			}
			if (rechargeHealthTimer >= rechargeHealthTime) {
				//trace("recharge Time Complete");
				rechargeHealthTimer = 0;
				health++;
				if (health >= maximumHealth) {
					//trace("maxmimum health reached");
					health = maximumHealth;
					isRechargingHealth = false;
					isVulnerable = false;
				}
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