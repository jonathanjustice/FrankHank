package utilities.Input{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyCodes;
	import utilities.Engine.DefaultManager;
	public class KeyInputManager{
		private static var isKeysEnabled:Boolean = false;
		private static var Key_right_2:Boolean = false;
		private static var Key_left_2:Boolean = false;
		private static var Key_up_2:Boolean = false;
		private static var Key_down_2:Boolean = false;
		private static var Key_right:Boolean = false;
		private static var Key_left:Boolean = false;
		private static var Key_up:Boolean = false;
		private static var Key_down:Boolean = false;
		private static var Key_space:Boolean = false;
		private static var Key_Z:Boolean = false;
		private static var Key_X:Boolean = false;
		
		private static var Key_W:Boolean = false;
		private static var Key_R:Boolean = false;
		private static var Key_rightBracket:Boolean = false;//we're using right bracket now, because my keyboard is a jerk
		private var keys:Array = new Array();
		private static var aimAngle:Number = 90;
		public static var myAngle:Number=0;
		private static var myVelocityX:Number=0;
		private static var myVelocityY:Number=0;
		private static var myRotation:Number=0;
		private static var Key_rotRight:Boolean = false;
		private static var Key_rotLeft:Boolean = false;
		private static var _instance:KeyInputManager;
		
		public function KeyInputManager(singletonEnforcer:SingletonEnforcer):void{
			setUp();
			//keys = [];
			
		}
		
		public static function getInstance():KeyInputManager {
			if(KeyInputManager._instance == null){
				KeyInputManager._instance = new KeyInputManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
		}
		
		public function setUp():void{
			//trace("keyinputmanager setup");
			myAngle = 0;
			Main.theStage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			isKeysEnabled = true;
		}
		
		public function removeKeyListeners():void{
			Main.theStage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.theStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		public function keyDownHandler(e:KeyboardEvent):void {
			//trace(e.keyCode);
			if(isKeysEnabled == true){
				//trace(e.keyCode);
				if(e.keyCode == KeyCodes.key_RIGHT_BRACKET){
					Key_rightBracket=true;
				}
				if(e.keyCode == KeyCodes.key_SPACEBAR){
					Key_space=true;
				}
				if(e.keyCode == KeyCodes.key_Z){
					Key_Z=true;
				}
				if(e.keyCode == KeyCodes.key_X){
					Key_X=true;
				}
				if (e.keyCode == 37) {
					Key_left_2 = true;
				}
				if(e.keyCode == 38){
					Key_up_2 = true;
				}
				if (e.keyCode == 39) {
					Key_right_2 = true;
				}
				if(e.keyCode == 40){
					Key_down_2=true;
				}
				if(e.keyCode == 100){
					Key_left = true;
				}
				if(e.keyCode == 104){
					Key_up=true;
				}
				if(e.keyCode == 102){
					Key_right=true;
				}
				if(e.keyCode == 98){
					Key_down=true;
				}
				if(e.keyCode == 103){
					Key_rotLeft=true;
				}
				if(e.keyCode == 105){
					Key_rotRight=true;
				}
				if(e.keyCode == 82){
					Key_R=true;
				}
				
				if(e.keyCode == 87){
					Key_W=true;
				}
			}
			setSimpleAngleViaKeys();
			setSimpleVelocityViaKeys();
			setSimpleRotationViaKeys();
		}
		
		public function keyUpHandler(e:KeyboardEvent):void {
			
			if(isKeysEnabled == true){
				if(e.keyCode == KeyCodes.key_RIGHT_BRACKET){
					Key_rightBracket=false;
				}
				if(e.keyCode == KeyCodes.key_SPACEBAR){
					Key_space=false;
				}
				if(e.keyCode == KeyCodes.key_Z){
					Key_Z = false;
				}
				if(e.keyCode == KeyCodes.key_X){
					Key_X = false;
				}
				if(e.keyCode == 37){
					Key_left_2 = false;
				}
				if(e.keyCode == 38){
					Key_up_2=false;
				}
				if(e.keyCode == 39){
					Key_right_2 = false;
				}
				if(e.keyCode == 40){
					Key_down_2=false;
				}
				if(e.keyCode == 100){
					Key_left=false;
				}
				if(e.keyCode == 104){
					Key_up=false;
				}
				if(e.keyCode == 102){
					Key_right=false;
				}
				if(e.keyCode == 98){
					Key_down=false;
				}
				if(e.keyCode == 103){
					Key_rotLeft=false;
				}
				if(e.keyCode == 105){
					Key_rotRight=false;
				}
				if(e.keyCode == 82){
					Key_R=false;
				}
				
				if(e.keyCode == 87){
					Key_W=false;
				}
				setSimpleAngleViaKeys();
				setSimpleVelocityViaKeys();
				setSimpleRotationViaKeys();
			}
		}
		
		public function setSimpleRotationViaKeys():void{
			if(Key_rotRight){
				myRotation = 3;
			}
			if(Key_rotLeft){
				myRotation = -3;
			}
			/*if(!Key_rotRight && !Key_rotLeft){
				myRotation = 0;
			}*/
			//trace("myRotation",myRotation);
		}
		
		public static function setSimpleVelocityViaKeys():void{
			myVelocityX = 0;
			if(Key_up_2 == false && Key_down_2 == false){
				myVelocityY = 0;
			}
			if(Key_left_2 == false && Key_right_2 == false){
				myVelocityX = 0;
			}
			if(Key_up_2){
				myVelocityY = -1;
			}
			if(Key_down_2){
				myVelocityY = 1;
			}
			if(Key_left_2){
				myVelocityX = -1;
				aimAngle = -90;
			}
			if(Key_right_2){
				myVelocityX = 1;
				aimAngle = 90;
			}
			/*if(Key_left_2 == true && Key_right_2 == true){
				myVelocityX = 0;
				Key_left_2 = false;
				Key_right_2 = false;
			}*/
		}
		
		public static function setSimpleAngleViaKeys():void{
			
			if(Key_up && Key_right){
				myAngle = 45;
			}
			else if(Key_up && Key_left){
				myAngle = -45;
			}
			else if(Key_up){
				myAngle = 0;
			}
			else if(Key_down && Key_right){
				myAngle = 135;
			}
			else if(Key_down && Key_left){
				myAngle = -135;
			}
			else if(Key_down){
				myAngle = -180;
			}
			else if(Key_left){
				myAngle = -90;
			}
			else if(Key_right){
				myAngle = 90;
			}
		}
		
		public function getAimAngle():Number {
			return aimAngle;
		}
		
		public static function getMyAngle():Number{
			//trace(myAngle);
			return myAngle;
		}
		
		public static function getMyVelocityX():Number{
			return myVelocityX;
		}
		public static function getMyRotation():Number{
			return myRotation;
		}
		public static function getMyVelocityY():Number{
			return myVelocityY;
		}
		
		public static function getRightBracket():Boolean{
			//trace("right bracket" + Key_rightBracket);
			return Key_rightBracket;
		}
		
		public static function getUpKey():Boolean{
			return Key_up_2;
		}
		
		public static function getLeftArrowKey():Boolean{
			return Key_left_2;
		}
		
		public static function getRightArrowKey():Boolean{
			return Key_right_2;
		}
		
		public static function getSpace():Boolean{
			return Key_space;
		}
		
		public static function getZKey():Boolean{
			//trace("space" + Key_space);
			return Key_Z;
		}
		
		public static function getXKey():Boolean{
			//trace("space" + Key_space);
			return Key_X;
		}
		
		public static function getRKey():Boolean{
			//trace("space" + Key_space);
			return Key_R;
		}
		
		public static function getWKey():Boolean{
			//trace("space" + Key_space);
			return Key_W;
		}
	}
}

class SingletonEnforcer{}