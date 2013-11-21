package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	public class LevelComplete extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		private var filePath:String = "../src/assets/ui/swf_levelComplete.swf";
		public function LevelComplete(){
			defineScreenGraphics("ui_levelComplete");
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			setUp();
			this.addChild(graphic);
			assignedGraphic[0] = graphic;
			//Game.setGameState("cutSceneFullyLoaded");
			startTimerToNextLevel();
			setContinueCodeDisplay();
		}
		
		private function startTimerToNextLevel():void {
			this.addEventListener(Event.ENTER_FRAME, listenForFrame);
		}
		
		private function stopTimerToNextLevel():void {
			this.removeEventListener(Event.ENTER_FRAME, listenForFrame);
		}
		
		public function listenForFrame(frameLabel:String):void {
			var label:String = frameLabel;
			if (assignedGraphic[0].swf_child.currentLabel == "end"){
			//if (assignedGraphic[0].swf_child.currentFrame == 140) {
				stopTimerToNextLevel();
				removeThisScreen();
				utilities.Engine.Game.setGameState("startLevelLoad");
			}
		}
		
		private function setContinueCodeDisplay():void {
			var continueCodeDisplay:String = "";
			continueCodeDisplay = "x" + String(Game.getContinueCode());
			//assignedGraphic[0].swf_child.txt_lives.text = continueCodeDisplay;
		}
		
		
		
		
		
		
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public override function clickHandler(event:MouseEvent):void{
			switch (event.target.name){
				case "btn_close":
					removeThisScreen();
					utilities.Engine.Game.setGameState("startLevelLoad");
					break;
				case "btn_next":
					removeThisScreen();
					utilities.Engine.Game.setGameState("startLevelLoad");
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