/*
You can access another manager this way:
Game.avatarManager.doSomeFunction();
*/
package utilities.Actors{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import utilities.Actors.Actor;
	import utilities.Actors.Behaviors.SpeedyBullet;
	import utilities.Actors.Behaviors.Behavior_HeatSeeking;
	import utilities.Actors.Behaviors.Behavior_Blob;
	import utilities.Actors.Stats.WeaponStats;
	import utilities.Mathematics.QuadTree;
	import utilities.Engine.Combat.BulletManager;
	import utilities.Engine.Game;

	import utilities.Mathematics.MathFormulas;
	public class Bullet extends Actor{
		
		//private var gameContainer;
		private var speed:Number=15;
		private var velocityMultiplier:Number=20;//used for setting initialy velocity
		private var pausedTime:Number = 0;//for pausing the game
		private var gamePausedAtTime:Number = 0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 3000;
		private var oldTarget:MovieClip;
		public var damage:Number=1;
		public var deltaX:Number = 0;
		public var deltaY:Number = 0;
		//public var xDiff:Number=0;
		//public var yDiff:Number=0;
	
		public function Bullet(){
			setUp();
		}
		
		
		public function setUp():void{
			setInitialLocationAndVector();
			addActorToGameEngine();
			defineGraphics("bullet",false);
		}
		
		//the enter frame, does everything
		public function updateLoop():void{
			setQuadTreeNode();
			//applyBulletBehaviors();//such as heat seeking
			applyVector();
			//doStuffToBulletOverTime();
			checkForLeaveBounday();
			checkForLifespanExpired();
			checkForDeathFlag();
			//trace(target);
		}
		
		private function doStuffToBulletOverTime():void{
			//guess which function hasn't been written yet
			//I bet you just guessed right
		}
		
		//apply velocity 
		private function applyVector():void{
			
			var totalmove:Number = Math.sqrt(xVelocity * xVelocity + yVelocity * yVelocity);
				
			//apply easing
			xVelocity = speed*xVelocity/totalmove;
			yVelocity = speed*yVelocity/totalmove;
			//trace(xVelocity,yVelocity)
			//use the slope of the movement vector to determine the direction of the bullet
			var slope:Point = new Point();
			slope.x = xVelocity, slope.y = yVelocity;
			//myRotation = MathFormulas.getAngle3(slope,origin);
			//for making it turn faster as it turns
			//deprecated for now
			
			this.x += xVelocity;
			this.y += yVelocity;
			//trace("Bullet: applyVector: xVelocity:",xVelocity);
		}
		
		private function checkForLeaveBounday():void{
			//if the bullet leaves the boundaries of the game
			//currently deprecated
		}
		
		//if the game is paused, pause the bullets
		public function pauseBulletTime():void{
			gamePausedAtTime = getTimer();
			//trace("gamePausedAtTime",gamePausedAtTime);
		}
		
		//if the game has been unpaused, resume the bullets activities
		public function resumeBulletTime():void{
			var currentTime:uint = getTimer();
			pausedTime = currentTime - gamePausedAtTime;
			trace("gamePausedAtTime",gamePausedAtTime);
			trace("currentTime",currentTime);
			trace("pausedTime",pausedTime);
		}
		
		private function checkForLifespanExpired():void{
			//get timer from the BulletManager and see if the bullet has been alive too long
			var currentTime:uint = getTimer();
			if(currentTime > spawnTime + pausedTime + lifeSpan){
				pausedTime = 0;
				markDeathFlag();
			}
		}
		
		public override function defineProperties():void{
			//classes to get behaviors from
			
			/*//define visuals of the bullet based on its properties
			if(utilities.Actors.Stats.WeaponStats.getHeatSeeking() >0){
				this.addChild(new graphics_missle());
			}
			if(utilities.Actors.Stats.WeaponStats.getBlobular() >0){
				this.addChild(new graphics_missle());
			}
			if(utilities.Actors.Stats.WeaponStats.getSharkness() >0){
				this.addChild(new graphics_shark());
			}*/
		}
		
		public function setEnemyBulletLocationAndVector(spawnPoint:Point,newRotation:Number):void{
			trace("setEnemyBulletLocationAndVector");
			spawnPoint = Game.avatarManager.getAvatarLocation();
			newRotation = Game.avatarManager.getAvatarAngle()-90;
			//trace("spawnPoint",spawnPoint);
			var vector:Point;
			//variances that come from bullet properties that affect spawning
			var spread:Number;
			//trace("setSpawnTime");
			setSpawnTime();
			//get initial position from the avatar
			this.x = spawnPoint.x;
			this.y = spawnPoint.y;
			//trace(this.x);
			//get initial velocity from keyInputManager or avatar direction based on controller input
			
			this.rotation = newRotation;
			
			//if the vector is affected by bullet properties
			if(utilities.Actors.Stats.WeaponStats.getBlobular() > 0){
				/*spread = change_vector_based_on_bullet_properties();
				spread = Math.random()*spread*2 - spread;
				vector = MathFormulas.degreesToSlope(Game.avatarManager.getAvatarAngle() + spread);
				this.rotation += spread; */
			}else{
				//if the vector is not affected by bullet properties
				vector = MathFormulas.degreesToSlope(Game.avatarManager.getAvatarAngle());
			}
			
			//angle based on direction avatar is facing when the bullet is spawned
			xVelocity = velocityMultiplier * vector.x;
			yVelocity = velocityMultiplier * vector.y;
			
			//used when keeping speed but changing angle or rotatiing
			var totalmove:Number = Math.sqrt(xVelocity * xVelocity + yVelocity * yVelocity);
				
			//apply easing
			xVelocity = speed*xVelocity/totalmove;
			yVelocity = speed*yVelocity/totalmove;
			//trace(this.x);
		}
		
		
		public function setInitialLocationAndVector():void{
			//trace("setInitialLocationAndVector");
			var spawnPoint:Point = Game.avatarManager.getAvatarLocation();
			
			//trace("spawnPoint",spawnPoint);
			var vector:Point;
			//variances that come from bullet properties that affect spawning
			var spread:Number;
			//trace("setSpawnTime");
			setSpawnTime();
			//get initial position from the avatar
			this.x = spawnPoint.x;
			this.y = spawnPoint.y;
			//trace(this.x);
			//get initial velocity from keyInputManager or avatar direction based on controller input
			
			this.rotation = Game.avatarManager.getAvatarAngle();
			
			//if the vector is affected by bullet properties
			if(utilities.Actors.Stats.WeaponStats.getBlobular() > 0){
				/*spread = change_vector_based_on_bullet_properties();
				spread = Math.random()*spread*2 - spread;
				vector = MathFormulas.degreesToSlope(Game.avatarManager.getAvatarAngle() + spread);
				this.rotation += spread; */
			}else{//if the vector is not affected by bullet properties
				
				//for 360 degree shooting
				//vector = MathFormulas.degreesToSlope(Game.avatarManager.getAvatarAngle() - 90);
				
				//for only left & right shooting
				vector = MathFormulas.degreesToSlope(Main.keyInputManager.getAimAngle());
			}
			
			//angle based on direction avatar is facing when the bullet is spawned
			xVelocity = velocityMultiplier * vector.x;
			yVelocity = velocityMultiplier * vector.y;
			
			//used when keeping speed but changing angle or rotatiing
			var totalmove:Number = Math.sqrt(xVelocity * xVelocity + yVelocity * yVelocity);
				
			//apply easing
			xVelocity = speed*xVelocity/totalmove;
			yVelocity = speed*yVelocity/totalmove;
			//trace(this.x);
		}
		
		private function change_vector_based_on_bullet_properties():int{
			return utilities.Actors.Stats.WeaponStats.getBlobSpreadRate();
		}
		
		
		//this records the moment the bullet was created
		 private function setSpawnTime():void {
           spawnTime = getTimer();
        }
		
		//all this should be separated out into its own classes eventually once they nuts and bolts are figured out
		private function applyBulletBehaviors():void{
			//trace("utilities.Actors.Behaviors.Behavior_HeatSeeking",utilities.Actors.Behaviors.Behavior_HeatSeeking);
			//bullets that speed up over time
			/*if(utilities.Actors.Stats.WeaponStats.getSpeedy() >0){
				]]xVelocity *= utilities.Actors.Behaviors.SpeedyBullet.getVelocityMultiplier();
				yVelocity *= utilities.Actors.Behaviors.SpeedyBullet.getVelocityMultiplier();
			}*/
			//heat seeking
			if(utilities.Actors.Stats.WeaponStats.getHeatSeeking() >0){
				utilities.Actors.Behaviors.Behavior_HeatSeeking.heatSeeking(this,deltaX,deltaY,xVelocity,yVelocity);
				if(get_hasTargetFlag()==true && getTarget() != null){
					var newVels:Point = utilities.Actors.Behaviors.Behavior_HeatSeeking.updateVelocities();
					xVelocity = newVels.x;
					yVelocity = newVels.y;
					//trace(this.x);
				}
			}
			//bullets that are blobular
			/*if(utilities.Actors.Stats.WeaponStats.getBlobular() >0){
				//blobBehavior("speedyBullet");
				for each(var bullet:Bullet in BulletManager.bullets){
					if(bullet != this){//don't check the bullet against itself
						if( this.getQuadTreeNode() == bullet.getQuadTreeNode() ){
							// bullet_behaviors//do blubluar stuff
							//this whole minDist business really should get pushed down into the math formulas, its confusing to read
							//perhaps i need to break it into to 2 functions, one that returns and that doesn't
							var minDist = (this.width/2 + bullet.width/2) * (this.width/2 + bullet.width/2);
							if(MathFormulas.distanceFormulaOptimized(this,bullet) < minDist){
								//trace("a collision occured");
								//delete the bullet and the enemy
								//enemy.takeDamage(bullet.damage);
								
							}
						}
					}
				}
			}*/
		}
	}
}