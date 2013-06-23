package utilities.Actors.GameBoardPieces{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;

	public class Level extends SelectableActor{
		public function Level(levelName:String) {
			addLevelToGameEngine();
			defineLevelGraphics(levelName,true);
			//print("level");
			//lvl_02
		}
		
		public function setUp():void{
			
			//defineGraphics2();
		}
		
		public function updateLoop():void{
			
		}
		
		public override function deselectActor():void {
				print("deselect");
				
				//removeStroke();
		}
			
		public override function selectActor():void {
			print("select");
			
			//addStroke();
		}
	}
}