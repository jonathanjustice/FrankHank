﻿package utilities.Actors.GameBoardPieces{
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
		private var initialPoint:Point = new Point(0, 0);
		private var triggerable:Boolean = false;
		private var isActive:Boolean = true;
		private var triggerIndex:int = 0;
		private var originalXVelocity:int = 0;
		private var originalYVelocity:int = 0;
		private var triggeredWallXVelocity:int = 20;
		private var triggeredWallYVelocity:int = 20;
		 
		//create a var tween
		
		public function MovingWall(newX:int, newY:int, newWidth:Number, newHeight:Number, newWallType:String, newIndex:int = 0) {
			setType(newWallType);
			triggerIndex = newIndex;
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
		
		public function setUp():void {
			nodeSequencing = "forward";
			isActive = true;
			defineGraphics("wall", false);
			xVelocity = 3;
			yVelocity = 3;
			originalXVelocity = xVelocity;
			originalYVelocity = yVelocity;
			
			
			//this.visible = false;
			
		}
		
		public function defineInitialPoint():void {
			initialPoint.x = this.x;
			initialPoint.y = this.y;
			for (var i:int = 0; i < this.getNodes().length; i++) {
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
			
			if (wallType == "triggeredWall") {
				isActive = false;
				triggerable = true;
				xVelocity = triggeredWallXVelocity;
				yVelocity = triggeredWallYVelocity;
				
				originalXVelocity = xVelocity;
				originalYVelocity = yVelocity;
				addActorToGameEngine(graphic, LevelManager.triggerableWalls, triggerIndex);
			}else {
				addActorToGameEngine(graphic, LevelManager.walls);
			}
			defineGraphicsDefaultSmallRectangle();
		}
		
		public function setIsActive(newState:Boolean):void {
			isActive = newState;
		}
		
		public function updateLoop():void {
			setPreviousPosition();
			if (isActive == true) {	
				moveToNextNode();
			}else if (isActive == false) {
				
			}
		}
		
		public function setNewTarget():void {
			if (nodeSequencing == "forward") {
				trace("settign");
				//if reached last node switch to decrementing
				if (targetNode == this.getNodes().length - 1) {
					if (triggerable == true) {
						isActive = false;
						trace("is triggerable and now set isActive to false");
					}
					
					if(isActive == true){
						nodeSequencing = "backward";
						trace("switch to backward")
						targetNode--;
						trace("DE crementing Node");
						trace("targetNode: ",targetNode)
					}
				}
				//if incrementing, select next node
				else if (targetNode < this.getNodes().length) {
					targetNode++;
					trace("incrementing Node");
					trace("targetNode: ", targetNode);
					trace(isActive);
				}
				trace("outside statement");
				
				
			}else if (nodeSequencing == "backward") {
				//if reached first node, switch to incrementing
				if (targetNode == 0) {
					nodeSequencing = "forward";
					targetNode++;
					
					trace("switch to forward");
					trace("incrementing Node");
					trace("targetNode: ", targetNode);
					trace("isactive",isActive);
					trace("triggerable",triggerable);
				}
				//if decrementing, select next node
				else if (targetNode > 0) {
					targetNode--;
					trace("DE crementing Node");
					trace("targetNode: ",targetNode)
				}
				
				
			}
		}
		
		public function moveToNextNode():void {
			if (horizontalMotion != "arrived") {
				if (this.x - initialPoint.x < this.getNodes()[targetNode].x) {
					xVelocity = originalXVelocity;
				}else if(this.x - initialPoint.x > this.getNodes()[targetNode].x){
					xVelocity = -originalXVelocity;
				}
				
			}
			
			if (verticalMotion != "arrived") {
					if (this.y - initialPoint.y < this.getNodes()[targetNode].y) {
					yVelocity = originalYVelocity;
				}else if(this.y - initialPoint.y > this.getNodes()[targetNode].y){
					yVelocity = -originalYVelocity;
				}
				
			}
		
			this.x += xVelocity;
			this.y += yVelocity;
			/*
			trace("this.x:", this.x);
			trace("this.y:", this.y);
			trace("targetNode:", targetNode);
			trace("this.getNodes()[targetNode]",this.getNodes()[targetNode]);
  			trace("targetNode.x",this.getNodes()[targetNode].x);
			trace("targetNode.y", this.getNodes()[targetNode].y);
			*/
			//if you are close to the targetPoint, align to the targetPoint
			if (Math.abs(this.x - initialPoint.x - this.getNodes()[targetNode].x) < xVelocity * 2) {
				horizontalMotion = "arrived";
				xVelocity = 0;
			}
			if (Math.abs(this.y - initialPoint.y - this.getNodes()[targetNode].y) < yVelocity * 2) {
				verticalMotion = "arrived";
				yVelocity = 0;
			}
			
			
			
			
			if (horizontalMotion == "arrived" && verticalMotion == "arrived") {
				verticalMotion = "nope";
				horizontalMotion = "nope";
				setNewTarget();
			}
		}
		public function wallTest():void {
			
		}
		
		public function defineBounds(newWidth:Number,newHeight:Number):void {
			this.width = newWidth;
			this.width = newHeight;
		}
	}
}