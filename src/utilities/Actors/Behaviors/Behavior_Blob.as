package utilities.Actors.Behaviors{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import utilities.Mathematics.MathFormulas;
	
	public class Behavior_Blob extends MovieClip{
		private static var sizeVariance:Number=3;
		private static var massVariance:Number=10;
		
		//private var gameContainer;
		//private static var target;
		private static var hasTarget:Boolean = false;
		private static var turnRate:Number = 2;
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
		
		public function Behavior_Blob(){
			
		}
		
		//this shit doesn't work right >:(
		//find the closest possible enemy & define it as the target
		private static function findNewTarget(bullet){
			var prevDistance = 0;
			for (var i:int = 0; i<EnemyManager.enemies.length;i++){
				if(MathFormulas.distanceFormula(new Point(EnemyManager.enemies[i].x,EnemyManager.enemies[i].y),new Point(bullet.x,bullet.y)) > prevDistance){
					//var target = EnemyManager.enemies[i];
					hasTarget = true;
					bullet.setTarget(EnemyManager.enemies[i]);
					//trace("target",target);
				}
			}
		}
		
		//takes 2 points
		public static function blobulate(obj1, obj2,gravity):Point{
			gravity=.65;
			var xDiff:Number = obj1.x - obj2.x;//difference between 2 objects on x axis
			var yDiff:Number = obj1.y - obj2.y;//diff between 2 objecgts on y axis
			var fg:Number;//the force of gravity to be applied to the object
			var gravConst:Number = gravity;//6.673 *10^-11; is set from the game class
			
			var m1:Number = obj1.mass;//the mass of object 1
			var m2:Number = obj2.mass;//the mass of object 2
			var dist:Number = MathFormulas.distanceFormula(obj1,obj2)//distance between 2 objects
			
			//fg = (gravConst * m1*m2)/dist^2
			//6.673 x 10 ^-11
			fg = (gravConst * m1 * m2)/(dist * dist);//calculate force
			//trace(fg);
			var xChange :Number = fg * xDiff;//change on X axis
			var yChange :Number = fg * yDiff;//change on Y axis
			var positionChange:Point = new Point(xChange,yChange);
			return positionChange;
		}
		
		//for every other blubular bullet,
		//if I get close, get closer
		//if I get too close, get farther away
		
		
		
		public static function updateVelocities():Point{
			var newVels:Point = new Point(0,0);
			newVels.x = xVel;
			newVels.y = yVel;
			return newVels;
		}
		
		
		
	}
}