package utilities.Audio{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.net.URLRequest; 
	import JSON;
	import utilities.customEvents.*;
	public class SoundManager extends MovieClip{
		
		private static var JSON_sounds:Object;
		public static var soundObjects:Array = new Array();
		/*
		private var START_SCREEN_SONG:String = "sound/START_SCREEN_SONG.mp3";
		private var SONG_BG_1:String = "sound/SONG_BG_1.mp3";
		private var SONG_BG_2:String = "sound/SONG_BG_2.mp3";
		private var CUTSCENE_SONG_1:String = "sound/CUTSCENE_SONG_1.mp3";
		private var CUTSCENE_SONG_2:String = "sound/CUTSCENE_SONG_2.mp3";
		private var SONG_INVINCIBLE:String = "sound/SONG_INVINCIBLE.mp3";
		private var SONG_GAMEOVER:String = "sound/SONG_GAMEOVER.mp3";
		private var SONG_GAMEWON:String = "sound/SONG_GAMEWON.mp3";
		private var SONG_LEVEL_COMPLETE:String = "sound/SONG_LEVEL_COMPLETE.mp3";
		
		private var SHOOT_POWERUP_ACQUIRED:String = "sound/SHOOT_POWERUP_ACQUIRED.mp3";
		private var INVINCIBLE_POWERUP_ACQUIRED:String = "sound/INVINCIBLE_POWERUP_ACQUIRED.mp3";
		private var DOUBLEJUMP_POWERUP_ACQUIRED:String = "sound/DOUBLEJUMP_POWERUP_ACQUIRED.mp3";
		
		private var START_SCREEN_START_BUTTON_PRESSED:String = "sound/debug.mp3";
		private var START_SCREEN_NEWGAME_BUTTON_PRESSED:String = "sound/debug.mp3";
		private var START_SCREEN_CONTINUE_BUTTON_PRESSED:String = "sound/debug.mp3";
		
		private var CONTINUE_SCREEN_BACK_BUTTON_PRESSED:String = "sound/CONTINUE_SCREEN_BACK_BUTTON_PRESSED.mp3";
		private var CONTINUE_SCREEN_CONTINUE_BUTTON_PRESSED:String = "sound/CONTINUE_SCREEN_CONTINUE_BUTTON_PRESSED.mp3";
		private var CONTINUE_SCREEN_CODE_KEY_PRESS:String = "sound/CONTINUE_SCREEN_CODE_KEY_PRESS.mp3";
		private var FRANK_JUMP:String = "sound/FRANK_JUMP.mp3";
		private var TANK_HIT_ONCE:String = "sound/TANK_HIT_ONCE.mp3";
		private var THROW_TANK:String = "sound/THROW_TANK.mp3";
		private var KILL_ENEMY:String = "sound/KILL_ENEMY.mp3";
		private var COLLECT_COIN:String = "sound/COLLECT_COIN.mp3";
		private var COLLECT_GEM:String = "sound/COLLECT_GEM.mp3";
		private var EXTRA_LIFE:String = "sound/EXTRA_LIFE.mp3";
		private var FRANK_DIED:String = "sound/FRANK_DIED.mp3";
		private var FRANK_DAMAGED:String = "sound/FRANK_DAMAGED.mp3";
		private var LAZER_CHARGE:String = "sound/LAZER_CHARGE.mp3";
		private var LAZER_FIRE:String = "sound/LAZER_FIRE.mp3";
		private var LAZER_BOUNCE:String = "sound/LAZER_BOUNCE.mp3";
		private var LAZER_BOSS_DAMAGED:String = "sound/LAZER_BOSS_DAMAGED.mp3";
		private var LAZER_BOSS_DESTROYED:String = "sound/LAZER_BOSS_DESTROYED.mp3";
		*/
		//sdfsdfsdf
		
		private var START_SCREEN_SONG:String = "sound/debug.mp3";
		private var SONG_BG_1:String = "sound/SONG_INVINCIBLE.mp3";
		private var SONG_BG_2:String = "sound/SONG_INVINCIBLE.mp3";
		private var CUTSCENE_SONG_1:String = "sound/debug.mp3";
		private var CUTSCENE_SONG_2:String = "sound/debug.mp3";
		private var SONG_GAMEOVER:String = "sound/debug.mp3";
		private var SONG_GAMEWON:String = "sound/debug.mp3";
		private var SONG_LEVEL_COMPLETE:String = "sound/debug.mp3";
		private var SONG_INVINCIBLE:String = "sound/SONG_INVINCIBLE.mp3";
		
		
		private var SHOOT_POWERUP_ACQUIRED:String = "sound/SHOOT_POWERUP_ACQUIRED.mp3";
		private var INVINCIBLE_POWERUP_ACQUIRED:String = "sound/INVINCIBLE_POWERUP_ACQUIRED.mp3";
		private var DOUBLEJUMP_POWERUP_ACQUIRED:String = "sound/DOUBLEJUMP_POWERUP_ACQUIRED.mp3";
		
		private var START_SCREEN_START_BUTTON_PRESSED:String = "sound/debug.mp3";
		private var START_SCREEN_NEWGAME_BUTTON_PRESSED:String = "sound/debug.mp3";
		private var START_SCREEN_CONTINUE_BUTTON_PRESSED:String = "sound/debug.mp3";
		private var CONTINUE_SCREEN_BACK_BUTTON_PRESSED:String = "sound/debug.mp3";
		private var CONTINUE_SCREEN_CONTINUE_BUTTON_PRESSED:String = "sound/debug.mp3";
		private var CONTINUE_SCREEN_CODE_KEY_PRESS:String = "sound/debug.mp3";
		private var FRANK_JUMP:String = "sound/debug.mp3";
		private var TANK_HIT_ONCE:String = "sound/debug.mp3";
		private var THROW_TANK:String = "sound/debug.mp3";
		private var KILL_ENEMY:String = "sound/debug.mp3";
		private var COLLECT_COIN:String = "sound/debug.mp3";
		private var COLLECT_GEM:String = "sound/debug.mp3";
		private var EXTRA_LIFE:String = "sound/debug.mp3";
		private var FRANK_DIED:String = "sound/debug.mp3";
		private var FRANK_DAMAGED:String = "sound/debug.mp3";
		private var LAZER_CHARGE:String = "sound/debug.mp3";
		private var LAZER_FIRE:String = "sound/debug.mp3";
		private var LAZER_BOUNCE:String = "sound/debug.mp3";
		private var LAZER_BOSS_DAMAGED:String = "sound/debug.mp3";
		private var LAZER_BOSS_DESTROYED:String = "sound/debug.mp3";
		
		
		
		//file paths for sound
		//EVENT FORMAT FOR CALLING SONG EVENT:
		//Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","SOUNDNAME"));
		//imports needed for firing custom events
		//import utilities.customEvents.*;
		
		private var filePath:String = "";
		private static var _instance:SoundManager;
		
		public function SoundManager(singletonEnforcer:SingletonEnforcer){
			//createNewSoundObject(filePath);
			get_sounds_from_JsonParser();
			//trace("filePath",filePath);
			//stop_a_sound_channel(filePath);
			addSoundListeners();
		}
		
		public static function getInstance():SoundManager {
			if(SoundManager._instance == null){
				SoundManager._instance = new SoundManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
		}
		
		private static function get_sounds_from_JsonParser():void {
			//trace(Main.game);
			//trace(Main.game.getJsonParser());
			JSON_sounds = Main.game.getJsonParser().getData_mp3();
			//trace("JSON_sounds", JSON_sounds.sounds[0].name);
			//trace("JSON_sounds",JSON_sounds.sounds.mp3_guileTheme);
		}
		
		private function addSoundListeners():void {
			Main.theStage.addEventListener(SoundEvent.SOUND_START, startSound);
		}
	
		public function startSound(event:SoundEvent):void {
			var myResult:String = event.result;
			//trace(myResult);
			switch(event.result) {
				case "START_SCREEN_SONG":
					filePath = START_SCREEN_SONG;
					break;
				case "SONG_BG_1":
					filePath = SONG_BG_1;
					break;
				case "SONG_BG_2":
					filePath = SONG_BG_2;
					break;
				case "CUTSCENE_SONG_1":
					filePath = CUTSCENE_SONG_1;
					break;
				case "CUTSCENE_SONG_2":
					filePath = CUTSCENE_SONG_2;
					break;
				case "SONG_INVINCIBLE":
					filePath = SONG_INVINCIBLE;
					break;
				case "SONG_GAMEOVER":
					filePath = SONG_GAMEOVER;
					break;
				case "SONG_GAMEWON":
					filePath = SONG_GAMEWON;
					break;
				case "SONG_LEVEL_COMPLETE":
					filePath = SONG_LEVEL_COMPLETE;
					break;
				case "START_SCREEN_START_BUTTON_PRESSED":
					filePath = START_SCREEN_START_BUTTON_PRESSED;
					break;
				case "CONTINUE_SCREEN_BACK_BUTTON_PRESSED":
					filePath = CONTINUE_SCREEN_BACK_BUTTON_PRESSED;
					break;
				case "CONTINUE_SCREEN_CONTINUE_BUTTON_PRESSED":
					filePath = CONTINUE_SCREEN_CONTINUE_BUTTON_PRESSED;
					break;
				case "CONTINUE_SCREEN_CODE_KEY_PRESS":
					filePath = CONTINUE_SCREEN_CODE_KEY_PRESS;
					break;
				case "FRANK_JUMP":
					filePath = FRANK_JUMP;
					break;
				case "TANK_HIT_ONCE":
					filePath = TANK_HIT_ONCE;
					break;
				case "THROW_TANK":
					filePath = THROW_TANK;
					break;
				case "KILL_ENEMY":
					filePath = KILL_ENEMY;
					break;
				case "COLLECT_COIN":
					filePath = COLLECT_COIN;
					break;
				case "COLLECT_GEM":
					filePath = COLLECT_GEM;
					break;	
				case "EXTRA_LIFE":
					filePath = EXTRA_LIFE;
					break;
				case "FRANK_DAMAGED":
					filePath = FRANK_DAMAGED;
					break;
				case "LAZER_CHARGE":
					filePath = LAZER_CHARGE;
					break;
				case "LAZER_FIRE":
					filePath = LAZER_FIRE;
					break;
				case "LAZER_BOUNCE":
					filePath = LAZER_BOUNCE;
					break;
				case "LAZER_BOSS_DAMAGED":
					filePath = LAZER_BOSS_DAMAGED;
					break;
				case "LAZER_BOSS_DESTROYED":
					filePath = LAZER_BOSS_DESTROYED;
					break;
				
				
			}
			createNewSoundObject(filePath);
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
			//trace("index", index);
			soundObjects.splice(index, 1);
			soundObject = null;
			//trace(soundObjects);
		}
	}
}

class SingletonEnforcer{}