package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class WeaponController extends MovieClip{
		private var Arcs:Number=0;//how many enemies it can arc to
		private var arcFromGun:Number=0;//arcs from the gun
		private var seeks:Number=0;//heat seeking strength
		private var Splash:Number=0;//amount of splash damage
		private var DoT:Number=0;//damage over time
		private var fragments:Number=0;//fragments exploding out on collision
		private var sharkness:Number=0;//are the bullets sharks?
		private var spread:Number=0;//the angle of spread for shots
		private var spreadVariability:Number=0;//the amount that the spread can vary
		private var shots:Number=0;//the number of shots fired at one time
		private var shotsVariability:Number=0;//the amount that the number of shots fired at one time can vary
		private var speed:Number=0;//Speed of shot
		private var speedVariability:Number=0;//variation in speed
		private var trails:Number=0;//number of fragments that trail from the shot
		private var trailSpread:Number=0;//the angle that the trails spread out at
		private var trailSpeed:Number=0;//the speed of trail fragments
		private var centralShot:Number=0;//how much more powerful is the center shot than the others
		private var size:Number=0;//size of bullets
		private var outerColor:Number=0;//outer color of bullet
		private var innerColor:Number=0;//inner color of bullet
		
		public function WeaponController(){
			
		}
		
		public function fireNewShot(){
			//give the shot its properties
			
			//align it to the player
			
			//put it in the array
			
			//send it to the stage
		}
		
	}
}