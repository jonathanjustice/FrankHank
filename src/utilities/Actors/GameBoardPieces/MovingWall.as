package utilities.Actors.GameBoardPieces{
	//import the Tween class
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	import flash.geom.Point;
	
	public class MovingWall extends SelectableActor{
		private var isBulletBlocker:Boolean = false;
		private var filePath:String = "../src/assets/actors/swf_wall.swf";
		private var tempWidth:Number = 0;
		private var tempHeight:Number = 0;
		private var wallType:String = "platform";
		private var currentNode:MovieClip;
		private var nodeSequencing:String = "forward";
		private var targetNode:int = 0;
		private var targetPoint:Point = new Point(0, 0);
		private var verticalMotion:String = "positive";
		private var horizontalMotion:String = "positive";
		private var initialPoint:Point = new Point(0,0);
		 
		//create a var tween
		
		public function MovingWall(newX:int, newY:int, newWidth:Number, newHeight:Number) {
			
			setUp();
			tempWidth = newWidth;
			tempHeight = newHeight;
			/*print(String("newX: " + newX + " newY: " + newY + " newWidth: " + newWidth + " newHeight: " + newHeight)); 
			this.scaleX = newWidth;
			this.scaleY = newHeight;
			this.x = newX;
			this.y = newY;
			print(String("newX: " + x + " newY: " + y + " newWidth: " + scaleX + " newHeight: " + scaleY)); 
		*/}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function setUp():void{
			defineGraphics("wall", false);
			xVelocity = 1;
			xVelocity = 1;
			
			
			//this.visible = false;
			
		}
		
		public function defineInitialPoint():void {
			initialPoint.x = this.x;
			initialPoint.y = this.y
			trace("initialPoint",initialPoint);
		}
		
		public function setType(newType:String):void {
			wallType = newType;
		}
		
		public function getType():String {
			return wallType;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			
			this.scaleX = tempWidth;
			this.scaleY = tempHeight;
			//this.visible = false;
			addActorToGameEngine(graphic, LevelManager.walls);
		
			defineGraphicsDefaultSmallRectangle();
		}
		
		public function updateLoop():void {
			setPreviousPosition();
			moveToNextNode();
		}
		
		public function setNewTarget():void {
			print("newTarget");
			trace("targetNode:",targetNode);
			//	var tween:Tween = new Tween(this, 'x', Regular.easeInOut, 0, 400, 1.5, true);
			
			if (nodeSequencing == "forward") {
				//if incrementing, select next node
				if (targetNode < getNodes.length) {
					targetNode++;
				}
				//if reached last node switch to decrementing
				if (targetNode >= getNodes.length) {
					nodeSequencing = "backward";
					targetNode--;
				}
			}
			
			if (nodeSequencing == "backward") {
				//if decrementing, select next node
				if (targetNode > 0) {
					targetNode--;
				}
				//if reached first node, switch to incrementing
				if (targetNode <= 0) {
					nodeSequencing = "forward";
					targetNode++;
				}
				
			}
			trace("targetNode:",targetNode);
			//getHitbox();
			//trace("this.x: ",this.x);
			//trace("this.getNodes:",this.getNodes());
			trace("targetNode.x: ",this.getNodes()[targetNode].x);
			if (this.x - initialPoint.x > this.getNodes()[targetNode].x) {
				horizontalMotion = "negative";
				this.x -= xVelocity;
			}else {
				horizontalMotion = "positive";
				this.x += xVelocity;
			}
			
			if (this.y - initialPoint.y> this.getNodes()[targetNode].y) {
				verticalMotion = "negative";
				this.y -= yVelocity;
			}else {
				verticalMotion = "positive";
				this.y += yVelocity;
			}
		}
		
		public function moveToNextNode():void {
			//trace("this.hitbox.x:",this.hitbox.x);
			trace("this.x:", this.x);
			trace("targetNode.x",this.getNodes()[targetNode].x);
			//if you are close to the targetPoint, align to the targetPoint
			if (Math.abs(this.x - initialPoint.x- this.getNodes()[targetNode].x) < xVelocity + 1) {
				this.x = this.getNodes()[targetNode].x;
				horizontalMotion = "arrived";
				print("H: arrived");
				this.x = this.getNodes()[targetNode].x;
			}
			if (Math.abs(this.y - initialPoint.y -  this.getNodes()[targetNode].y) < yVelocity + 1) {
				this.y = this.getNodes()[targetNode].y;
				verticalMotion = "arrived";
				print("V: arrived");
				this.y = this.getNodes()[targetNode].y;
			}
			
			if (verticalMotion == "negative") {
				this.y -= yVelocity;
				print("V: negative");
			}else if (verticalMotion == "positive") {
				this.y += yVelocity;
					print("V: positivr");
			}else if (verticalMotion == "arrived") {
				//no motion
			}
			
			if (horizontalMotion == "negative") {
				this.x -= xVelocity;
				print("H: negative");
			}else if (horizontalMotion == "positive") {
				this.x += xVelocity;
				print("H: psoitive");
			}else if (horizontalMotion == "arrived") {
				//no motion
			}
			
			
			if (horizontalMotion == "arrived" && verticalMotion == "arrived") {
				print("Both: arrived");
				setNewTarget();
			}
		}
		public function wallTest():void {
			//trace("fuck yeah it worked");
		}
		
		public function defineBounds(newWidth:Number,newHeight:Number):void {
			this.width = newWidth;
			this.width = newHeight;
		}
	}
}