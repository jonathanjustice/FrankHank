package utilities.Engine.Combat{
	
	import utilities.Actors.Actor;
	import utilities.Engine.DefaultManager;
	import flash.display.MovieClip;

	public class AnimationManager extends utilities.Engine.DefaultManager{
	
		
		public function AnimationManager(){
			setUp();
		}
		
		public function setUp():void{
		
		}
		
		public function updateAnimationState(actor:Actor, animState:String):void {
			actor.playAnimation(animState);
		//	trace("AnimationManager: animState",animState);
		}
		
		//update animations based on current state
		public override function updateLoop():void{
			//idleLogic();
		}
	}
}