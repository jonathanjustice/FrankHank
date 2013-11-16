package utilities.Audio{
	import flash.media.Sound;
	import flash.media.*;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.events.Event;
	import flash.net.URLRequest; 
	import utilities.Saving_And_Loading.mp3Loader;
	
	public class SoundObject{
		public var name:String;
		//public var soundFile:Sound = new Sound(new URLRequest("Audio/GuileTheme.mp3"));//if building in Flash IDE, need to specify entire filepath starting at the bin level, or be terrible and it put inside same folder as this class
		public var channel:SoundChannel = new SoundChannel();
		private var sound:Sound = new Sound();
		private var soundLoader:mp3Loader = new mp3Loader();
		public function SoundObject(soundFileLocation:String):void {
			createSound(soundFileLocation);
			//requestSounds();
		}
		
		//argument should be the URL eventually
		public function createSound(soundFileLocation:String):void {
			name = soundFileLocation;
			soundLoader.beginLoad(this,soundFileLocation);
			trace("soundFileLocation",soundFileLocation);
			//soundFile.addEventListener(Event.COMPLETE, loadSound);
		}
		
		/*private function loadSound($evt:Event):void{
			soundFile.removeEventListener(Event.COMPLETE, loadSound);
			//playSound(999, .25);
      	}
		*/
		
		public function assignSound(newSound:Sound):void {
			trace("sound", newSound);
			//sound = newSound;
			sound = newSound;
			playSound(1,.25);
		}
		
		
		public function playSound(number_of_times_to_play:int,newVolume:Number):void{
			var soundVolume:Number = newVolume;
			var volume_sound_transform:SoundTransform = new SoundTransform(soundVolume,0);
            channel.soundTransform = volume_sound_transform;
			channel = sound.play(0, number_of_times_to_play);
			channel.addEventListener(Event.SOUND_COMPLETE, sound_completed);
		}

		public function stopSound():void {
			trace("soundobject: stopSound");
			channel.stop();
		}
		
		private function sound_completed($evt:Event):void{
			trace("sound completed");
			channel.stop();
			//do some logic here
			channel.removeEventListener(Event.SOUND_COMPLETE, sound_completed);
			resetSound();
		}
		
		private function resetSound():void {
			trace("resetSound");
			name = null;;
			channel = null;
			sound = null;
			soundLoader = null;
			SoundManager.destroySoundObject(this);
		}
	}
}