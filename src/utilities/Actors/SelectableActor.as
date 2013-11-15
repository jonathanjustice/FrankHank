package utilities.Actors{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.GlowFilter;
	import utilities.Input.MouseInputManager;
	public class SelectableActor extends Actor{
		private var isSelected:Boolean = false;
		private var filePath:String = "";
		public function SelectableActor() {
			this.mouseChildren = true;
			this.mouseEnabled = true;
			this.addEventListener(MouseEvent.CLICK, clickedActor);
		}
		
		public function addClickability_onLoadComplete(graphic:MovieClip):void {
			//trace("SelectableActor TYPE:",this);
			graphic.mouseChildren = true;
			graphic.mouseEnabled = true;
			graphic.addEventListener(MouseEvent.CLICK, clickedActor);
		}
		
		private function clickedActor(event:MouseEvent):void {
			MouseInputManager.runSelectionLogic(event);
			//trace("clicked")
			if (isSelected) {
			//	deselectActor();
			}else {
			//	selectActor();
			}
		}
		
	/*	private function clickedChildOfActor(event:MouseEvent):void {
			trace("clicked child")
			if (isSelected) {
				deselectActor();
			}else {
				selectActor();
			}
		}
		*/
		
		/*
		 *  GLOBAL DE-SLSECT comes from MouseInputManager
		 */
		public function deselectActor():void {
			//trace("deselect",this);
			isSelected = false;
			removeStroke();
		}
		
		public function selectActor():void {
			//trace("select",this);
			isSelected = true;
			addStroke();
		}
		
		public function addStroke():void {
			var glowFilter:BitmapFilter = getGlowFilter();
			filters = [ glowFilter ];
		}
		
		private function getGlowFilter():BitmapFilter {
            var color:Number = 0x00ff00;
            var alpha:Number = 1;
            var blurX:Number = 10;
            var blurY:Number = 10;
            var strength:Number = 2;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.HIGH;

            return new GlowFilter(color,alpha,blurX,blurY,strength,quality,inner,knockout);
        }
		
		public function removeStroke():void {
			var glowFilter:BitmapFilter = clearGlowFilter();
			filters = [ glowFilter ];
		}
		
		private function clearGlowFilter():BitmapFilter {
            var color:Number = 0x000000;
            var alpha:Number = 1;
            var blurX:Number = 0;
            var blurY:Number = 0;
            var strength:Number = 0;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.LOW;

            return new GlowFilter(color,alpha,blurX,blurY,strength,quality,inner,knockout);
        }
		
		public function getIsSelected():Boolean {
			return isSelected;
		}
	}
}