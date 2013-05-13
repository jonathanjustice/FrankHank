package utilities.Engine.Builders{
	import utilities.Actors.Actor;
	import utilities.Engine.Game;
	import flash.display.MovieClip;
	public class LevelBuilder {
		
		private static var _instance:LevelBuilder;
		
		public function LevelBuilder(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public static function getInstance():LevelBuilder {
			if(LevelBuilder._instance == null){
				LevelBuilder._instance = new LevelBuilder(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
		}
		
		public function setUp():void{
			//BuildLevel();
		}
		
		
	}
}
class SingletonEnforcer{}