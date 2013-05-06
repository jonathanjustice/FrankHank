package utilities.Engine{
	import flash.display.MovieClip;
	import utilities.Actors.Actor;
	import flash.geom.Point;
	import utilities.Actors.SelectableActor;
	public class ResourceManager extends DefaultManager{
		private var newSelectedItems:Array = new Array();
		private var coins:int = 0;
		private var xp:int = 0;
		private var lives:int = 0;

		public function ResourceManager(){
			
		}
		
		public function modifyResource(resource:String, amount:int):void {
			switch (resource){
				case "coins":
					coins += amount;
					break;
				case "lives":
					lives += amount;
					break;
				case "xp":
					xp += amount;
					break;
			}
		}
		
		public function getResource(resource:String):int {
			var resourceToReturn:int=0;
			switch (resource){
				case "coins":
					resourceToReturn = coins;
					break;
				case "lives":
					resourceToReturn = lives;
					break;
				case "xp":
					resourceToReturn = xp;
					break;
			}
			return resourceToReturn;
		}
	}
}