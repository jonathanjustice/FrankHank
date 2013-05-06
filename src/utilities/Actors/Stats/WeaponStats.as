package utilities.Actors.Stats{
	public class WeaponStats{
		public static var speedy:int=1;
		private static var heatSeeking:int=1;
		private static var blobular:int=0;
		private static var spreadRate:int=30;
		private static var sharkness:int=1;
		private static var sizeMod:int=0;
		private static var stickiness:int=0;
		
		public function WeaponStats(){
			
		}
		
		public static function getSpeedy():int{
			return speedy;
		}
		
		public static function getHeatSeeking():int{
			return heatSeeking;
		}
		
		public static function getBlobular():int{
			return blobular;
		}
		
		public static function getBlobSpreadRate():int{
			return spreadRate;
		}
		
		public static function getSizeMod():int{
			return sizeMod;
		}
		
		public static function getSharkness():int{
			return sharkness;
		}
		
		public static function getStickiness():int{
			return stickiness;
		}
	}
}