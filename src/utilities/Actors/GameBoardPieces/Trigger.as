package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	public class Trigger extends SelectableActor{
		private var isBulletBlocker:Boolean = false;
		private var filePath:String = "../src/assets/actors/swf_wall.swf";
		private var tempWidth:Number = 0;
		private var tempHeight:Number = 0;
		private var wallType:String = "trigger";
		private var triggerIndex:int = 0;
		public function Trigger(newX:int, newY:int, newWidth:Number, newHeight:Number, newIndex:int) {
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
		
		public function setUp():void{
			defineGraphics("wall", false);
			xVelocity = 0;
			yVelocity = 0;
			
			//this.visible = false;
		}
		/*
		public override function addActorToGameEngine(graphic:DisplayObject,array:Array,spliceIndex:int):void {
			setPreviousPosition();
			assignedGraphic[0] = graphic;
			this.addChild(graphic);
			utilities.Engine.Game.gameContainer.addChild(this);
			setIsSwfLoaded(true);
			//array.push(this);
			spliceIndex = triggerIndex;
			array.splice(spliceIndex, 0, this);
		}
		*/
		public function setTriggerIndex(newIndex:int):void {
			triggerIndex = newIndex;
		}
		
		public function getTriggerIndex():int {
			return triggerIndex;
		}
		
		public override function onTakeDamage():void {
			//overriden by each individual class
			//used for feedback mostly
			LevelManager.getInstance().activateTriggerableWall(triggerIndex);
				
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
			addActorToGameEngine(graphic, LevelManager.triggers,triggerIndex);
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