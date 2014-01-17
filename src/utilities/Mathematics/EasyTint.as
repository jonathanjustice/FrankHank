package utilities.Mathematics{
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Strong;
	import fl.motion.Color;
	public class EasyTint{  
		 public function EasyTint(){
			
		 }
		 
		 public static function setTint(obj:MovieClip,newTintColor:int):void{
			var newColor:Color = new Color();
			newColor.setTint (newTintColor, .5);
			obj.transform.colorTransform = newColor;
		 }
		 
		  public static function resetTint(obj:MovieClip):void{
			var newColor:Color = new Color();
			newColor.setTint (0, 0);
			obj.transform.colorTransform = newColor;
		 }
	 }
}