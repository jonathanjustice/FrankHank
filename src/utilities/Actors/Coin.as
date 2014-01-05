package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import flash.display.DisplayObject;
	import utilities.Engine.LevelManager;
	public class Coin extends Loot{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		//private var lifeSpan:Number = 2;//3 seconds
		
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_coin.swf";
		public function Coin(newX:int, newY:int) {
			defineGraphics("coin",false);
			this.x = newX,
			this.y = newY;
			health = 1;
			setMoneyValue(1);
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			addActorToGameEngine(graphic,LevelManager.coins);
		}
		
		public function setUp():void{
			
		}
		
		public override function updateLoop():void{
			//setQuadTreeNode();
			//applyVector();
			//doStuffToEnemyOverTime();
			//checkForDamage();
			//checkForDeathFlag();
			//setPreviousPosition();
		}
	
		
		public function collidedWithAvatar():void {
			
		}
		
		//direction indicator is useful for determine what direction the enemy is faceing / moving in / shooting in
		//make it invisible if its not being used
		//it's commented out because it't not part of the default graphic anymore
		/*private function set_direction_indicator_visibility(){
			directionIndiactor.visible = false;
		}
		*/
		
		//this records the moment the bullet was created
		public function setSpawnTime():void {
         	spawnTime = getTimer();
			//trace("spawnTime",spawnTime);
        }
		
		public function markKillWithXpFlag():void{
			markDeathFlag();
			applyXP = true;
		}
		
		public function markDeathWithoutXpFlag():void{
			markDeathFlag();
			applyXP = false;
		}
		
		public function get_apply_XP_flag():Boolean{
			return applyXP;
		}
		
		public function get_xpToApply():int{
			return xpToApply;
		}
		
		
	}
}