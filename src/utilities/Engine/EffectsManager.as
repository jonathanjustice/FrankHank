package utilities.Engine{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import utilities.Actors.SelectableActor;
	import utilities.Effects.Effect;
	import utilities.Effects.FeedbackTextField;
	import utilities.Effects.FeedbackMovieClip;
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
		private var effectsContainer:MovieClip = new MovieClip();
		private var fp_franked:String = new String("../src/assets/effects/swf_effect_franked.swf");
		private var fp_hanked:String = new String("../src/assets/effects/swf_effect_hanked.swf");
		private var fp_extraLife:String = new String("../src/assets/effects/swf_effect_extraLife.swf");
		public var assignedGraphic:Array = new Array();
		
		//Singleton Design Pattern features
		public function EffectsManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public function setUp():void {
			preLoadEffects();
			effects = [];
		}
		
		//ugh whatever last flash project. no need to do this right
		public function assignGraphic(graphic:DisplayObject):void {
			//extract the mo
			//trace("effects manager : assignGraphic");
			assignedGraphic[0] = graphic;
			//trace("assignedGraphic[0].name", assignedGraphic[0].name);
			//trace("assignedGraphic[0].swf_child.name", assignedGraphic[0].swf_child.name);
			//trace("assignedGraphic[0].swf_child.name.getChildAt(0).name", assignedGraphic[0].swf_child.getChildAt(0).name);
			
			assignedGraphic[0].swf_child.getChildAt(0).gotoAndPlay(1);
			switch(assignedGraphic[0].swf_child.getChildAt(0).name) {
				case "franked":
					assignedGraphic[1] = graphic;
					break;
				case "hanked":
					assignedGraphic[2] = graphic;
					break;
				case "extraLife":
					assignedGraphic[3] = graphic;
					break;
			}
			//effectsContainer = graphic;
			//addActorToGameEngine(graphic, EffectsManager.effects);
		
		//	hitbox = this.assignedGraphic[0].swf_child.hitbox;
		//	hitzone = this.assignedGraphic[0].swf_child.hitzone;
			//playAnimation("walk");
		}
		
		private function preLoadEffects():void {
			//trace("EffectsManager: loadEffectsContainer");
			//trace("Main.getBulkLoader().beginLoad(swfParent, filePath);");
			//trace("Main.getBulkLoader()",Main.getBulkLoader());
			//trace("swfParent",effectsContainer);
			//trace("filePath",filePath);
			Main.getBulkLoader().beginLoad(this, fp_franked);
			Main.getBulkLoader().beginLoad(this, fp_hanked);
			Main.getBulkLoader().beginLoad(this, fp_extraLife);
		}
		
		public function getEffects():Array{
			return effects;
		}
		
		public function newEffect_Franked(spawnX:int, spawnY:int):void {
			
			//trace("new effect");
			
			//trace("new effect:  assignedGraphic[0]", assignedGraphic[1]);
			//trace("new effect:  assignedGraphic[0].swf_child", assignedGraphic[1].swf_child);
			//trace("new effect:  assignedGraphic[0].swf_child.franked", assignedGraphic[1].swf_child.franked);
			//trace("new effect:  assignedGraphic[0].anim_franked", assignedGraphic[0].anim_franked);
			var newEffect:MovieClip = new MovieClip();
			newEffect = assignedGraphic[1];
			//var myDuplicate:MovieClip = duplicateDisplayObject( assignedGraphic[0].anim_franked ) as MovieClip;
			var feedbackMovieClip:FeedbackMovieClip = new FeedbackMovieClip(spawnX,spawnY,newEffect);
		}
		
		public function newEffect_Hanked(spawnX:int, spawnY:int):void {
			var newEffect:MovieClip = new MovieClip();
			newEffect = assignedGraphic[2];
			var feedbackMovieClip:FeedbackMovieClip = new FeedbackMovieClip(spawnX,spawnY,newEffect);
		}
		
		public function newEffect_ExtraLife(spawnX:int, spawnY:int):void {
			var newEffect:MovieClip = new MovieClip();
			newEffect = assignedGraphic[3];
			var feedbackMovieClip:FeedbackMovieClip = new FeedbackMovieClip(spawnX,spawnY,newEffect);
		}
		
		public function newEffect_FeedbackTextField(spawnX:int, spawnY:int,effectText:String):void {
			//trace("new effect");
			var feedbackTextField:FeedbackTextField = new FeedbackTextField(spawnX,spawnY,effectText);
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
