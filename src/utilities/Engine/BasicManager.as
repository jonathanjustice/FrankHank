//Singleton Pattern
package utilities.Engine{
	import flash.display.MovieClip;
	import utilities.Actors.Actor;
	import utilities.Actors.SelectableActor;
	import flash.geom.Point;
	public class BasicManager {
		private static var newSelectedItems:Array = new Array();
		
		public function BasicManager(){
			
		}
		
		private function getArray():Array{
			var array:Array = new Array();
			return array;
		}
		
		public function destroyArray(array:Array):void {
			for(var i:int = array.length-1; i>-1;i--){
				trace("array:",array,"i:",i);
				array[i].removeActorFromGameEngine(array[i], array);
			}
		}
		
		public function get_Index_of_actor_in_array(actor:MovieClip,array:Array):int{
			array = getArray();
			var index:int = array.indexOf(actor);
			return index;
		}
		
		//gives you all the items that touch the mouse
		public function all_items_colliding_with_mouse(array:Array):Array {
			//trace("all items colliding with mouse");
			var colldingWithMouse:Array = new Array();
			var mousePoint:Point = new Point();
				mousePoint = Main.getMouseCoordinates();
			for each(var actor:SelectableActor in array) {
				
				if (actor.hitTestPoint(mousePoint.x,mousePoint.y)) {
					colldingWithMouse.push(actor);
				}
			}
			return colldingWithMouse;
		}
		
		//gives you all the selected items except the one the mouse 
		//is colliding with and is on the top of the z order
		public static function all_items_selected_except_the_one_that_was_just_clicked(array:Array):Array {
			newSelectedItems = [];
			var oldSelectedItems:Array = new Array();
			var mousePoint:Point = Main.getMouseCoordinates();
				mousePoint = Main.getMouseCoordinates();
			for each(var actor:SelectableActor in array) {
				if (actor.getIsSelected() == true) {
					if (actor.hitTestPoint(mousePoint.x,mousePoint.y)) {
						//don't unselect it
						newSelectedItems.push(actor);
					}else {
						oldSelectedItems.push(actor);
					}
				}
			}
			return oldSelectedItems;
		}
		//get all the selected actors
		public function getNewSelectedItems():Array {
			return newSelectedItems;
		}
	}
}
