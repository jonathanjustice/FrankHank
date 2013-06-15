package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	public class Gem extends Coin{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var moneyValue:int = 50;
		//private var lifeSpan:Number = 2;//3 seconds
		
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_gem.swf";
		public function Gem() {
			health=1;
		}
		
		public override function setUp():void{
			addActorToGameEngine();
			setPreviousPosition();
			defineGraphics("gem",false);
		}

		
		//direction indicator is useful for determine what direction the enemy is faceing / moving in / shooting in
		//make it invisible if its not being used
		//it's commented out because it't not part of the default graphic anymore
		/*private function set_direction_indicator_visibility(){
			directionIndiactor.visible = false;
		}
		*/
		
		
	}
}