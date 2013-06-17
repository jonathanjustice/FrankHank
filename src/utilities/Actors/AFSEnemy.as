package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import flash.display.DisplayObject;
	import utilities.Engine.Combat.EnemyManager;
	public class AFSEnemy extends Enemy{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		private var filePath:String = "../src/assets/actors/swf_afs.swf";
		public function AFSEnemy(newX:int, newY:int) {
			xVelocity = -1;
			setUp();
			health=1;
			defineGraphics("afs", false);
			this.x = newX,
			this.y = newY;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			//alignmentOfParentChildGraphics(gem,tempArray[j]);
			EnemyManager.enemies.push(this);
		}
		
		public override function updateLoop():void {
			setQuadTreeNode();
			applyVector();
			//doStuffToEnemyOverTime();
			checkForDamage();
			checkForDeathFlag();
			walk();
		}
		
		public function walk():void {
			this.x += xVelocity;
			//this.y -= 1;
		}
	}
}