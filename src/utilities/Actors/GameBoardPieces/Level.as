package utilities.Actors.GameBoardPieces{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;

	public class Level extends SelectableActor{
		public function Level() {
			addActorToGameEngine();
			defineGraphics("lvl_02",true);
			//trace("level");
		}
		
		public function setUp():void{
			
			//defineGraphics2();
		}
		
		public function updateLoop():void{
			
		}
		
		public override function deselectActor():void {
				trace("deselect");
				
				//removeStroke();
		}
			
		public override function selectActor():void {
			trace("select");
			
			//addStroke();
		}
	}
}