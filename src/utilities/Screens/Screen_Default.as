package utilities.Screens{
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.MovieClip;
	import utilities.Screens.Screen_Dynamic_Blocker;
	import utilities.Engine.*;
	import utilities.Engine.UIManager; import utilities.GraphicsElements.SwfParser;
	import utilities.objects.GameObject;
	import utilities.customEvents.*;
	public class Screen_Default extends GameObject{
		private var blocker:Screen_Dynamic_Blocker;
		private var myScreen:MovieClip;//or replace with swf eventually
		private var actorGraphic:MovieClip;
		public var assignedGraphic:Array = new Array();
		private var animationState:String = "idle"
		private var isSwfLoaded:Boolean = false;
		private var filePath: String = "";
		private var hasBlocker:Boolean = false;
		public function Screen_Default():void{			
			setUp();
		}
		
		public function getFilePath():String {
			return filePath;
		}
		
		public function stopAllButtonsFromAnimating():void {
			for (var i:int = 0; i < assignedGraphic[0].swf_child.numChildren; i++) {
				if (assignedGraphic[0].swf_child.getChildAt(i) is MovieClip) {	
					assignedGraphic[0].swf_child.getChildAt(i).gotoAndStop(1);;
				}
			}
		}
		
		public function setUp():void {
			addDynamicBlocker();
			addClickHandler();
			addOverHandler();
			addDownHandler();
			addUpHandler();
			addOutHandler();
			mouseEnabledHandler();
			addScreenToUIContainer();
		}
		
		public function defineScreenGraphics(filePath:String):void {
			//trace("filePath:",filePath);
			SwfParser.getInstance().loadScreenSwf(filePath,this);
		}
		
		public function setScreenVisibility(newState:Boolean):void {
			this.visible = newState;
		}
		
		public function setIsSwfLoaded(loadState:Boolean):void {
			isSwfLoaded = loadState;
		}
		
		public function getIsSwfLoaded():Boolean {
			return isSwfLoaded;
		}
		
		public function getActorGraphic():MovieClip {
			return actorGraphic;
		}
		
		//CLICKING
		public function addClickHandler():void{
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function removeClickHandler():void{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function clickHandler(event:MouseEvent):void{
			//defined in other classes
		}
		
		//MOUSING DOWN
		public function addDownHandler():void{
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		}
		
		public function removeDownHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		}
		
		public function downHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("clicked");
			}
		}
		
		//MOUSING UP
		public function addUpHandler():void{
			this.addEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		public function removeUpHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
		}
		
		public function upHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("up");
			}
		}
		
		//MOUSEING OVER
		public function addOverHandler():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
		}
		
		public function removeOverHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER, overHandler);
		}
		
		public function overHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("over");
			}
		}
		
		public function mouseEnabledHandler():void{
			
		}
		
		//MOUSING OUT
		public function addOutHandler():void{
			this.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
		}
		
		public function removeOutHandler():void{
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
		}
		
		public function outHandler(event:MouseEvent):void {
			//trace(event.target.name);
			if (event.target.name.indexOf("hitbox") != -1) {
				event.target.parent.gotoAndStop("up");
			}
		}
		
		private function addDynamicBlocker():void{
			blocker = new utilities.Screens.Screen_Dynamic_Blocker;
			this.addChild(blocker)
			hasBlocker = true;
		}
		
		private function removeDynamicBlocker():void{
			
			if (hasBlocker) {
				this.removeChild(blocker);
			}
		}
		
		private function updateDynamicBlocker():void{
			blocker.update_dynamic_blocker_because_the_screen_was_resized();
		}
		
		/*public function addScreenToGame(){
			//utilities.Engine.Game.gameContainer.addChild(this);
			utilities.Engine.UIManager.uiContainer.addChild(this);
			
		}
		*/
		public function addScreenToUIContainer():void{
			utilities.Engine.UIManager.uiContainer.addChild(this);
		}
		
		
		
		//removing the screen
		public function removeThisScreen():void{
			removeOutHandler();
			removeOverHandler();
			removeClickHandler();
			removeDynamicBlocker();
			utilities.Engine.UIManager.uiContainer.removeChild(this);
		}
	}
}