package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	public class CutScene extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		//filepath gets generated outside and passed in
		//private var filePath:String = "../src/assets/ui/swf_cutScene_1.swf";
		private var filePath:String = "";
		public function CutScene(sceneName:String) {
			//trace("CutScene: sceneName:",sceneName);
			defineScreenGraphics(sceneName);
		}
		
		public override function setUp():void {
			//addDynamicBlocker();
			addClickHandler();
			addOverHandler();
			addDownHandler();
			addUpHandler();
			addOutHandler();
			mouseEnabledHandler();
			addScreenToUIContainer();
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			trace("CUTSCEEEEEEEEEENEEEEEEEEE graphic:",graphic);
			//trace("CUTSCEEEEEEEEEENEEEEEEEEE graphic:.swf_child",graphic.swf_child);
			trace("CUTSCENE: assignGraphic begin");
			this.addChild(graphic);
			assignedGraphic[0] = graphic;
			trace("assignedGraphic[0]",assignedGraphic[0]);
			trace("assignedGraphic[0].swf_child",assignedGraphic[0].swf_child);
			trace("CUTSCENE: assignGraphic complete");
			setUp();
			Game.setGameState("cutSceneFullyLoaded");
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public override function clickHandler(event:MouseEvent):void{
			skip();
		}
		
		private function skip():void {
			this.assignedGraphic[0].swf_child.gotoAndStop("end")
		}
		
		public function checkForCutSceneComplete():Boolean {
			if (this.assignedGraphic[0].swf_child.currentFrameLabel  == "end") {
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