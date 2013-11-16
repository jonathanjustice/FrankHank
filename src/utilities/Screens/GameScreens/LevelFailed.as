package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	public class LevelFailed extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		private var filePath:String = "../src/assets/ui/swf_levelFailed.swf";
		private var countdownTimer:int = 0;
		private var timeFadeIn:int = 3;
		private var timeFadeOut:int = 3;
		private var timeNextScreen:int = 30;
		//3,87,90
		public function LevelFailed(){
			defineScreenGraphics("ui_levelFailed");
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			setUp();
			this.alpha = 0;
			this.addChild(graphic);
			assignedGraphic[0] = graphic;
			//Game.setGameState("cutSceneFullyLoaded");
			startTimerToNextLevel();
			setLivesDisplay();
		}
		
			
		public function setLivesDisplay():void {
			var livesDisplay:String = "";
			livesDisplay = "x" + String(Game.getLives());
			assignedGraphic[0].swf_child.txt_lives.text = livesDisplay;
		}
		
		private function startTimerToNextLevel():void {
			countdownTimer = 0;
			this.addEventListener(Event.ENTER_FRAME, countdown);
		}
		
		private function stopTimerToNextLevel():void {
			this.removeEventListener(Event.ENTER_FRAME, countdown);
		}
		
		private function countdown(e:Event):void {
			countdownTimer++;
			//fade in
			if (countdownTimer <= timeFadeIn) {
				trace("INININININ");
				this.alpha = countdownTimer / timeFadeIn;
			}
			//afde out
			if (countdownTimer >= (timeNextScreen - timeFadeOut) && countdownTimer < timeNextScreen) {
				trace("OUTOUTOUT");
				this.alpha =  1- (countdownTimer - (timeNextScreen-timeFadeOut) ) / timeFadeOut;
			}
			if (countdownTimer >= timeNextScreen) {
				stopTimerToNextLevel();
				countdownTimer = 0;
				this.alpha = 0;
				removeThisScreen();
				utilities.Engine.Game.setGameState("startLevelLoad");
			}
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