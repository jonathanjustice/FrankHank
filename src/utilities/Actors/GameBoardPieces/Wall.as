package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;

	public class Wall extends SelectableActor{
		private var isBulletBlocker:Boolean = false;
		private var filePath:String = "../src/assets/actors/swf_wall.swf";
		public function Wall(){
			setUp();
		}
		
		public function setUp():void{
			//trace("fuck yeah it worked");
			defineGraphics("wall",false);
			addActorToGameEngine();
			setPreviousPosition();
			this.visible = false;
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