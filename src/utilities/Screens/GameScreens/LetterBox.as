package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	public class LetterBox extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		private var filePath:String = "../src/assets/ui/swf_letterBox.swf";
		private var countdownTimer:int = 0;
		private var timeFadeIn:int = 3;
		private var timeFadeOut:int = 87;
		private var timeNextScreen:int = 90;
		public function LetterBox(){
			defineScreenGraphics("ui_letterBox");
		}
		
		
		public override function setUp():void {
			//addDynamicBlocker();
			//addClickHandler();
			//addOverHandler();
			//addOutHandler();
			//mouseEnabledHandler();
			addScreenToUIContainer();
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			setUp();
			this.addChild(graphic);
			assignedGraphic[0] = graphic;
			//Game.setGameState("cutSceneFullyLoaded");
			startTimerToNextLevel();
			assignedGraphic[0].swf_child.gotoAndPlay(1);
			//assignedGraphic[0].gotoAndPlay(1);
		}
		
		public function listenForFrame(frameLabel:String):void {
			var label:String = frameLabel;
			if (assignedGraphic[0].swf_child.currentLabel == "end"){
			//if (assignedGraphic[0].swf_child.currentFrame == 140) {
				
			}
		}
		
		private function startTimerToNextLevel():void {
			countdownTimer = 0;
			//this.addEventListener(Event.ENTER_FRAME, listenForFrame);
		}
		
		private function stopTimerToNextLevel():void {
			this.removeEventListener(Event.ENTER_FRAME, listenForFrame);
		}
		
		private function countdown(e:Event):void {
			countdownTimer++;
			if (countdownTimer <= timeFadeIn) {
				this.alpha = countdownTimer / timeFadeIn;
			}
			if (countdownTimer >= timeFadeOut && countdownTimer < timeNextScreen) {
				this.alpha = 1 - (countdownTimer -timeFadeOut) / (timeNextScreen - timeFadeOut);
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