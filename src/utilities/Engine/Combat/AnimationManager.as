package utilities.Engine.Combat{
	
	import utilities.Actors.Actor;
	import utilities.Engine.DefaultManager;
	import flash.display.MovieClip;

	public class AnimationManager {
		private static var _instance:AnimationManager;
		
		public function AnimationManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public static function getInstance():AnimationManager {
			if(AnimationManager._instance == null){
				AnimationManager._instance = new AnimationManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
		}
		
		public function setUp():void{
		
		}
		
		public function updateAnimationState(actor:Actor, animState:String):void {
			actor.playAnimation(animState);
			
			//trace("AnimationManager: animState",animState);
		}
		
		//update animations based on current state
		public function updateLoop():void{
			//idleLogic();
		}
	}
}

class SingletonEnforcer{}