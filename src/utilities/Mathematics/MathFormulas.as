/*
	authors
	Jeremy Wolff
	Daniel Plemmons
	Jon Justice
*/
// you need to go back and comment this code, because i dont remember how all of it works
package utilities.Mathematics{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	//import gameobjects.Mallet;
	public class MathFormulas {
		//private var gravConst:Number;//6.673 *10^-11;(REAL GRAVITY)
		public function MathFormulas(){
			//Stand back I'm about to try Math!
		}
		
		/*public static function convertLocalPositionToGlobal(object):Point{
			trace("O",object.x,object.y);
			var globalPoint:Point = object.localToGlobal(new Point(0,0));
			trace("GP",globalPoint);
			return globalPoint;
		}
		*/
		/*public static function convertLocalPositionToGlobal(point:Point):Point{
			trace("O",point.x,point.y);
			var globalPoint:Point = point.localToGlobal(point);
			trace("GP",globalPoint);
			return globalPoint;
		}
		
		public static function convertGlobalPositionToLocal(object):Point{
			trace("O",object.x,object.y);
			var globalPoint:Point = object.globalToLocal(new Point(0,0));
			trace("GP",globalPoint);
			return globalPoint;
		}*/
		
		//convert an angle to a 360 degree format instead of 0 to 180 or 0 to -180 format
		public static function convertTo360Angle(angleToNormalize:Number):Number{
			var convertedAngle:Number=0;
			if(angleToNormalize > -180 && angleToNormalize <= -0){
				convertedAngle = 360 + angleToNormalize;
			}
			return convertedAngle;
		}
		
		//to convert radians to degrees, multiply by 180/p, like this:
		public static function radiansToDegrees(rad:Number):Number{
			var degrees:Number = rad * (180 / Math.PI);
			return degrees;
		}
		
		//Useful for calculating x & y velocities
		//send it degrees, it will give you a vector as an x,y point
		public static function degreesToSlope(deg:Number):Point {
			var rad:Number = (deg-90) * Math.PI / 180;
			return new Point(Math.cos(rad), Math.sin(rad));
		}
		
		public static function getAngle(pt1:Point, pt2:Point):Number {
			var distanceX : Number = pt1.x - pt2.x;
			var distanceY : Number = pt1.y - pt2.y;
			var angleInRadians : Number = Math.atan2(distanceY, distanceX);
			var angleInDegrees : Number = angleInRadians * (180 / Math.PI);
			return angleInDegrees;
		}
		
		// returns the distance between 2 points
		public static function distanceFormula(p1:MovieClip,p2:MovieClip):Number{
			var dist:Number,dx:Number,dy:Number;
			dx = p2.x-p1.x;
			dy = p2.y-p1.y;
			dist = Math.sqrt(dx*dx + dy*dy);
			//trace(dist);
			return dist;
		}
		
		public static function Point_Object_At_Target(object:MovieClip,point:Point):void{
			var distanceX : Number = object.x - point.x;
			var distanceY : Number = object.y - point.y;
			var angleInRadians : Number = Math.atan2(distanceY, distanceX);
			var angleInDegrees : Number = angleInRadians * (180 / Math.PI)-90;
			//return angleInDegrees;
			//trace(angleInDegrees);
			object.rotation = angleInDegrees;
		}
		
		//faster version, need to multiply min dist by itself in other file
		public static function distanceFormulaOptimized(p1:MovieClip,p2:MovieClip):Number{
			var dist:Number;
			dist = (p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y);
			return dist;
		}
		
		//returns change in position that should be applied to 1 object due to gravity
		public static function gravity(obj1:MovieClip, obj2:MovieClip,gravity:Number):Point{
			gravity=.65;
			var xDiff:Number = obj1.x - obj2.x;//difference between 2 objects on x axis
			var yDiff:Number = obj1.y - obj2.y;//diff between 2 objecgts on y axis
			var fg:Number;//the force of gravity to be applied to the object
			var gravConst:Number = gravity;//6.673 *10^-11; is set from the game class
			var m1:Number = 25;//the mass of object 1
			var m2:Number = 25;//the mass of object 2
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
		
		//returns the new delta X and Y for only the first object
		public static function circleToCircleCollision(obj1:MovieClip, obj2:MovieClip, multiplier:Number):Point {
			
				
				//horizontal distance between the two object centers
                var run:Number=obj1.x-obj2.x;
				//verticle distance between the two object centers
                var rise:Number=obj1.y-obj2.y;
				//the horizontal velocity at which the two objects are approaching
                var vel_run:Number=obj1.deltaX - obj2.deltaX;
				//the verticle velocity at which the two objects are approaching
                var vel_rise:Number=obj1.deltaY - obj2.deltaY;
				//original horizontal posistion of obj1
                var oldselfvx:Number=obj2.deltaX;
				//original verticle possition of obj1
                var oldselfvy:Number=obj2.deltaY;
				//original radius of obj1
                var oldselfr:Number=obj2.radius;
				//original radius of obj2
                var oldbr:Number=obj1.radius;
				//combined radii of obj1 and obj2
                var radii:Number=obj1.radius + obj2.radius;
				//Distance between the centers of obj1 and obj2: squareroot of ((x2-x1)^2 + (y2-y1)^2)
                var distCollision:Number=Math.sqrt(run*run+rise*rise);
				var normalX:Number;
				var normalY:Number;
				var dVector:Number;
				var dvx:Number;
				var dvy:Number;
				var oldBX:Number=obj1.deltaX;
				var oldBY:Number=obj1.deltaY;
				var bouncyness:Number=1
				
				// return old velocities if bodies are not approaching
				if ((vel_run * run + vel_rise * rise) >= 0) {
					//return;
					//I'm not really sure how this is supposed to work
					return(new Point(obj1.deltaX,obj1.deltaY));
				}
				
				normalX=run/distCollision;
				normalY=rise/distCollision;
				dVector = (obj2.deltaX - obj1.deltaX) * normalX + (obj2.deltaY - obj1.deltaY) * normalY;
				dvx= dVector*normalX;
				dvy= dVector*normalY;
				
				var addToDeltaX:Number = dvx*bouncyness * multiplier;//the additional speed added to the deltas of the object
				var addToDeltaY:Number = dvy*bouncyness * multiplier;
				return(new Point(addToDeltaX,addToDeltaY));
		}
		
		//experimental stuff
		//doesn't actually work yet

		protected function getAnglesDiff(alfa : Number, gamma : Number) : Number {
		 
			var dif : Number = (alfa - gamma) % 360;
		 
			if (dif != dif % 180) {
		 
				dif = (dif < 0) ? dif + 360 : dif - 360;
			}
			return dif;
		}

		//NOTE:--------------------I'm fairly certain these two normalize vector functions don't work right yet
		//takes angle, makes that angle 0, and then calculate a new angle from a point
		public static function normalizeVector(vectorToNormalize:Number, myPoint:Point, pointToCalculateAgainst:Point):Number{
			
			var convertedAngle:Number=0;
			
			//pointToCalculateAgainst
			var normalizedVector:Number=0;
			if(vectorToNormalize > -180 && vectorToNormalize <= -0){
				//convertedAngle = 360 + vectorToNormalize;
			}
			
			normalizedVector = 0 - vectorToNormalize;
			//trace("vectorToNormalize",vectorToNormalize);
			//trace("normalizedVector",normalizedVector);
			return normalizedVector;
		}
		
		public static function normalizeVectorWithAngles(vectorToNormalize:Number, otherAngle:Number):Number{
			
			var convertedAngle:Number=0;
			
			//pointToCalculateAgainst
			var normalizedVector:Number=0;
			if(vectorToNormalize > -180 && vectorToNormalize <= -0){
				//convertedAngle = 360 + vectorToNormalize;
			}
			
			normalizedVector = 0 - vectorToNormalize;
			//trace("vectorToNormalize",vectorToNormalize);
			//trace("normalizedVector",normalizedVector);
			return normalizedVector;
		}
	}
}