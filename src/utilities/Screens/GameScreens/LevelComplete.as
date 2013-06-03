package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	public class LevelComplete extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		
		public function LevelComplete(){
			defineGraphics("ui_levelComplete");
		}
		
		public override function clickHandler(event:MouseEvent):void{
			switch (event.target.name){
				case "btn_close":
					removeThisScreen();
					utilities.Engine.Game.setGameState("loadingLevel");
					break;
				case "btn_next":
					removeThisScreen();
					utilities.Engine.Game.setGameState("loadingLevel");
					break;
			}
		}
		
		//is there a way to make this more abstract?
		//check for everything that is a button when the screen is created?
		public override function mouseEnabledHandler():void{
			//myScreen.btn_start.buttonMode = true;
		}
	}
}