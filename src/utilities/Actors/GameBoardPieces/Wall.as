package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	public class Wall extends SelectableActor{
		private var isBulletBlocker:Boolean = false;
		private var filePath:String = "../src/assets/actors/swf_wall.swf";
		private var tempWidth:Number = 0;
		private var tempHeight:Number = 0;
		private var wallType:String = "standard";
		public function Wall(newX:int, newY:int,newWidth:Number,newHeight:Number){
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
			defineGraphics("wall",false);
			
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
			
			this.scaleX = tempWidth;
			this.scaleY = tempHeight;
			this.visible = false;
			addActorToGameEngine(graphic, LevelManager.walls);
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