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
		
		
		private var filePath:String = "";
		public function CameraWindow() {
			defineGraphicsDefaultRectangle();
			this.x = 250;
			this.y = 140;
			this.scaleX = 1;
			this.scaleY = 2.2;
			this.visible = false;
			//this.alpha = .25;
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function scaleToMotion(motion:String):void {
			switch(motion) {
				case "up":
					//this.height = 300;
					break;
				case "down":
					//this.width = 300;
					break;
				case "left":
					this.width = 400;
					this.x = 475;
					break;
				case "right":
					this.width = 400;
					this.x = -50;
					break;
			}
			
		}
		
	}
}