package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	public class ContinueCode extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		private var filePath:String = "../src/assets/ui/swf_continueCode.swf";
		public function ContinueCode(){
			defineScreenGraphics("ui_continueCode");
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			this.addChild(graphic);
			assignedGraphic[0] = graphic;
			//Game.setGameState("cutSceneFullyLoaded");
			setContinueCodeDisplay();
			stopAllButtonsFromAnimating();
		}
		
		private function setContinueCodeDisplay():void {
			var continueCodeDisplay:String = "";
			continueCodeDisplay = "x" + String(Game.getContinueCode());
			//assignedGraphic[0].swf_child.txt_lives.text = continueCodeDisplay;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public override function clickHandler(event:MouseEvent):void {
			//trace(event.target.name);
			switch (event.target.name) {
				case "hitbox_back":
					removeThisScreen();
					utilities.Engine.Game.setGameState("startScreen");
					break;
				case "hitbox_continue":
					removeThisScreen();
					//utilities.Engine.Game.setGameState("startLevelLoad");
					utilities.Engine.Game.startGame("start");
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