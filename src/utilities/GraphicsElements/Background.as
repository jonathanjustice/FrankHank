package utilities.GraphicsElements{
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	
	public class Background extends MovieClip{
		private var myGraphic:Sprite = new Sprite(); 
		
		public function Background():void{
			
		}
		
		public function createTiledBackground(backGroundSprite:Sprite) {
			backGroundSprite.graphics.beginBitmapFill( new BgPattern( 0, 0 ) );
			backGroundSprite.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			backGroundSprite.graphics.endFill();
			addChildAt(backGroundSprite, 0);
		}
	}
}
