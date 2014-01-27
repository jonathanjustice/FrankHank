package utilities.Effects {
	import utilities.Engine.UIManager;
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import utilities.Engine.EffectsManager;
	
		
	public class FeedbackMovieClip extends Effect {

		
	
		private var fake_swf_child:MovieClip = new MovieClip();
		private var isListening:Boolean = true;
		public function FeedbackMovieClip(x:int, y:int,newEffect:MovieClip) {
			createNewHitbox();
			fake_swf_child.name = "swf_child";
			fake_swf_child.addChildAt(newEffect,0);
			fake_swf_child.addChildAt(hitbox,1);
			
			//trace("createNewHitBox-----------------------------------------hitbox.parent",hitbox.parent,"parent should NOT be null here");
			assignGraphic(fake_swf_child);
			this.x = x- this.width/2;
			this.y = y - this.height/2;
		}
		
		//ONLY USE WEBSAFE FONTS
		
		
			
		public function assignGraphic(graphic:DisplayObject):void {
		
			addActorToGameEngine(graphic, EffectsManager.effects);
			 try{
				assignedGraphic[0].getChildAt(0).getChildAt(0).getChildAt(0).gotoAndPlay(1);
            }catch (e : Error){
              /*  trace("whatever");
				trace("FBMC gotoAndPlay:  assignedGraphic[0].name", assignedGraphic[0].name);
				trace("FBMC gotoAndPlay:  assignedGraphic[0].getChildAt(0).name", assignedGraphic[0].getChildAt(0).name);
				trace("FBMC gotoAndPlay:  assignedGraphic[0].getChildAt(0).getChildAt(0).name", assignedGraphic[0].getChildAt(0).getChildAt(0).name);
				trace("FBMC gotoAndPlay:  assignedGraphic[0].getChildAt(0).getChildAt(0).getChildAt(0).name", assignedGraphic[0].getChildAt(0).getChildAt(0).getChildAt(0).name);*/
            }
			//trace("FBMC:  assignedGraphic[0].swf_child", assignedGraphic[0].swf_child);
			//trace("FBMC:  assignedGraphic[0].swf_child.getChildAt(0).name", assignedGraphic[0].swf_child.getChildAt(0).name);
		//	hitbox = this.assignedGraphic[0].swf_child.hitbox;
		//	hitzone = this.assignedGraphic[0].swf_child.hitzone;
			//playAnimation("walk");
		}
		
		public override function updateLoop():void {
			if (isListening == true) {
				listenForStopFrame();	
			}
			checkForDeathFlag();
		}
		
		public override function listenForStopFrame():void {
			//trace("listen");
			//this is madness
			 try {
				if (assignedGraphic[0].getChildAt(0).getChildAt(0).getChildAt(0).currentLabel == "stop") {
					//trace("found stop label ");
					assignedGraphic[0].getChildAt(0).stop();
					isListening = false;
					markDeathFlag();
				}
			}catch (e : Error) {
				//trace("whatever, stop label not found");
				assignedGraphic[0].getChildAt(0).stop();
				isListening = false;
				markDeathFlag();
			}
		}
		
		public function addScreenToUIContainer():void{
			utilities.Engine.UIManager.uiContainer.addChild(this);
		}
		public function removeTextField():void{
			utilities.Engine.UIManager.uiContainer.removeChild(this);
		}
	}
}