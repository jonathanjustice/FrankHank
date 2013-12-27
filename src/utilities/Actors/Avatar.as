package utilities.Actors{
	import utilities.Mathematics.MathFormulas;
	import utilities.Mathematics.QuadTree;
	import utilities.Engine.Game;
	import utilities.Actors.Actor;
	import utilities.Input.KeyInputManager;
	import utilities.Input.MouseInputManager;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.text.*;
	import utilities.Engine.Combat.AnimationManager;
	import utilities.Engine.Combat.AvatarManager;
	import flash.display.DisplayObject;

	public class Avatar extends JumpingActor{
		//private var mySprite:Sprite = new Sprite();
		private var myTextField:TextField = new TextField(); 
		private var myAngle:Number=0;
		private var velocityIncrease:Number = 3;
		private var maxVelocity:Number = 18;
		private var velocityDecrease:Number = .8;
		private var maxSpeed:Number=100;
		public var xDiff:Number=0;
		public var yDiff:Number = 0;
		private var jumpDamage:int = 1;
		private var attackDamage:int = 1;
		private var attackHitbox:MovieClip;
		private var shootingDelay:int = 30
		private var shootingTimer:int = 0;
		private var currentDelay:int = 0;
		private var delay:int = 15;
		private var avatarHealth:int = 10;
		private var additionalYVelocityForCamera:int = 0;
		
		
		private var filePath:String = "../src/assets/actors/swf_frank.swf";
		
		public function Avatar(newX:int, newY:int) {
			this.x = newX,
			this.y = newY;
			setUp();
			trace("-----------AVATAR------------");
			trace(newX);
			trace(newY);
			
		}
		
		public function setAdditionalYVelocity(newVel:int):void {
			additionalYVelocityForCamera = newVel;
		}
		
		public function getAdditionalYVelocity():int {
			return additionalYVelocityForCamera;
		}
		
		public function resetHealth():void {
			health = avatarHealth;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			addActorToGameEngine(graphic,AvatarManager.avatars);
		}
		
		public function setUp():void {
			//print("Avatar.SetUp()");
			defineGraphics("frank", false);
			resetHealth();
			//addStroke();
			if (AvatarManager.getInstance().getIsAvatarDoubleJumpEnabled()) {
				toggleDoubleJump(true);
			}
		}
		
		
		public function setAttackHitbox(newHitbox:MovieClip):void{
			attackHitbox = newHitbox;
			//trace("attackHitbox",attackHitbox);
		}
		
		public function getAttackHitbox():MovieClip {
			return attackHitbox;
		}
		
		public function punch():void {
			currentDelay ++;
			if(KeyInputManager.getXKey() == true){
				if (currentDelay >= delay) {
					//print("pressed x");
					AnimationManager.getInstance().updateAnimationState(this, "attack");
				}
			}
		}
		
		public function getAvatarLocation():Point{
			var point:Point=new Point(this.x,this.y);
			return point;
		}
		
		public function updateLoop():void {
			if (getIsSwfLoaded() == true) {
				//trace("health",health);
				animationLogic();
				//setIsFalling(true);
				getisJumpingFromInputManager();
				applyVelocities();
				applyGravity(getIsGravitySystemEnabled());
				
				setQuadTreeNode();
				//get key data
				//getAnglesFromKeyInputManager();
				//get the velocity
				getVelocityFromKeyInputManager();
				//getRotationFromKeyInputManager();
				//apply the velocities to the avatar
				
				var myPoint:Point = new Point(mouseX,mouseY);
				myPoint = Main.getMouseCoordinates();
				//Point_Actor_At_Target(myPoint);
				
				//trace("thisX: ",this.x,"thisY:",this.y);
				applyInvincibility();
				if (getIsShootingEnabled() == true) {
					//fireProjectile();
				}
				if (getBehaviorState() == "shooting") {
					
				}
				punch();
			}
		}
		
		/*public override function Point_Actor_At_Target(target:Point):void{
			MathFormulas.Point_Object_At_Target(this,target);
		}
		*/
		
		public function getAnglesFromKeyInputManager():void{
			this.rotation = Main.keyInputManager.getMyAngle();
		}
		
		public function getZKeyFromKeyInputManager():void{
			this.rotation = Main.keyInputManager.getMyAngle();
		}
		
		
		public function getVelocityFromKeyInputManager():void{
			KeyInputManager.setSimpleVelocityViaKeys();
			//limit max velocity
			if (Math.abs(xVelocity) < maxVelocity) {
				xVelocity += KeyInputManager.getMyVelocityX() * velocityIncrease;
			}
			//yVelocity += KeyInputManager.getMyVelocityY() * velocityIncrease*5;
			
			//if you are not pressing a button to run, then you slowdown
			if (KeyInputManager.getMyVelocityX() == 0) {
				//xVelocity = 0;
				xVelocity *= velocityDecrease;
				if (xVelocity <= .5 && xVelocity >= -.5) {
					xVelocity = 0;
				}
			}
		}
		
		public function getRotationFromKeyInputManager():void{
			//trace(KeyInputManager.getMyRotation());
			//trace(this.rotation);
			this.rotation += KeyInputManager.getMyRotation();
		}
		
		//used for forcing the avatar to stop
		public function setXVelocity(newVelocity:Number):void {
			xVelocity = newVelocity;
		}
		
		public function applyVelocities():void {
			this.x += xVelocity;
			this.y += yVelocity;
			Main.game.moveGameContainer(this);
		}
		
		//don't set this every frame
		//use only when required
		//get the change in vector
		public function getChangeInPosition():Point{
			var changePoint:Point = new Point(xDiff,yDiff);
			return changePoint;
		}
		
		public override function getActor():MovieClip{
			return this;
		}
		
		public function getJumpDamage():int {
			return jumpDamage;
		}
		
		public function getAttackDamage():int {
			return attackDamage;
		}
		
		public function applyPowerup(type:String):void {
			switch(type) {
				case "shoot":
					setIsShootingEnabled(true);
					break;
				case "invincible":
					setKillsOnContact(true);
					setInvincibilityEnabled(true);
					break;
				case "doubleJump":
					setIsGravitySystemEnabled(true);
					break;
			}
			//trace("isShootingEnabled",isShootingEnabled);
			//trace("isInvincibilityEnabled",isInvincibilityEnabled);
			//trace("isDoubleJumpingEnabled",isDoubleJumpingEnabled);
		}
		
		public function animationLogic():void {
			//If running, disable idleing & play run 
			if (xVelocity != 0 && yVelocity == 0) {
				setIsIdle(false);
				setIdleTime(0);
				AnimationManager.getInstance().updateAnimationState(this, "run");
				
			//if you are not moving and have not already started idleing, then idle
			}else if (xVelocity == 0 && yVelocity == 0 && isJumping == false && getIdleTime() == 0) {
				AnimationManager.getInstance().updateAnimationState(this, "idle");
				setIsIdle(true);
			}
			//If idleing, increment idle timer
			if (getIsIdle()==true) {
				setIdleTime((getIdleTime() + 1));
			}
			
			if (getIdleTime() >= getMaxIdleTime()) {
				//if over max idle time, switch to impatient idle
				setIdleImpatientTime((getIdleImpatientTime() + 1));
				if (getIdleImpatientTime() == 1) {
					//AnimationManager.getInstance();
					AnimationManager.getInstance().updateAnimationState(this,"idleImpatient");
				}
				//if over max idle time, switch to idle
				if (getIdleImpatientTime() == getMaxIdleTime()) {
					AnimationManager.getInstance().updateAnimationState(this, "idle");
					setIdleImpatientTime(0);
					setIdleTime(0);
				}
			}
		}
		
		public override function onTakeDamage():void {
			bounceBackward();
		}
	}
}