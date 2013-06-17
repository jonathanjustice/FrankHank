package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	public class Wall extends SelectableActor{
		private var isBulletBlocker:Boolean = false;
		private var filePath:String = "../src/assets/actors/swf_wall.swf";
		public function Wall(newX:int, newY:int,newWidth:Number,newHeight:Number){
			setUp();
			//this.scaleX = newWidth;
			//this.scaleY = newHeight;
			//this.x = newX;
			//this.y = newY;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			
			assignedGraphic[0] = graphic;
			LevelManager.levels.push(this);
			setIsSwfLoaded(true);
		}
		
		public function setUp():void{
			//trace("fuck yeah it worked");
			defineGraphics("wall",false);
			addActorToGameEngine();
			setPreviousPosition();
			//this.visible = false;
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