package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;

	public class Art extends SelectableActor {
		private var filePath:String = "";
		public function Art(){
			setUp();
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