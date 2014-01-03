package utilities.Effects {
import flash.geom.Point;
import utilities.Actors.Actor;
import flash.display.MovieClip;
import flash.display.DisplayObject;
import flash.display.Sprite;
	public class Effect extends Actor {
		
		public function Effect() {
			
		}
		
		public function defineSpawnPoint(position:Point,vector:Point):void {
			setIntialPreviousPosition(position);
			this.x = position.x;
			this.y = position.y;
		}
		
		//public function
		//this is important to not crash the game for things that are dynamically created and don't have a hitbox baked into an art swf
		public function createNewHitbox():void {
			var newHitBox:Sprite = new Sprite();
			newHitBox = drawGraphicDefaultSmallRectangle()
			hitbox.addChild(newHitBox);
			//trace("createNewHitBox-----------------------------------------this.parent",this.parent,"parent should be null here");
		}
		
		public function updateLoop():void {
			
		}
		
	}
}