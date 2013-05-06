package utilities.Actors.GameBoardPieces{
	import utilities.Actors.Actor;

	public class Terrain extends utilities.Actors.Actor{
		private var isBulletBlocker:Boolean=false;;
		public function Terrain(){
			setUp();
		}
		
		public function setUp():void{
			//defineGraphics2();
			//addActorToGameEngine();
			setPreviousPosition();
		}
		
		public function updateLoop():void{
			
		}
	}
}