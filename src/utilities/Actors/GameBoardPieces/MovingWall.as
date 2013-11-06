package utilities.Actors.GameBoardPieces{
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	public class MovingWall extends SelectableActor{
		private var isBulletBlocker:Boolean = false;
		private var filePath:String = "../src/assets/actors/swf_wall.swf";
		private var tempWidth:Number = 0;
		private var tempHeight:Number = 0;
		private var wallType:String = "platform";
		private var nodes:Array = new Array;
		private var currentNode:MovieClip;
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
			defineGraphics("wall",false);
			
			//this.visible = false;
			
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
			this.visible = false;
			addActorToGameEngine(graphic, LevelManager.walls);
			if (graphic is MovieClip) {
					var myClip:MovieClip = graphic as MovieClip;
					trace("1",myClip);
					trace("2",myClip.swf_child);
					trace("3",myClip.swf_child.numChildren);
				//	trace("4",myClip.swf_child.child.name);
				//defineNodes(myClip);
			}
			
		}
		
		public function updateLoop(e:Event):void {
			moveToNextNode();
		}
		
		public function moveToNextNode():void {
			trace("move to next node");
			this.x += xVelocity;
			this.y += yVelocity;
		}
		
		public function defineNodes(array:Array):void {
			nodes = array;
			trace("nodes: ",nodes);
			this.addEventListener(Event.ENTER_FRAME, updateLoop);
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