package utilities.GraphicsElements{
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	
	public class Animation {
		public function Animation(){
			
		}
		
		public function gotoAndStopOnFrameLabel(movieClip:MovieClip,"label":String):void{
			movieClip.gotoAndStop("label");
		}
		
		public function stopAnimation(movieClip:MovieClip):void{
			movieClip.stop();
		}
		
		public function resetAnimation(movieClip:MovieClip):void{
			movieClip.gotoAndStop(0);
		}
		
		public function animationTrigger(movieClip:MovieClip,animationTrigger:String,animationResult:String):void{
			if(movieClip.label == animationTrigger){
				gotoAndPlay("animationResult");
			}
		}
		
	}
}
		