package utilities.Engine{
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Actors.SelectableActor;
	import utilities.Effects.Effect;
	import utilities.Effects.FeedbackTextField;
	import utilities.Engine.DefaultManager;
	import utilities.Actors.GameBoardPieces.Level;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Input.KeyInputManager;
	import flash.events.Event;
	
	import utilities.dataModels.LevelProgressModel;
	import flash.geom.Point;
	public class EffectsManager extends BasicManager implements IManager{
		private static var _instance:EffectsManager;
		public static var effects:Array;
		
		//Singleton Design Pattern features
		public function EffectsManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public function setUp():void{
			
			effects = [];
		}
		
		public function getEffects():Array{
			return effects;
		}
		
		public function newEffect_FeedbackTextField(spawnX:int, spawnY:int):void {
			//trace("new effect");
			var feedbackTextField:FeedbackTextField = new FeedbackTextField(spawnX,spawnY);
		}
		
		
		public function updateLoop():void {
			for each(var effect:Effect in effects){
				effect.updateLoop();
			}
		}
		
		private function ClearEffects():void {
			
		}
		
		public static function getInstance():EffectsManager {
			if(EffectsManager._instance == null){
				EffectsManager._instance = new EffectsManager(new SingletonEnforcer());
			}
			return _instance;
		}
	}
}

class SingletonEnforcer{}
