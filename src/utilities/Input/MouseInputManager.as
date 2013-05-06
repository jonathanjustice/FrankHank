package utilities.Input{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import utilities.Actors.SelectableActor;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyCodes;
	import utilities.Engine.DefaultManager;
	import utilities.Engine.Game;
	import utilities.Engine.Combat.AvatarManager;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	public class MouseInputManager extends utilities.Engine.DefaultManager{
		
		public static var isDragging:Boolean = false;
		private var mouseOffSet:Point = new Point;
		private var worldOffSet:Point = new Point;
		private var delta:Point = new Point;
		private var oldMouse:Point = new Point;
		private var maximumEase:Number = 30;
		private var lastClickedActors:Array = new Array();
		private var lastClickedCoordinates:Point = new Point;
		public function MouseInputManager():void{
			setUp();
		}
		
		public function setUp():void {
			Main.theStage.addEventListener(MouseEvent.MOUSE_DOWN, startDragWorld);
		}
		
		public function startDragWorld(event:MouseEvent):void {
			isDragging = true;
			mouseOffSet = Main.getMouseCoordinates();
			worldOffSet = Game.getGameContainerCoordinates();
			Main.theStage.addEventListener(Event.ENTER_FRAME, isDraggingWorld);
			Main.theStage.addEventListener(MouseEvent.MOUSE_UP, stopDragWorld);
			utilities.Engine.Game.gameContainer.addEventListener(MouseEvent.CLICK, clickedStage);
		}
		
		
		private function clickedStage(event:MouseEvent):void {
			runSelectionLogic(event);
		}
		
		//determine what to select and unselect	by:
		//get an array of each of the types objects that the mouse is touching,
		//take action based on the number of actors being touched	
		public function runSelectionLogic(event:MouseEvent):void {
			
			//mouse is not touching any avatars
			if (utilities.Engine.Game.avatarManager.all_items_colliding_with_mouse(utilities.Engine.Game.avatarManager.getArray()).length == 0) {
				utilities.Engine.Game.avatarManager.deselectActors();
				//trace("Not touching any avatars");
			}
			
			//mouse is not touching any walls
			if(utilities.Engine.Game.levelManager.all_items_colliding_with_mouse(utilities.Engine.Game.levelManager.getArray()).length == 0) {
				utilities.Engine.Game.levelManager.deselectActors();
				//trace("Not touching any walls");
			}
			
			//mouse is not touching any enemies
			if(utilities.Engine.Game.enemyManager.all_items_colliding_with_mouse(utilities.Engine.Game.enemyManager.getArray()).length == 0) {
				utilities.Engine.Game.enemyManager.deselectActors();
				//trace("Not touching any enemies");
			}
			
			//mouse is touching more than 1 avatar
			if (utilities.Engine.Game.avatarManager.all_items_selected_except_the_one_that_was_just_clicked(utilities.Engine.Game.avatarManager.getArray()).length == 1) {
				var avatarsToDeselect:Array = new Array();
				avatarsToDeselect = utilities.Engine.Game.avatarManager.all_items_selected_except_the_one_that_was_just_clicked(utilities.Engine.Game.avatarManager.getArray());
				for each(var actor0:SelectableActor in avatarsToDeselect) {
					actor0.deselectActor();
				}
			}
			
			//mouse is touching more than 1 enemy
			if (utilities.Engine.Game.enemyManager.all_items_selected_except_the_one_that_was_just_clicked(utilities.Engine.Game.enemyManager.getArray()).length == 1) {
				var enemiesToDeselect:Array = new Array();
				enemiesToDeselect = utilities.Engine.Game.enemyManager.all_items_selected_except_the_one_that_was_just_clicked(utilities.Engine.Game.enemyManager.getArray());
				for each(var actor1:SelectableActor in enemiesToDeselect) {
					actor1.deselectActor();
				}
			}
			
			//mouse is touching more than 1 wall
			if (utilities.Engine.Game.levelManager.all_items_selected_except_the_one_that_was_just_clicked(utilities.Engine.Game.levelManager.getArray()).length == 1) {
				var wallsToDeselect:Array = new Array();
				wallsToDeselect = utilities.Engine.Game.levelManager.all_items_selected_except_the_one_that_was_just_clicked(utilities.Engine.Game.levelManager.getArray());
				trace(wallsToDeselect);
				for each(var actor2:SelectableActor in wallsToDeselect) {
					actor2.deselectActor();
				}
			}
			lastClickedActors.push(event.target);
			lastClickedCoordinates = Main.getMouseCoordinates();
			//trace("MouseInputManager: lastClickedCoordinates",lastClickedCoordinates);
		}
		
		//drag the game container with the mouse
		//when you stop dragging it, it eases to a stop
		//limit the maximum ease speed
		public function isDraggingWorld(e:Event):void {
			if (isDragging) {
				var mousePoint:Point = new Point();
				mousePoint = Main.getMouseCoordinates();
				delta.x = (mousePoint.x - oldMouse.x);
				delta.y = (mousePoint.y - oldMouse.y);
				utilities.Engine.Game.gameContainer.x = mousePoint.x + worldOffSet.x - mouseOffSet.x;
				utilities.Engine.Game.gameContainer.y = mousePoint.y + worldOffSet.y - mouseOffSet.y;
			}else if (!isDragging) {
				delta.x *= .8;
				delta.y *= .8;
				if (delta.x > maximumEase) {
					delta.x = maximumEase;
				}
				if (delta.y > maximumEase) {
					delta.y = maximumEase;
				}
				if (delta.x < -maximumEase) {
					delta.x = -maximumEase;
				}
				if (delta.y < -maximumEase) {
					delta.y = -maximumEase;
				}
				if (delta.x < .05 && delta.x > -.05) {
					delta.x = 0;
				}
				if (delta.y < .05 && delta.y > -.05) {
					delta.y = 0;
				}
				if (delta.x == 0 && delta.y == 0 ) {
					Main.theStage.addEventListener(Event.ENTER_FRAME, isDraggingWorld);
				}
				utilities.Engine.Game.gameContainer.x += delta.x;
				utilities.Engine.Game.gameContainer.y += delta.y;
			}
			oldMouse = Main.getMouseCoordinates();
		}
		
		public function stopDragWorld(event:MouseEvent):void {
			isDragging = false;
			Main.theStage.removeEventListener(MouseEvent.MOUSE_UP, startDragWorld);
		}
		
		public function getLastClickedCoordinates():Point {
			return lastClickedCoordinates;
		}
		
		public function getLastClickedActor():DisplayObject {
			return lastClickedActors[0];
		}
	}
}

