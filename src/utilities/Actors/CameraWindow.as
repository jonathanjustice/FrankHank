package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	public class CameraWindow extends Actor{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		private var isGravitySystemEnabled:Boolean = true;
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		public function CameraWindow() {
			defineGraphicsDefaultRectangle();
			this.x = 150;
			this.y = 50;
			this.width = 600;
			this.height = 350;
			this.visible = true;
			this.alpha = .25;
		}
		
	}
}