package utilities.Screens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.*;
	import utilities.Engine.UIManager;
	public class Screen_Default extends MovieClip{
		private var blocker:Screen_Dynamic_Blocker;
		private var myScreen:MovieClip;//or replace with swf eventually
		
		public function Screen_Default():void{
			//trace("super");
			setUp();
		}
		
		public function setUp():void{
			//myScreen = screen_swf;
			setScreen();
			addDynamicBlocker();
			addScreenGraphics();
			addScreenToUIContainer();
			addClickHandler();
			addOverHandler();
			addOutHandler();
			mouseEnabledHandler();
		}
		
		public function setScreen():void{
			//myScreen = screen_swf;
			//trace(myScreen,"myScreen");
		}
		
		public function addScreenGraphics():void{
			//trace("this",this);
			//trace("myScreen",myScreen);
			//myScreen = new MovieClip();
			this.addChild(myScreen);
		}
		
		//CLICKING
		public function addClickHandler():void{
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function removeClickHandler():void{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function clickHandler(event:MouseEvent):void{
			
		}
		
		//MOUSEING OVER
		public function addOverHandler():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
		}
		
		public function removeOverHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER, overHandler);
		}
		
		public function overHandler(event:MouseEvent):void{
			
		}
		
		public function mouseEnabledHandler():void{
			
		}
		
		//MOUSING OUT
		public function addOutHandler():void{
			this.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
		}
		
		public function removeOutHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
		}
		
		public function outHandler(event:MouseEvent):void{
			
		}
		
		private function addDynamicBlocker():void{
			blocker = new utilities.Screens.Screen_Dynamic_Blocker;
			this.addChild(blocker)
		}
		
		private function removeDynamicBlocker():void{
			this.removeChild(blocker);
		}
		
		private function updateDynamicBlocker():void{
			blocker.update_dynamic_blocker_because_the_screen_was_resized();
		}
		
		/*public function addScreenToGame(){
			//utilities.Engine.Game.gameContainer.addChild(this);
			utilities.Engine.UIManager.uiContainer.addChild(this);
			
		}
		*/
		public function addScreenToUIContainer():void{
			utilities.Engine.UIManager.uiContainer.addChild(this);
		}
		
		//removing the screen
		public function removeThisScreen():void{
			removeOutHandler();
			removeOverHandler();
			removeClickHandler();
			removeDynamicBlocker();
			utilities.Engine.UIManager.uiContainer.removeChild(this);
		}
	}
}