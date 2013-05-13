package utilities.Engine{
	import flash.display.MovieClip;
	import utilities.Actors.Actor;
	import flash.geom.Point;
	import utilities.Actors.SelectableActor;
	public class ResourceManager {
		private var newSelectedItems:Array = new Array();
		private var coins:int = 0;
		private var xp:int = 0;
		private var lives:int = 0;
		private static var _instance:ResourceManager;

		public function ResourceManager(singletonEnforcer:SingletonEnforcer){
			
		}
		
		public static function getInstance():ResourceManager {
			if(ResourceManager._instance == null){
				ResourceManager._instance = new ResourceManager(new SingletonEnforcer());
			}
			return _instance;
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
class SingletonEnforcer{}