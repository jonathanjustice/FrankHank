//if there are no enemies at all & you are not shooting, bullets are not losing their target
//if there are no enemies at all & you are shooting, all bullets are incorrectly having their vectors set to what new bullets are


package utilities.Actors.Behaviors{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import utilities.Mathematics.MathFormulas;
	import utilities.Engine.Game;
	import utilities.Engine.Combat.EnemyManager;
	
	public class Behavior_HeatSeeking extends MovieClip{
		
		//private var gameContainer;
		//private static var target;
		//private static var hasTarget:Boolean = false;
		private static var turnRate:Number = 5;
		private static var turnRateFactor:Number = 0;
		private static var lastRotation:Number=0;
		private static var rotationDifference:Number=0;
		private static var minSpeed:Number=2;
		private static var maxSpeed:Number=6;
		private static var hasLostTarget:Boolean=false;
		private static var speed:Number = 15;
		private static var myRotation:Number=0;
		private static var xVel:Number=0;
		private static var yVel:Number=0;
		
		public function Behavior_HeatSeeking(){
			
		}
		
		//If the bullet has a target seek it,
		//check all the various ways that bullet might not have a target
		public static function heatSeeking(bullet:MovieClip,deltaX:Number,deltaY:Number,xVelocity:Number,yVelocity:Number):void{
			
			//if the bullet doesnt have a target, get one
			if(bullet.get_hasTargetFlag() == false || bullet.getTarget() == null || bullet.getTarget().get_availableForTargeting() == false){//if I don't have a target, or I lost my target on the last frame, then find a new target
				//trace(bullet.getTarget());
				bullet.setTargetToFalse();
				//bullet.setHasTargetToFalse();
				findNewTarget(bullet);
			}
			//if the bullet has a target, seek it
			if(bullet.get_hasTargetFlag()==true && bullet.getTarget().get_availableForTargeting() == true){//if the target was not lost on the previous frame, continue to seek it
				seekTarget(bullet,deltaX,deltaY,xVelocity,yVelocity);
			}
		}
		
		//find the closest target to the bullet, by comparing the distances of all the bullets
		//when a closer target is found, define that as the target of the bullet
		private static function findNewTarget(bullet:MovieClip):void{
			var prevDistance:int = int.MAX_VALUE;
			for (var i:int = 0; i < EnemyManager.enemies.length; i++) {
				var dist:Number = MathFormulas.distanceFormula(EnemyManager.enemies[i],bullet);
				//var dist:Number = MathFormulas.distanceFormula(new Point(EnemyManager.enemies[i].x,EnemyManager.enemies[i].y),new Point(bullet.x,bullet.y));
				if(dist < prevDistance){
					prevDistance = dist;
					bullet.setTargetToTrue();
					bullet.setTarget(EnemyManager.enemies[i]);
					bullet.getTarget().set_availableForTargetingToTrue();
				}
			}
		}
		
		private static function seekTarget(bullet:MovieClip,deltaX:Number,deltaY:Number,xVelocity:Number,yVelocity:Number):void{
			var newTarget:MovieClip = bullet.getTarget();
			//trace("seeking");
			//get the difference in rotation between this turn and last turn
			rotationDifference = Math.abs(bullet.rotation - lastRotation);
			var slope:Point = new Point(0,0);
			var origin:Point = new Point(0,0);
			var bulletPoint:Point = new Point(0,0);
			var targetPoint:Point = new Point(0,0);//location of the target
			var distanceX:Number = 0;
			var distanceY:Number = 0;
			var distanceTotal:Number = 0;
			
			if(bullet.get_hasTargetFlag()==true && newTarget.get_availableForTargeting() == true){//only change the delta if the missle has a target
				bulletPoint.x = bullet.x
				bulletPoint.y = bullet.y;
				//trace(bulletPoint);
				
				//get distance between follower and target
				//distance between target and bullet per axis
				distanceX = newTarget.x - bullet.x;
				distanceY = newTarget.y - bullet.y;
				
				//get total distance between bullet and target
				distanceTotal = Math.sqrt(distanceX * distanceX + distanceY * distanceY);
				//trace(distanceTotal);
				
				//if the missle is turning heavily slow it down, if its barely turning, sspeed it up
				if(rotationDifference < 6){speed +=.25}else{speed -=.25};
				//cap the minimum & maximum speeds
				if(speed > maxSpeed){speed = maxSpeed};
				if(speed < minSpeed){speed = minSpeed};
			
				//determine the deltas
				//delta is the rate of turn * the distance between the objects / previous total movement speed
			
				deltaX = turnRate * distanceX / distanceTotal;
				deltaY = turnRate * distanceY / distanceTotal;
				
				//increment current speed
				xVelocity += deltaX;
				yVelocity += deltaY;
					
				//get the new  total move distance
				var totalmove:Number = Math.sqrt(xVelocity * xVelocity + yVelocity * yVelocity);
				
				//apply easing
				xVelocity = speed*xVelocity/totalmove;
				yVelocity = speed*yVelocity/totalmove;
				//trace(xVelocity,yVelocity)
				//use the slope of the movement vector to determine the direction of the bullet
				slope.x = xVelocity, slope.y = yVelocity;
				myRotation = MathFormulas.getAngle(slope,origin);
				//for making it turn faster as it turns
				//deprecated for now
				bullet.x += xVelocity;
				bullet.y += yVelocity;
				xVel = xVelocity;
				yVel = yVelocity;
				turnRate += turnRateFactor;
				//set the last rotation so that it can be calculated against to determine how deltas should change
				lastRotation = bullet.rotation;
				bullet.rotation = myRotation;
				//set the last rotation so that it can be calculated against to determine how deltas should change
				
				//bullet.rotation = myRotation;
			}else{//just in case the game fucks up, bullets will do something
				trace("Behavior_HeatSeeking: This should have never happened. You broke something");
				
			}
			//move the bullet, even if there is no target
			//trace("speed",speed);
		}
		
		public static function updateVelocities():Point{
			var newVels:Point = new Point(0,0);
			newVels.x = xVel;
			newVels.y = yVel;
			return newVels;
		}
		
		
		
	}
}