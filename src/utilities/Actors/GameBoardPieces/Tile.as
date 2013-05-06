package utilities.Actors.GameBoardPieces{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Actors.Actor;

	public class Tile extends utilities.Actors.Actor{
		private var map;
		public function Tile(theMap,xLoc,yLoc){
			map = theMap;
			this.x = xLoc;
			this.y = yLoc;
		}
		
		//if the tile goes outside the visible area of the game,
		//make it invisible
		//turn off anything else that does not need to be updated;
		public function updateLoop(){
			var localPoint:Point = new Point(this.x,this.y);
			var globalPoint = map.localToGlobal(localPoint);
			//trace("globalPoint",globalPoint);
			if(globalPoint.x < -50 || globalPoint.x >370 || globalPoint.y < -50 || globalPoint.y > 530){
				this.visible = false;
			}else{
				this.visible = true;
			}
		}
		
		//Consider: creating all the tiles at once, then jamming them into the Map Class, so that I can move them all at once without iterating through all of them
		//still will need to find an efficient way to determine when to show them and when not to
	}
}