package utilities.objects {
	import flash.display.MovieClip;
	public class GameObject extends MovieClip{
		public function GameObject() {
			
		}
		
		public function print(string:String):void {
			trace("Class:::",this,"     Data:::",string);
		}
	}
}