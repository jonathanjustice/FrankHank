package utilities.customEvents {
import flash.events.Event;
	public class SoundEvent extends Event {
		public static const TEST_SOUND:String = "testSound";
		
		public function SoundEvent(type:String,bubbles:Boolean=true) {
			super(type);
			trace("type",type);
		}
	}
}
