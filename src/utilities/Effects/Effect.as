package utilities.Effects {
import utilities.Actors.Actor;
import flash.display.MovieClip;
import flash.display.DisplayObject;
import flash.display.Sprite;
	public class Effect extends Actor {
		
		public function Effect() {
			
		}
		
		public function createNewHitbox():void {
			var newHitBox:Sprite = new Sprite();
			newHitBox = drawGraphicDefaultSmallRectangle()
			hitbox.addChild(newHitBox);
			trace("createNewHitBox-----------------------------------------this.parent",this.parent,"parent should be null here");
		}
		
		public function updateLoop():void {
			
		}
		
	}
}