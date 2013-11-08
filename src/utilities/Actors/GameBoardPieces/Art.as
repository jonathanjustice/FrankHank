package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	public class Art extends SelectableActor {
		private var filePath:String = "";
		private var parallaxLevel:int = 0;
		public function Art(newX:int, newY:int,newGraphic:DisplayObject,parallaxingLevel:int){
			setUp();
			this.x = newX;
			this.y = newY;
			this.alpha = 1;
			assignGraphic(newGraphic);
			//this.addChild(newGraphic);
			parallaxLevel = parallaxingLevel;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			graphic.x = 0
			graphic.y = 0;
			addActorToGameEngine(graphic,LevelManager.arts);
		}
		
		public function setUp():void{
			setPreviousPosition();
		}
		
		public function updateLoop():void{
			
		}
		
		public function getParallaxLevel():int {
			return parallaxLevel;
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