package utilities.Audio{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.events.Event;
	import flash.net.URLRequest; 
	
	public class SoundObject{
		public var name:String;
		public var soundFile:Sound = new Sound(new URLRequest("audio/GuileTheme.mp3"));//if building in Flash IDE, need to specify entire filepath starting at the bin level, or be terrible and it put inside same folder as this class
		public var channel:SoundChannel = new SoundChannel();
		private var musicSound:Sound 
		public function SoundObject(soundFileLocation:String):void {
			createSound(soundFileLocation);
			//requestSounds();
		}
		
		//argument should be the URL eventually
		public function createSound(soundFileLocation:String):void {
			name = soundFileLocation;
			soundFile.addEventListener(Event.COMPLETE, loadSsound);
		}
		
		private function loadSsound($evt:Event):void{
			soundFile.removeEventListener(Event.COMPLETE, loadSsound);
			//playSound(999, .25);
      	}
		
		public function playSound(number_of_times_to_play:int,newVolume:Number):void{
			var soundVolume:Number = newVolume;
			var volume_sound_transform:SoundTransform = new SoundTransform(soundVolume,0);
            channel.soundTransform = volume_sound_transform;
			channel = soundFile.play(0, number_of_times_to_play);
		}

		public function stopSound():void {
			trace("soundobject: stopSound");
			channel.stop();
		}
		
		public function check_for_sound_complete():void {
			channel.addEventListener(Event.SOUND_COMPLETE, sound_completed);
		}
		
		private function sound_completed($evt:Event):void{
			trace("sound completed");
			channel.stop();
			//do some logic here
			channel.removeEventListener(Event.SOUND_COMPLETE, sound_completed);
		}
	}
}