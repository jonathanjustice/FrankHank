package utilities.Actors{
	import flash.display.MovieClip;
	import flash.events.*;
	public class Worker extends SelectableActor{
		private var isSelected:Boolean = false;
		private var moveSpeed:int = 10;
		private var filePath:String = "";
		public function Worker() {
			this.mouseChildren = true;
			this.mouseEnabled = true;
			this.addEventListener(MouseEvent.CLICK, clickedActor);
		}
		
		public function moveTowardsTarget():void {
			
		}
		
	}
}