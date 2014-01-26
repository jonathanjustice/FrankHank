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
	import utilities.customEvents.*;
	import utilities.Engine.Combat.AnimationManager;
	import utilities.Engine.Combat.AvatarManager;
	import flash.display.DisplayObject;

	public class Avatar extends JumpingActor{
		//private var mySprite:Sprite = new Sprite();
		private var myTextField:TextField = new TextField(); 
		private var myAngle:Number=0;
		private var velocityIncrease:Number = 3;
		private var maxVelocity:Number = 18;
		private var velocityDecrease:Number = .7;
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
		private var isTouchingWall:Boolean = false;
		private var invulnerableTime:int = 0;
		private var maxInvulnerableTime:int = 60;
		
		
		private var filePath:String = "../src/assets/actors/swf_frank.swf";
		
		public function Avatar(newX:int, newY:int) {
			this.x = newX,
			this.y = newY;
			setUp();
		}
		
		public function getIsTouchingWall():Boolean {
			return isTouchingWall;
		}
		
		public function setIsTouchingWall(newState:Boolean):void {
			isTouchingWall = newState;
		}
		
		public override function lerpToTarget():void {
			if (lerping) {
				AnimationManager.getInstance().updateAnimationState(this, "run");
				lerpAmount.x = (this.x - lerpTarget.x) * lerpMultiplier.x;
				this.x -= lerpAmount.x;
				lerpAmount.y = (this.y - lerpTarget.y) * lerpMultiplier.y;
				//this.y -= lerpAmount.y;
				if (Math.abs(lerpAmount.x) < 3) {
					lerping = false;
					Game.setGameState("unlockAvatar");
					Game.setGameState("lockCamera");
					
					AnimationManager.getInstance().updateAnimationState(this, "idle");
				}
			}
		}
		
		public function checkInvulnerableDueToDamage():void {
			var alphaIncrement:Number = .2;
			var timeIncrement:Number = 5;
			if (invulnerableDueToDamage == true) {
				invulnerableTime++;
				
				if (invulnerableTime < timeIncrement) {
					this.alpha -= alphaIncrement;
				}
				else if (invulnerableTime < timeIncrement*2) {
					this.alpha += alphaIncrement;
				}
				else if (invulnerableTime < timeIncrement*3) {
					this.alpha -= alphaIncrement;
				}
				else if (invulnerableTime < timeIncrement*4) {
					this.alpha += alphaIncrement;
				}
				else if (invulnerableTime < timeIncrement*5) {
					this.alpha -= alphaIncrement;
				}
				else if (invulnerableTime < timeIncrement*6) {
					this.alpha += alphaIncrement;
				}
				
				if (invulnerableTime >= maxInvulnerableTime) {
					invulnerableDueToDamage = false;
					invulnerableTime = 0;
					this.alpha = 1;
					setInvincibilityEnabled(false);
				}
			}
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
			setLerpMultiplier(.05, .05);
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
				checkInvulnerableDueToDamage();
				//trace("health",health);
				animationLogic();
				//setIsFalling(true);
				
				lerpToTarget();
				applyGravity(getIsGravitySystemEnabled());
				
				setQuadTreeNode();
				//get key data
				//getAnglesFromKeyInputManager();
				//get the velocity
			
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
				getVelocityFromKeyInputManager();
				getisJumpingFromInputManager();
				applyVelocities();
				punch();
			}
			
			//trace("avatar x",this.x + this.hitbox.x + this.hitbox.width);
			//trace("avatar y",this.y + this.hitbox.y + this.hitbox.height);
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
			var velocityMod: Number = KeyInputManager.getMyVelocityX();
			//verify key press is the right direction before application of velocity
			//set the direction i should be facing
			if (KeyInputManager.getLeftArrowKey()==true) {
				xVelocity += (velocityMod * velocityIncrease) * getJumpingInputSpeedModifier();
				directionLastFaced = "LEFT";
			}
			if (KeyInputManager.getRightArrowKey()==true) {
				xVelocity += (velocityMod * velocityIncrease)* getJumpingInputSpeedModifier();
				directionLastFaced = "RIGHT";
			}
			//limit max velocity
			if (xVelocity > maxVelocity) {
				xVelocity = maxVelocity;
			}
			if (xVelocity < -maxVelocity) {
				xVelocity = -maxVelocity;
			}
			//if you are not pressing a button to run, then you slowdown
			if (KeyInputManager.getMyVelocityX() == 0) {
				//if(getIsRiding() == false){
					xVelocity *= velocityDecrease;
					if (xVelocity <= .5 && xVelocity >= -.5) {
						xVelocity = 0;
					}
				//}
			}
				setDirectionToFace(directionLastFaced);
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
			this.y += yVelocity;
			this.x += xVelocity;
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
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","SHOOT_POWERUP_ACQUIRED"));
					break;
				case "invincible":
					setKillsOnContact(true);
					setInvincibilityEnabled(true);
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","INVINCIBLE_POWERUP_ACQUIRED"));
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","SONG_INVINCIBLE"));
					break;
				case "doubleJump":
					setIsGravitySystemEnabled(true);
					Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","DOUBLEJUMP_POWERUP_ACQUIRED"));
					break;
			}
			//trace("isShootingEnabled",isShootingEnabled);
			//trace("isInvincibilityEnabled",isInvincibilityEnabled);
			//trace("isDoubleJumpingEnabled",isDoubleJumpingEnabled);
		}
		
		public override function startJumpAnimation():void {
			AnimationManager.getInstance().updateAnimationState(this, "jump");
			//tintActor(0x8800FF);
		}
		
		public override function endJumpAnimation():void {
			AnimationManager.getInstance().updateAnimationState(this, "run");
			//trace("end");
			//resetActorTint(0x8800FF);
		}
		
		public function animationLogic():void {
			//disgusting hack
			listenForStopFrame();
			//If running, disable idleing & play run 
			if (getIsTouchingWall() == true) {
				setIsFalling(false);
				if (xVelocity != 0 && yVelocity == 0) {
				setIsIdle(false);
				setIdleTime(0);
				AnimationManager.getInstance().updateAnimationState(this, "run");
				//if you are not moving and have not already started idleing, then idle
				
				}else if (xVelocity == 0 && yVelocity == 0 && getIsFalling() == false && isJumping == false && getIdleTime() <= 5) {
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
			}else if (getIsTouchingWall() == false) {
				if (getIsFalling() == false) {
					setIsFalling(true);
					AnimationManager.getInstance().updateAnimationState(this, "fall");
				}
			}
		}
		
		public override function onTakeDamage():void {
			bounceBackward();
			
			Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","FRANK_DAMAGED"));
			setInvulnerableDueToDamage(true);
		}
	}
}