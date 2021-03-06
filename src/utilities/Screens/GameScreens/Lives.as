﻿package utilities.Screens.GameScreens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.Game;
	import flash.display.DisplayObject;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.customEvents.*;
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
			assignedGraphic[0].swf_child.healthBar.gotoAndStop(3);
		//	Game.setGameState("cutSceneFullyLoaded");
			//updateScreenDisplay();
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
			setHealthDisplay();
			
		}
		
		public function setLivesDisplay():void {
			var livesDisplay:String = "";
			trace("lives assignedGraphic[0]",assignedGraphic[0]);
			livesDisplay = "x" + String(Game.getLives());
			assignedGraphic[0].swf_child.txt_lives.text = livesDisplay;
			trace("livesDisplay",livesDisplay);
		}
		
		public function setCoinsDisplay():void {
			var coinsDisplay:String = "";
			trace("coins assignedGraphic[0]",assignedGraphic[0]);
			coinsDisplay = "x" + String(Game.getCoins());
			assignedGraphic[0].swf_child.txt_coins.text = coinsDisplay;
		}
		
		public function setHealthDisplay():void {
			var healthAmount:int = AvatarManager.getAvatar().getHealth();
			trace("healthAmount");
			assignedGraphic[0].swf_child.healthBar.gotoAndStop(healthAmount);
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