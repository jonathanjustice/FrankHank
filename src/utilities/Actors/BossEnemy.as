package utilities.Actors{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Engine.Combat.BulletManager;
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
		private var fireDelay:int = 75;
		private var fireDelayTimer:int = 0;
		private var activeMode:String = "idle";
		private var shotsFired:int = 0;
		private var shotsFiredMax:int = 50;
		
		
		//private var hitbox:MovieClip;
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_boss.swf";
		public function BossEnemy(newX:int, newY:int) {
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
			setMode("idle")
			this.hitbox.alpha = 0;
			this.hitbox.visible = false;
			assignedGraphic[0].swf_child.anim.bulletSpawnZero.visible = false;
			assignedGraphic[0].swf_child.anim.bulletSpawnOne.visible = false;
			assignedGraphic[0].swf_child.anim.bulletSpawnTwo.visible = false;
		}
		
		public override function updateLoop():void {
			setPreviousPosition();
			setQuadTreeNode();
			//applyVector();
			applyGravity(isGravitySystemEnabled);
			//checkForDamage();
			checkForDeathFlag();
			rechargeHealth();
			//listenForStopFrame();
			if (activeMode == "idle") {
				
			}
			if (activeMode == "activate") {
				listenForBeginAttack();
			}
			if (activeMode == "attack") {
				attack();
			}
			if (activeMode == "spawnEnemy") {
				spawnEnemy();
			}
		}
		
		public function attack():void {
			fireDelayTimer++;
			if (fireDelayTimer >= fireDelay) {
				fireDelayTimer = 0;
				chargeLazer();
			}
			if (shotsFired >= shotsFiredMax) {
				shotsFired = 0;
				setMode("spawnEnemy");
			}
			listenForFireShot();
		}
		
		public function listenForFireShot():void {
				if (assignedGraphic[0].swf_child.anim.gunZero.currentLabel == "fireShot") {
					trace("gunZero fire!");
					BulletManager.createNewBossBullet(0);
					assignedGraphic[0].swf_child.anim.gunZero.gotoAndStop(1);
				}
				if (assignedGraphic[0].swf_child.anim.gunOne.currentLabel == "fireShot") {
					trace("gunOne fire!");
					BulletManager.createNewBossBullet(1);
					assignedGraphic[0].swf_child.anim.gunOne.gotoAndStop(1);
				}
				if (assignedGraphic[0].swf_child.anim.gunTwo.currentLabel == "fireShot") {
					trace("gunTwo fire!");
					BulletManager.createNewBossBullet(2);
					assignedGraphic[0].swf_child.anim.gunTwo.gotoAndStop(1);
				}
		}
		
		public function chargeLazer():void {
			//randomly select a laser
			var randomLazer:int = Math.random() * 3;
			if (randomLazer == 0) {
				assignedGraphic[0].swf_child.anim.gunZero.gotoAndPlay(1);
				//trace("gunZero charge!");
			}
			if (randomLazer == 1) {
				assignedGraphic[0].swf_child.anim.gunOne.gotoAndPlay(1);
				//trace("gunOne charge!");
			}
			if (randomLazer == 2) {
				assignedGraphic[0].swf_child.anim.gunTwo.gotoAndPlay(1);
				//trace("gunTwo charge!");
			}
			if (randomLazer == 3) {
				assignedGraphic[0].swf_child.anim.gunOne.gotoAndPlay(1);
				//trace("gunOne charge!");
			}
			//make laster play animation
			
			//when laser animation reaches a frame spawn a bullet
			
			//make the bullet go in the direction the lazer is pointing
		}
		
		
		public function spawnEnemy():void {
			
		}
		
		public function activateBoss():void {
			//trace("Boss activated");
			activeMode = "activate";
			assignedGraphic[0].swf_child.gotoAndPlay("activate");
		}
		
		public function getBossLocation():Point {
			var bossPoint:Point = new Point();
			bossPoint.x = this.x;
			bossPoint.y = this.y;
			return bossPoint;
			
		}
		
		public function listenForBeginAttack():void {
			//trace("listen");
			if (assignedGraphic[0].swf_child.currentLabel == "beginAttack") {
				//trace("current label was beginAttack");
				assignedGraphic[0].swf_child.anim.stop();
				setMode("attack");
			}
		}
		
		public function setMode(newMode:String):void {
			activeMode = newMode;
			switch(activeMode) {
				case "idle":
					print("idleMode");
					assignedGraphic[0].swf_child.anim.gotoAndStop(1);
					break;
				case "attack":
					print("attackMode");
					break;
					
				case "spawnEnemy":
					print("spawnEnemyMode");
					break;
			}
			
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