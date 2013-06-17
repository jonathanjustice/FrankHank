package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import utilities.Engine.LevelManager;
	import flash.display.DisplayObject;
	public class Gem extends Loot{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var moneyValue:int = 50;
		//private var lifeSpan:Number = 2;//3 seconds
		
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_gem.swf";
		public function Gem(newX:int, newY:int){
			
			health = 1;
			this.x = newX - this.x;
			this.y = newY - this.y;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function getMoneyValue():int {
			return moneyValue;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			//alignmentOfParentChildGraphics(gem,tempArray[j]);
			LevelManager.coins.push(this);
			assignedGraphic[0] = graphic;
			setIsSwfLoaded(true);
		}
		
		public function setUp():void{
			addActorToGameEngine();
			setPreviousPosition();
			defineGraphics("gem",false);
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
		/*
		public function takeDamage(amount:int):void{
			health -= amount;
		}
		*/
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