/*
	Author - Jonathan Justice
	VERY IMPORTANT:
	this assumes both rectangles have their registration points in the center.
	Resolution vectors are dependent on the tick prior to collision!
	this collision model is only useful for interactions where ONLY 1 rectangle is moving(i.e. platformers)
*/
package utilities.Mathematics{
	import flash.display.MovieClip;
	public class RectangleCollision{  
		 public function RectangleCollision(){
			
		 }
		 
		 //check to see if rectangles 1 & 2 are colliding, but no resolution
		 //in other words, the same things as hitTestObject
		 public static function simpleIntersection(rect_1:MovieClip,rect_2:MovieClip):Boolean{
			//If any of these are false, then then the rectangles are not colliding
			
			//rect 1's left side is farther right than rect 2's right side
			return!(rect_1.x > rect_2.x + (rect_2.width) 
			//rect 1's right side is farther left than rect 2's left side   
			|| rect_1.x + (rect_1.width) < rect_2.x 
			//rect 1's top side is further down than rect 2's bottom side
			|| rect_1.y > rect_2.y + (rect_2.height) 
			//rect 1's bottom side is further up than rect 2's top side
			|| rect_1.y + (rect_1.height) < rect_2.y);
		 }
		 
		//please update this to handle 2 moving rectangles, if desired
		//resolves collision between a stationary rectangle and a moving rectangle
		 public static function resolveCollisionBetweenMovingAndStationaryRectangles(movable:MovieClip, stationary:MovieClip):String {
			var collisionEjectDistance:Number = 1;//don't get stuck in the other rectangle
			var collidedWithTop:Boolean = false;
			var collisionSide:String = "";
		
			//moveable is above stationary
			if (movable.getPreviousPosition().y + movable.height <= stationary.y) {
				collisionSide = "top";
				movable.y = stationary.y - movable.height - collisionEjectDistance;
				//trace("top");
			}
			//movable is below stationary
			else if (movable.getPreviousPosition().y >= stationary.y + stationary.height) {
				movable.y = stationary.y + stationary.height + collisionEjectDistance;
				collisionSide = "bottom";
				//trace("bottom");
			}
			//moveable's is to the left
			else if (movable.getPreviousPosition().x + movable.width <= stationary.getPreviousPosition().x) {
				movable.x = stationary.getPreviousPosition().x - movable.width - collisionEjectDistance;
				collisionSide = "left";
				//trace("left");
			}
			//moveable is to the right
			else if (movable.getPreviousPosition().x >= stationary.getPreviousPosition().x + stationary.width) {
				movable.x = stationary.getPreviousPosition().x + stationary.width + collisionEjectDistance;
				collisionSide = "right";
				//trace("right");
			}
			else{
				//trace("else, this should never fire, if it does, WHAT DID YOU DO?");
				//movable.y = stationary.y - movable.height - collisionEjectDistance;
			}
			//trace("collisionSide: collisionSide:",collisionSide);
			return collisionSide;
		}
		
		public static function isRectangleOnTop(movable:MovieClip, stationary:MovieClip):Boolean {
			var isOnTop:Boolean = false;
			if (movable.getPreviousPosition().y + movable.height <= stationary.y) {
				if (movable.getPreviousPosition().x + movable.width >= stationary.getPreviousPosition().x + stationary.width) {
					isOnTop = true;
				}
				if (movable.getPreviousPosition().x <= stationary.getPreviousPosition().x) {
					isOnTop = true;
				}
			}
			return isOnTop;
		}
	 }
}