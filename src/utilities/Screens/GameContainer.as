package utilities.Screens{
	import flash.display.MovieClip;
	  import flash.display.Sprite;
	  import flash.events.Event;
	  import flash.events.MouseEvent;
	public class GameContainer extends MovieClip{
		public function GameContainer():void {
			drawBackground();
			this.addEventListener(MouseEvent.CLICK, clickedGameContainer);
		}
		
		public function zoomToObjectInsideContainer():void{
			//need to pass in object
			
			//determine point to zoom to
			
			//compare local coordinate to global
			
			//record the offset if needed, tween camera at constant rate
			
			//move game container coordinates until object's global position matches intended zoom posision(probably center of stage)
		}
		
		private function clickedGameContainer(event:MouseEvent):void {
		//	trace("clicked game container");
		}
		
		private function removeClickHandler(event:MouseEvent):void {
			this.removeEventListener(MouseEvent.CLICK, clickedGameContainer);
		}
		
		public function drawBackground():void {
			var myGraphic:Sprite = new Sprite();
			myGraphic.graphics.lineStyle(3,0xff0000);
			myGraphic.graphics.beginFill(0x000000);
			myGraphic.graphics.drawRect(0,0,1280,1024);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
	}
}
