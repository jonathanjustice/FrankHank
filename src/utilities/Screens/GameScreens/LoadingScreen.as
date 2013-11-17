package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	public class LoadingScreen extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		private var filePath:String = "../src/assets/ui/swf_loadingScreen.swf";
		private var countdownTimer:int = 0;
		private var timeFadeIn:int = 3;
		private var timeFadeOut:int = 3;
		private var timeNextScreen:int = 30;
		//3,87,90
		public function LoadingScreen(){
			defineScreenGraphics("ui_loadingScreen");
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			setUp();
			this.addChild(graphic);
			assignedGraphic[0] = graphic;
			//assignedGraphic[0].swf_child.gotoAndPlay(21);
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		//is there a way to make this more abstract?
		//check for everything that is a button when the screen is created?
		public override function mouseEnabledHandler():void{
			//myScreen.btn_start.buttonMode = true;
		}
	}
}