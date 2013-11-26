package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	import flash.text.*;
	public class ContinueCode extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		private var filePath:String = "../src/assets/ui/swf_continueCode.swf";
		private var userInputCode:String = "";
		public function ContinueCode(){
			defineScreenGraphics("ui_continueCode");
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			this.addChild(graphic);
			assignedGraphic[0] = graphic;
			setContinueCodeDisplay();
			stopAllButtonsFromAnimating();
			formatInputTextField();
		}
		
		//eh, i'm not building this right tonight
		//lazy time go
		private function formatInputTextField():void {
			assignedGraphic[0].swf_child.txt_input_1.text = "";
			assignedGraphic[0].swf_child.txt_input_1.maxChars = 4; 
			assignedGraphic[0].swf_child.txt_input_1.restrict = "A-Z0-9";
			
			assignedGraphic[0].swf_child.txt_input_2.text = "";
			assignedGraphic[0].swf_child.txt_input_2.maxChars = 4; 
			assignedGraphic[0].swf_child.txt_input_2.restrict = "A-Z0-9";
			
			assignedGraphic[0].swf_child.txt_input_3.text = "";
			assignedGraphic[0].swf_child.txt_input_3.maxChars = 4; 
			assignedGraphic[0].swf_child.txt_input_3.restrict = "A-Z0-9";
			
			assignedGraphic[0].swf_child.txt_input_4.text = "";
			assignedGraphic[0].swf_child.txt_input_4.maxChars = 4; 
			assignedGraphic[0].swf_child.txt_input_4.restrict = "A-Z0-9";
			
			stage.focus = assignedGraphic[0].swf_child.txt_input_1;
			assignedGraphic[0].swf_child.txt_input_1.addEventListener(Event.CHANGE, checkInput);
			assignedGraphic[0].swf_child.txt_input_2.addEventListener(Event.CHANGE, checkInput);
			assignedGraphic[0].swf_child.txt_input_3.addEventListener(Event.CHANGE, checkInput);
			assignedGraphic[0].swf_child.txt_input_4.addEventListener(Event.CHANGE, checkInput);
		}
		
		private function checkInput(e:Event):void {
			if (e.target.text.length == 4) {
				switch(e.target.name) {
					case "txt_input_1":
						stage.focus = assignedGraphic[0].swf_child.txt_input_2;
						break;
					case "txt_input_2":
						stage.focus = assignedGraphic[0].swf_child.txt_input_3;
						break;
					case "txt_input_3":
						stage.focus = assignedGraphic[0].swf_child.txt_input_4;
						break;
					case "txt_input_4":
						//stage.focus = assignedGraphic[0].swf_child.txt_input_4;
						break;
				}
				if (e.target.name == "txt_input_1") {
					trace("bannaners");
				}
				
				//move to next texfield
				//.name.charAt(17)
			}
			updateUserInputCode();
		}
		
		private function updateUserInputCode():void {
			userInputCode = assignedGraphic[0].swf_child.txt_input_1.text + assignedGraphic[0].swf_child.txt_input_2.text + assignedGraphic[0].swf_child.txt_input_3.text + assignedGraphic[0].swf_child.txt_input_4.text;
			trace("userInputCode", userInputCode);
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