package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	public class ScreenStart extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		
		public function ScreenStart(){
			//utilities.Engine.Game.startGame("start");
			//removeThisScreen();
			defineScreenGraphics("ui_start")
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
			setUp();
			this.addChild(graphic);
			assignedGraphic[0] = graphic;
			assignedGraphic[0].swf_child.clickToStart.visible = true;
			assignedGraphic[0].swf_child.startButtons.visible = false;
			assignedGraphic[0].swf_child.startButtons.btn_continue.stop();
			assignedGraphic[0].swf_child.startButtons.btn_newGame.stop();
			//Game.setGameState("cutSceneFullyLoaded");
		}
		
		public override function clickHandler(event:MouseEvent):void{
			//trace("target:", event.target.name);
			switch (event.target.name){
				case assignedGraphic[0].swf_child:
					//trace("clicked parent");
					break;
				case "hitbox_clickToStart":
					//trace("clicked hitbox_clickToStart");
					assignedGraphic[0].swf_child.clickToStart.visible = false;
					assignedGraphic[0].swf_child.startButtons.visible = true;
					break;
				case "hitbox_newGame":
					trace("clicked btn_newGame");
					removeThisScreen();
					utilities.Engine.Game.setGameState("startIntroCutSceneLoad");
					break;
				case "hitbox_continue":
					//trace("clicked btn_continue");
					removeThisScreen();
					utilities.Engine.Game.setGameState("continueCodeScreen");
					//do continue-y stuff
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