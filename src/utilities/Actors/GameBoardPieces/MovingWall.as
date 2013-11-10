package utilities.Actors.GameBoardPieces{
	//import the Tween class
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
		private var currentNode:MovieClip;

		 
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
		
		/*public override function setPreviousPosition():void{
			getPreviousPosition().x = this.hitbox.x;
			getPreviousPosition().y = this.hitbox.y;
		}
		*/
		public override function getFilePath():String {
			return filePath;
		}
		
		public function setUp():void{
			defineGraphics("wall", false);
			xVelocity = -1;
			
			//this.visible = false;
			setNewTween();
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
		
		private function setNewTween():void {
		//	var tween:Tween = new Tween(this, 'x', Regular.easeInOut, 0, 400, 1.5, true);
		}
		
		public function moveToNextNode():void {
			//trace(getNodes());
			//trace(getNodes.length);
			//trace("move to next node");
			this.x += xVelocity;
			this.y += yVelocity;
			trace(this.x);
			//trace(getHitbox());
			//trace(getHitbox().x);
			//trace(getHitbox().y);
			//trace("width:",this.width)
			for (var i:int = 0; i < getNodes().length; i++) {
			//	trace("node: ", i, " :", getNodes()[i].x);
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