package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	public class AFSEnemy extends Enemy{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		
		public function AFSEnemy() {
			xVelocity = -1;
			setUp();
			health=1;
			defineGraphics("afs",false);
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