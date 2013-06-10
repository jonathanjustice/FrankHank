package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	public class CutScene extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		
		public function CutScene(sceneName:String) {
			trace("CutScene: sceneName:",sceneName);
			defineGraphics(sceneName);
		}
		
		public override function clickHandler(event:MouseEvent):void{
			skip();
		}
		
		private function skip():void {
			this.gotoAndStop("end")
		}
		
		public function checkForCutSceneComplete():Boolean {
			if (this.getActorGraphic().assignedGraphics[0].swf_child.currentFrameLabel  == "end") {
				removeThisScreen();
				return true;
			}else {
				return false;
			}
		}
		
		//is there a way to make this more abstract?
		//check for everything that is a button when the screen is created?
		public override function mouseEnabledHandler():void{
			//myScreen.btn_start.buttonMode = true;
		}
	}
}