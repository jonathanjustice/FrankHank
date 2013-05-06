package utilities.Input{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Microphone;
	//import flash.Security;
	public class Mic extends Sprite{
		private var micVolume:Number=0;
		private var myMic:Microphone = Microphone.getMicrophone();
		public function Mic():void{
			//Security.showSettings(SecurityPanel.MICROPHONE);
			myMic.setLoopBack(true);
			myMic.setUseEchoSuppression(true);
			this.addEventListener(Event.ENTER_FRAME, update);
			
		}
		
		private function update(e:Event):void{
			micVolume = myMic.activityLevel;
			//stage.line_mc.width = myMic.activityLevel;
			//stage.activity_dyn.text = "Activity: " + String(myMic.activityLevel) + "%";
			//stage.width_dyn.text = "Line_mc Width: " + String(line_mc.width) + "px";
			//trace(myMic.activityLevel);
		}
		
		public function getMicVolume():Number{
			return micVolume;
		}
	}
}
