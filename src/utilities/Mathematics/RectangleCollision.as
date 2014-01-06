/*
	Author - Jonathan Justice
	VERY IMPORTANT:
	this assumes both rectangles have their registration points in the center.
	Resolution vectors are dependent on the tick prior to collision!
	this collision model is only useful for interactions where ONLY 1 rectangle is moving(i.e. platformers)
*/
package utilities.Mathematics{
	import flash.display.MovieClip;
	import utilities.Actors.Avatar;
	import utilities.Actors.GameBoardPieces.MovingWall;
	import utilities.Engine.Combat.AvatarManager;
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
		 
		
		public static function testCollision(movable:MovieClip, stationary:MovieClip,resolveCollisions:Boolean=true):String {
			var collisionEjectDistance:Number = 1;//don't get stuck in the other rectangle
			var collidedWithTop:Boolean = false;
			var collisionSide:String = "";
			
			//moveable is above stationary
			//trace("M", movable);
			//trace("S", stationary);
			/*if (movable is Avatar && stationary is MovingWall) {
				trace("movable & avatar");
				//trace("moveable: ", movable);
				if (movable.getPreviousPosition().y + movable.hitbox.height <= stationary.getPreviousPosition().y) {
					collisionSide = "top";
					if (resolveCollisions == true) {
						trace("resolveCollisions: ", resolveCollisions);
						movable.y = stationary.y - movable.hitbox.height - (collisionEjectDistance - stationary.yVelocity);
						//movable.y -= stationary.yVelocity;
						movable.x += stationary.xVelocity *2;
					}
				}
			}*/
			
			if (movable.getPreviousPosition().y + movable.hitbox.height <= stationary.getPreviousPosition().y) {
				collisionSide = "top";
				if (resolveCollisions == true) {
					//trace("resolveCollisions: ", resolveCollisions);
					movable.y = stationary.y - movable.hitbox.height - (collisionEjectDistance - stationary.yVelocity);
					movable.y -= stationary.yVelocity;
					movable.x += stationary.xVelocity *2;
				}
			}
			//movable is below stationary
			else if (movable.getPreviousPosition().y >= stationary.getPreviousPosition().y + stationary.hitbox.height) {
				collisionSide = "bottom";
				if(resolveCollisions == true){
					movable.y = stationary.y + stationary.hitbox.height + collisionEjectDistance *2;
					movable.reduceJumpSpeed();
				}	
			}
			//moveable's is to the left
			else if (movable.getPreviousPosition().x + movable.hitbox.width <= stationary.getPreviousPosition().x) {
				collisionSide = "left";
				if(resolveCollisions == true){
					movable.x = stationary.x - movable.hitbox.width - collisionEjectDistance;
				}
				//trace("stationary.getPreviousPosition().x",stationary.getPreviousPosition().x);
				
			}
			//moveable is to the right
			else if (movable.getPreviousPosition().x >= stationary.getPreviousPosition().x + stationary.hitbox.width) {
				collisionSide = "right";
				if (resolveCollisions == true) {
					movable.x = stationary.x + stationary.hitbox.width + collisionEjectDistance;
				}	
			}
			else{
				//trace("else, this should never fire, if it does, WHAT DID YOU DO?");
				//movable.y = stationary.y - movable.hitbox.height - collisionEjectDistance;
			}
			return collisionSide;
		}
		
		//check to see if you are on top of something and partially past its boundaries, usually for forcing something to turn around if it is going to go over the edge
		public static function isRectangleOnTopAndTryingToExceedBoundsOfLowerRectangle(movable:MovieClip, stationary:MovieClip):Boolean {
			var isOnTop:Boolean = false;
			if (movable.getPreviousPosition().y + movable.hitbox.height<= stationary.y) {
				if (movable.getPreviousPosition().x + movable.hitbox.width + movable.xVelocity >= stationary.getPreviousPosition().x + stationary.hitbox.width) {
					isOnTop = true;
				}
				if (movable.getPreviousPosition().x + movable.xVelocity <= stationary.getPreviousPosition().x) {
					isOnTop = true;
				}
			}
			return isOnTop;
		}
		
		public static function testCollisionWithPlatform(movable:MovieClip, stationary:MovieClip):Boolean {
			var collisionEjectDistance:Number = 1;//don't get stuck in the other rectangle
			var isOnTop:Boolean = false;
			if (movable.getPreviousPosition().y + movable.hitbox.height <= stationary.y) {
				if (movable.getPreviousPosition().x + movable.hitbox.width >= stationary.getPreviousPosition().x) {
					isOnTop = true;
				}
				if (movable.getPreviousPosition().x <= stationary.getPreviousPosition().x + stationary.hitbox.width) {
					isOnTop = true;
				}
				if (isOnTop) {
					movable.y = stationary.y - movable.hitbox.height - collisionEjectDistance;
				}
			}
			return isOnTop;
		}
	 }
}