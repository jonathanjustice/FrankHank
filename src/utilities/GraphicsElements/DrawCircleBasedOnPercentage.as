package utilities.GraphicsElements{
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	
	public class DrawCircleBasedOnPercentage extends MovieClip{
		private var circleGraphic:Sprite = new Sprite(); 
		
		public function DrawCircleBasedOnPercentage():void{
			
		}
		
		//draws a default graphic, just so the game doesn't crash if I haven't made graphics for an object yet
		public function drawCircleSection():void{
			//draw circle line for the preloader
			var cos:Function=Math.cos;
			var sin:Function=Math.sin;
			var pi:Number=Math.PI;
			var d_r:Number=pi/180;
			var r_d:Number=180/pi;
			var midPoint:Object={_x:0,_y:0};
			var r:Number=11;
			 
			var percent:Number;
			var mcPreloader:MovieClip;
			mcPreloader.graphics.clear();
			mcPreloader.graphics.lineStyle(3);
			mcPreloader.graphics.moveTo(11,0);
			 
			for (var i = 0; i<=percent*3.6; i++) {
			mcPreloader.graphics.lineTo((cos(z*d_r)*r), (sin(z*d_r)*r));
			}
		}
		
	}
}
