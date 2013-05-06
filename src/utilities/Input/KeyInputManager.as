package utilities.Input{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyCodes;
	import utilities.Engine.DefaultManager;
	public class KeyInputManager extends utilities.Engine.DefaultManager{
		private var isKeysEnabled:Boolean = false;
		private var Key_right_2:Boolean = false;
		private var Key_left_2:Boolean = false;
		private var Key_up_2:Boolean = false;
		private var Key_down_2:Boolean = false;
		private var Key_right:Boolean = false;
		private var Key_left:Boolean = false;
		private var Key_up:Boolean = false;
		private var Key_down:Boolean = false;
		private var Key_space:Boolean = false;
		private var Key_rightBracket:Boolean = false;//we're using right bracket now, because my keyboard is a jerk
		private var keys:Array = new Array();
		private var aimAngle:Number = 90;
		public var myAngle:Number=0;
		private var myVelocityX:Number=0;
		private var myVelocityY:Number=0;
		private var myRotation:Number=0;
		private var Key_rotRight:Boolean = false;
		private var Key_rotLeft:Boolean = false;
		
		public function KeyInputManager():void{
			//keys = [];
			setUp();
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
		
		public function keyDownHandler(e:KeyboardEvent):void{
			if(isKeysEnabled == true){
				//trace(e.keyCode);
				if(e.keyCode == KeyCodes.key_RIGHT_BRACKET){
					Key_rightBracket=true;
				}
				if(e.keyCode == KeyCodes.key_SPACEBAR){
					Key_space=true;
				}
				if(e.keyCode == 37){
					Key_left_2=true;
				}
				if(e.keyCode == 38){
					Key_up_2=true;
				}
				if(e.keyCode == 39){
					Key_right_2=true;
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
			}
			setSimpleAngleViaKeys();
			setSimpleVelocityViaKeys();
			setSimpleRotationViaKeys();
			//trace(e.keyCode);
		}
		
		public function keyUpHandler(e:KeyboardEvent):void{
			if(isKeysEnabled == true){
				if(e.keyCode == KeyCodes.key_RIGHT_BRACKET){
					Key_rightBracket=false;
				}
				if(e.keyCode == KeyCodes.key_SPACEBAR){
					Key_space=false;
				}
				if(e.keyCode == 37){
					Key_left_2=false;
				}
				if(e.keyCode == 38){
					Key_up_2=false;
				}
				if(e.keyCode == 39){
					Key_right_2=false;
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
		
		public function setSimpleVelocityViaKeys():void{
			
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
		}
		
		public function setSimpleAngleViaKeys():void{
			
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
		
		public function getMyAngle():Number{
			//trace(myAngle);
			return myAngle;
		}
		
		public function getMyVelocityX():Number{
			return myVelocityX;
		}
		public function getMyRotation():Number{
			return myRotation;
		}
		public function getMyVelocityY():Number{
			return myVelocityY;
		}
		
		public function getRightBracket():Boolean{
			//trace("space" + Key_space);
			return Key_rightBracket;
		}
		
		public function getSpace():Boolean{
			//trace("space" + Key_space);
			return Key_space;
		}
	}
}

