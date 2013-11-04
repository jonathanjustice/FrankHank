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
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Engine.LevelManager;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	public class MouseInputManager extends utilities.Engine.DefaultManager{
		
		public static var isDragging:Boolean = false;
		private var mouseOffSet:Point = new Point;
		private var worldOffSet:Point = new Point;
		private var delta:Point = new Point;
		private var oldMouse:Point = new Point;
		private var maximumEase:Number = 30;
		private static var lastClickedActors:Array = new Array();
		private static var lastClickedCoordinates:Point = new Point;
		private static var _instance:MouseInputManager;
		
		public function MouseInputManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public static function getInstance():MouseInputManager {
			if(MouseInputManager._instance == null){
				MouseInputManager._instance = new MouseInputManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
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
		public static function runSelectionLogic(event:MouseEvent):void {
			
			//mouse is not touching any avatars
			if (AvatarManager.getInstance().all_items_colliding_with_mouse(AvatarManager.getInstance().getArray()).length == 0) {
				AvatarManager.getInstance().deselectActors();
				//trace("Not touching any avatars");
			}
			
			//mouse is not touching any walls
			if(LevelManager.getInstance().all_items_colliding_with_mouse(LevelManager.getInstance().getWalls()).length == 0) {
				LevelManager.getInstance().deselectActors();
				//trace("Not touching any walls");
			}
			
			//mouse is not touching any enemies
			if(EnemyManager.getInstance().all_items_colliding_with_mouse(EnemyManager.getInstance().getArray()).length == 0) {
				EnemyManager.getInstance().deselectActors();
				//trace("Not touching any enemies");
			}
			/*
			//mouse is touching more than 1 avatar
			if (AvatarManager.all_items_selected_except_the_one_that_was_just_clicked(AvatarManager.getArray()).length == 1) {
				var avatarsToDeselect:Array = new Array();
				avatarsToDeselect = AvatarManager.getInstance().all_items_selected_except_the_one_that_was_just_clicked(AvatarManager.getArray());
				for each(var actor0:SelectableActor in avatarsToDeselect) {
					actor0.deselectActor();
				}
			}
			
			//mouse is touching more than 1 enemy
			if (EnemyManager.all_items_selected_except_the_one_that_was_just_clicked(EnemyManager.getInstance().getArray()).length == 1) {
				var enemiesToDeselect:Array = new Array();
				enemiesToDeselect = EnemyManager.getInstance().all_items_selected_except_the_one_that_was_just_clicked(EnemyManager.getInstance().getArray());
				for each(var actor1:SelectableActor in enemiesToDeselect) {
					actor1.deselectActor();
				}
			}
			
			//mouse is touching more than 1 wall
			if (utilities.Engine.Game.levelManager.all_items_selected_except_the_one_that_was_just_clicked(LevelManager.getInstance().getArray()).length == 1) {
				var wallsToDeselect:Array = new Array();
				wallsToDeselect = LevelManager.getInstance().all_items_selected_except_the_one_that_was_just_clicked(LevelManager.getInstance().getArray());
				trace(wallsToDeselect);
				for each(var actor2:SelectableActor in wallsToDeselect) {
					actor2.deselectActor();
				}
			}*/
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

class SingletonEnforcer{}
