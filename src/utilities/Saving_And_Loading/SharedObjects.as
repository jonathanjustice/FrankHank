package utilities.Saving_And_Loading{//from livedocs
	import flash.events.NetStatusEvent;
    import flash.net.SharedObject;
    import flash.net.SharedObjectFlushStatus;
	import flash.display.*;
	public class SharedObjects {
		private static var _instance:SharedObjects;
		private var sharedObject:SharedObject;
	
		//gets the shared object,
		//if it doesn't exist, then make a new one and give it a default value
		public function SharedObjects(singletonEnforcer:SingletonEnforcer){
			getSharedObject();
		}
		
		public static function getInstance():SharedObjects {
			if(SharedObjects._instance == null){
				SharedObjects._instance = new SharedObjects(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function getSharedObject():Object {
			sharedObject = SharedObject.getLocal("sharedObj");
			if(sharedObject.data.savedValue == null){
				sharedObject.data.savedValue = 0;
			}
			return sharedObject.data.savedValue;
		}
		
        public function saveObjectToDisk(objectToSave:Object):void {
			sharedObject.data.savedValue = objectToSave;//set the saved value
			
			var flushStatus:String = null;
			//check to see if there is enough room to save
			try {
				flushStatus = sharedObject.flush(10000);
			} catch (error:Error) {
				//trace("Error...Could not write SharedObject to disk\n");
			}
			if (flushStatus != null) {
				switch (flushStatus) {
					case SharedObjectFlushStatus.PENDING:
					  // trace("Requesting permission to save object...\n");
						sharedObject.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
						break;
					case SharedObjectFlushStatus.FLUSHED:
					   //trace("Value flushed to disk.\n");
						break;
				}
			}
		  //  trace("loaded value: " + sharedObject.data.savedValue + "\n\n");
        }
        
        public function clearValue():void {
          //trace("Cleared saved value...Reload SWF and the value should be \"undefined\".\n\n");
            delete sharedObject.data.savedValue;
        }
        
        public function onFlushStatus(event:NetStatusEvent):void {
           trace("User closed permission dialog...\n");
            switch (event.info.code) {
                case "SharedObject.Flush.Success":
                  // trace("User granted permission -- value saved.\n");
                    break;
                case "SharedObject.Flush.Failed":
                   // trace("User denied permission -- value not saved.\n");
                    break;
            }
			//trace("\n");
            sharedObject.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
        }
	}
}
class SingletonEnforcer{}