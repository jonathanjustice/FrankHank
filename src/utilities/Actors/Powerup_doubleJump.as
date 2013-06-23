package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import flash.utils.getTimer;
	public class Powerup_doubleJump extends Powerup_default{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_powerupDoubleJump.swf";
		public function Powerup_doubleJump(newX:int, newY:int){
			health = 1;
			this.x = newX;
			this.y = newY;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public override function setUp():void {
			powerupType = "doubleJump";
			health=1;
			defineGraphics("powerup_doubleJump",false);
		}
		
		public override function updateLoop():void {
		
		}
	}
}