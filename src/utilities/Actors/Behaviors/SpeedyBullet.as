package utilities.Actors.Behaviors{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import utilities.Actors.Stats.WeaponStats;

	
	public class SpeedyBullet extends MovieClip{
		
		//private var gameContainer;
		public static var velocityMultiplier:Number=10;
		
		
		private var health:Number=1;
		public var damage:Number=2;
		
		
		public function SpeedyBullet(){
			
		}
		public function setUp(){
			
		}
		//use the global weapon stats to determine the speed
		public static function getVelocityMultiplier(){
			return ( (velocityMultiplier*utilities.Actors.Stats.WeaponStats.getSpeedy()/100 ) +1);
		}
		
		/*
		public function defineBaseGraphic(){
			var frame
		}
		*/
		
		
		public function updateLoop(){
			
			//fasterBullets();
		}
		
		
	}
}