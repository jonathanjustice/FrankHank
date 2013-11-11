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
			yVelocity = 1;
			
			
			//this.visible = false;
			
		}
		
		public function defineInitialPoint():void {
			initialPoint.x = this.x;
			initialPoint.y = this.y;
			trace("initialPoint", initialPoint);
			for (var i:int = 0; i < this.getNodes().length; i++) {
				trace("NODE_", i, ".x", this.getNodes().x);
				trace("NODE_", i, ".y", this.getNodes().y);
			}
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
			trace(" OLD targetNode:",targetNode);
			if (nodeSequencing == "forward") {
				trace("nodeSequencing", nodeSequencing);
				//if reached last node switch to decrementing
				trace("this.getNodes().length", this.getNodes().length);
				
				if (targetNode == this.getNodes().length-1) {
					nodeSequencing = "backward";
					targetNode--;
				}
				//if incrementing, select next node
				else if (targetNode < this.getNodes().length-1) {
					targetNode++;
				}
				
			}else if (nodeSequencing == "backward") {
				//if reached first node, switch to incrementing
				if (targetNode == 0) {
					nodeSequencing = "forward";
					targetNode++;
				}
				//if decrementing, select next node
				else if (targetNode > 0) {
					targetNode--;
				}
				
				
			}
			trace(" NEW targetNode:",targetNode);
		}
		
		public function moveToNextNode():void {
			if (horizontalMotion != "arrived") {
				if (this.x - initialPoint.x < this.getNodes()[targetNode].x) {
					xVelocity = 2;
				}else if(this.x - initialPoint.x > this.getNodes()[targetNode].x){
					xVelocity = -2;
				}
				
			}
			
			if (verticalMotion != "arrived") {
					if (this.y - initialPoint.y < this.getNodes()[targetNode].y) {
					yVelocity = 2;
				}else if(this.y - initialPoint.y > this.getNodes()[targetNode].y){
					yVelocity = -2;
				}
				
			}
		
			this.x += xVelocity;
			this.y += yVelocity;
			
			trace("this.x:", this.x);
			trace("this.y:", this.y);
			trace("targetNode:", targetNode);
			trace("this.getNodes()[targetNode]",this.getNodes()[targetNode]);
  			trace("targetNode.x",this.getNodes()[targetNode].x);
			trace("targetNode.y",this.getNodes()[targetNode].y);
			//if you are close to the targetPoint, align to the targetPoint
			if (Math.abs(this.x - initialPoint.x - this.getNodes()[targetNode].x) < xVelocity * 2) {
				horizontalMotion = "arrived";
				print("H: arrived");
				xVelocity = 0;
			}
			if (Math.abs(this.y - initialPoint.y - this.getNodes()[targetNode].y) < yVelocity * 2) {
				verticalMotion = "arrived";
				print("V: arrived");
				yVelocity = 0;
			}
			
			
			
			
			if (horizontalMotion == "arrived" && verticalMotion == "arrived") {
				print("Both: arrived");
				verticalMotion = "nope";
				horizontalMotion = "nope";
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