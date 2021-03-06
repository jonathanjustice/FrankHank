﻿package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	public class BossWall extends SelectableActor{
		private var isBulletBlocker:Boolean = false;
		private var filePath:String = "../src/assets/actors/swf_wall.swf";
		private var tempWidth:Number = 0;
		private var tempHeight:Number = 0;
		private var wallType:String = "standard";
		public function BossWall(newX:int, newY:int, newWidth:Number, newHeight:Number, newWallType:String ) {
			setType(newWallType);
			setUp();
			tempWidth = newWidth;
			tempHeight = newHeight;
			this.x = newX;
			this.y = newY;
			/*print(String("newX: " + newX + " newY: " + newY + " newWidth: " + newWidth + " newHeight: " + newHeight)); 
			this.scaleX = newWidth;
			this.scaleY = newHeight;
			
			print(String("newX: " + x + " newY: " + y + " newWidth: " + scaleX + " newHeight: " + scaleY)); 
			*/
		}
		
		public function setUp():void{
			defineGraphics("wall", false);
			xVelocity = 0;
			yVelocity = 0;
			
			//this.visible = false;
		}
		
		public function setType(newType:String):void {
			wallType = newType;
		}
		
		public function getType():String {
			return wallType;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			addActorToGameEngine(graphic, LevelManager.bossWalls);
			this.hitbox.width = this.tempWidth;
			this.hitbox.height = this.tempHeight;
			this.visible = true;
		}
		
		public function updateLoop():void{
			setPreviousPosition();
		}
		
		public function wallTest():void {
			//deprecated
		}
		
		public function defineBounds(newWidth:Number,newHeight:Number):void {
			this.width = newWidth;
			this.width = newHeight;
		}
	}
}