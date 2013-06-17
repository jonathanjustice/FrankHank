package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	public class Art extends SelectableActor {
		private var filePath:String = "";
		public function Art(newX:int, newY:int){
			setUp();
			this.x = newX - this.x;
			this.y = newY - this.y;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			this.addChild(graphic);
			assignedGraphic[0] = graphic;;
			LevelManager.arts.push(this);
			setIsSwfLoaded(true);
			
		}
		
		public function setUp():void{
			//trace("fuck yeah it worked");
			addActorToGameEngine();
			setPreviousPosition();
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