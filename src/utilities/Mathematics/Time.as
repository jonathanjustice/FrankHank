package utilities.Mathematics {
	import flash.display.Sprite;
	import flash.utils.getTimer;
	public class Time {
		public function Time() {
			
		}
		
		public static function timeElapsedSinceGameStarted():String {
			var milliseconds:uint = getTimer()/1000;
			var hrs:String = (milliseconds > 3600 ? Math.floor(milliseconds / 3600) + ':' : '');
			var mins:String = (hrs && milliseconds % 3600 < 600 ? '0' : '') + Math.floor(milliseconds % 3600 / 60) + ':';
			var secs:String = (milliseconds % 60 < 10 ? '0' : '') + milliseconds % 60;
			return hrs + mins + secs;
		}

		//pass in milliseconds, get time in a format that normal humans (and possibly chimps) can comprehend
		public function millisecondsToTime(milliseconds:Number):String{
			var hrs:String = (milliseconds > 3600 ? Math.floor(milliseconds / 3600) + ':' : '');
			var mins:String = (hrs && milliseconds % 3600 < 600 ? '0' : '') + Math.floor(milliseconds % 3600 / 60) + ':';
			var secs:String = (milliseconds % 60 < 10 ? '0' : '') + milliseconds % 60;
			return hrs + mins + secs;
		}
	}
}
