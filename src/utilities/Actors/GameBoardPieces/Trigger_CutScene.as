﻿package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	import utilities.Engine.Game;
	public class Trigger_CutScene extends SelectableActor{
		private var isBulletBlocker:Boolean = false;
		private var filePath:String = "../src/assets/actors/swf_wall.swf";
		private var tempWidth:Number = 0;
		private var tempHeight:Number = 0;
		private var wallType:String = "trigger";
		private var triggerIndex:int = 0;
		private var cutSceneName:String = "";
		public function Trigger_CutScene(newX:int, newY:int, newWidth:Number, newHeight:Number, newCutSceneName:String) {
			//print("wewewewewe");
			cutSceneName = newCutSceneName;
		//	trace("cutSceneName", cutSceneName);
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
		
		public function setUp():void{
			defineGraphics("wall", false);
			xVelocity = 0;
			yVelocity = 0;
			
			//this.visible = false;
		}
	
		public override function onTakeDamage():void {
			//overriden by each individual class
			//used for feedback mostly
			//LevelManager.getInstance().setIsLevelComplete(true);
			Game.setGameState("startInGameCutScene",cutSceneName);
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
			
			this.scaleX = tempWidth;
			this.scaleY = tempHeight;
			this.visible = false;
			addActorToGameEngine(graphic, LevelManager.triggers_cutScenes);
			graphic = hitbox;
		}
		
		public function updateLoop():void{
			
		}
		
		public function wallTest():void {
			trace("fuck yeah it worked");
		}
		
		public function defineBounds(newWidth:Number,newHeight:Number):void {
			this.width = newWidth;
			this.width = newHeight;
		}
	}
}