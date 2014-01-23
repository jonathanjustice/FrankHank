package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	public class Lives extends utilities.Screens.Screen_Default{
		private var myScreen:MovieClip;
		private var filePath:String = "../src/assets/ui/swf_lives.swf";
		public function Lives(){
			defineScreenGraphics("ui_lives");
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			setUp();
			this.addChild(graphic);
			assignedGraphic[0] = graphic;
			//Game.setGameState("cutSceneFullyLoaded");
			updateScreenDisplay();
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public override function setUp():void {
			//addDynamicBlocker();
			//addClickHandler();
			//addOverHandler();
			//addOutHandler();
			//mouseEnabledHandler();
			addScreenToUIContainer();
		}
		
		public function updateScreenDisplay():void {
			setLivesDisplay();
			setCoinsDisplay();
		}
		
		public function setLivesDisplay():void {
			var livesDisplay:String = "";
			livesDisplay = "x" + String(Game.getLives());
			
			trace("Game.getLives()",Game.getLives());
			trace("livesDisplay",livesDisplay);
			trace("assignedGraphic[0]",assignedGraphic[0]);
			trace("assignedGraphic[0].swf_child",assignedGraphic[0].swf_child);
			trace("assignedGraphic[0].swf_child.txt_lives",assignedGraphic[0].swf_child.txt_lives);
			trace("assignedGraphic[0].swf_child.txt_lives.text",assignedGraphic[0].swf_child.txt_lives.text);
			assignedGraphic[0].swf_child.txt_lives.text = livesDisplay;
			trace("assignedGraphic[0].swf_child.txt_lives.text",assignedGraphic[0].swf_child.txt_lives.text);
		}
		
		public function setCoinsDisplay():void {
			var coinsDisplay:String = "";
			coinsDisplay = "x" + String(Game.getCoins());
			assignedGraphic[0].swf_child.txt_coins.text = coinsDisplay;
		}
		
		public override function clickHandler(event:MouseEvent):void{
			switch (event.target.name){
				case "btn_close":
					//removeThisScreen();
					//utilities.Engine.Game.setGameState("startLevelLoad");
					break;
				case "btn_next":
					//removeThisScreen();
					//utilities.Engine.Game.setGameState("startLevelLoad");
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