package utilities.Audio{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.net.URLRequest; 
	import JSON;
	public class SoundManager extends MovieClip{
		
		private static var JSON_sounds:Object;
		public static var soundObjects:Array = new Array();
		private var filePath:String = "sound/GuileTheme.mp3";
		private static var _instance:SoundManager;
		
		public function SoundManager(singletonEnforcer:SingletonEnforcer){
			//createNewSoundObject(filePath);
			get_sounds_from_JsonParser();
			trace("filePath",filePath);
			//stop_a_sound_channel(filePath);
		}
		
		private static function get_sounds_from_JsonParser():void {
			trace(Main.game);
			trace(Main.game.getJsonParser());
			JSON_sounds = Main.game.getJsonParser().getData_mp3();
			trace("JSON_sounds", JSON_sounds.sounds[0].name);
			trace("JSON_sounds",JSON_sounds.sounds.mp3_guileTheme);
		}
		
		public static function getInstance():SoundManager {
			if(SoundManager._instance == null){
				SoundManager._instance = new SoundManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
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
		
		public static function destroySoundObject(soundObject:SoundObject):void {
			var index:int = soundObjects.lastIndexOf(soundObject);
			trace("index", index);
			soundObjects.splice(index, 1);
			soundObject = null;
			trace(soundObjects);
		}
	}
}

class SingletonEnforcer{}