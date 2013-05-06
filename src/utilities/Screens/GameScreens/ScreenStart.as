package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	public class ScreenStart extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		
		public function ScreenStart(){
			utilities.Engine.Game.startGame("start");
		}
		
		public override function clickHandler(event:MouseEvent):void{
			//trace("parent:",event.target.parent.name);
			//trace("target:",event.target.name);
			//switch (event.target){
			/*	case blocker:
				trace("clicked start screen");
					removeThisScreen();
					utilities.Engine.Game.startGame("start");
					break;
				
				case myScreen.btn_start:
				trace("clicked start screen");
					removeThisScreen();
					utilities.Engine.Game.startGame("start");
					break;
					*/
			//}
		}
		
		
		//is there a way to make this more abstract?
		//check for everything that is a button when the screen is created?
		public override function mouseEnabledHandler():void{
			//myScreen.btn_start.buttonMode = true;
		}
		
		//is there a way to make this more abstract?
		//could pass in the screen in setUp or when its loaded
		public override function setScreen():void{
			//replace this with the swf once there is a swf loading class
			//myScreen = screen_swf;
			myScreen = new MovieClip();
			//myScreen = new Screen_Start();
			//trace("ScreenStart: myScreen is:",myScreen);
		}
		
		public override function addScreenGraphics():void{
			//trace("ScreenStart: addScreenGraphics",myScreen);
			this.addChild(myScreen);
		}
	}
}