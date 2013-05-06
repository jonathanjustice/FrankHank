package utilities.Audio{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.net.URLRequest; 
	public class SoundManager extends MovieClip{
		
		
		public var soundObjects:Array = new Array();
		private var filePath:String = "GuileTheme.mp3";
		
		public function SoundManager():void{
			//createNewSoundObject(filePath);
			//stop_a_sound_channel(filePath);
		}
		
		public function createNewSoundObject(file_path:String):void {
			var newSoundObject:SoundObject = new SoundObject(filePath);
			soundObjects.push(newSoundObject);
		}
		
		public function stop_a_sound_channel(channel_to_stop:String):void {
			for each(var soundObject:SoundObject in soundObjects) {
				if (soundObject.name == channel_to_stop) {
					soundObject.stopSound();
				}				
			}
		}
		
		public function stopAllSounds():void{
			for each(var soundObject:SoundObject in soundObjects) {
				soundObject.stopSound();				
			}
		}
	}
}