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

	public class FeedbackTextField extends Effect {
		private var lifeTime:int=25;
		private var time:int = 0;
		private var fadeTime:int = 10;
		private var textField:TextField = new TextField();
		private var fake_swf_child:MovieClip = new MovieClip();
		public function FeedbackTextField(
				x:int, 
				y:int, 
				textCopy:String = "FRANKED!", 
				url:String = "http://www.google.com", 
				urlTargetWindow:String="_blank",
				font:String = 'Verdana', 
				colorHexCode:String = "0xff9900", 
				fontSize:int = 16, boldness:Boolean = true, 
				italics:Boolean = true, 
				underline:Boolean = false,
				indent:Object = null, 
				leading:Object = null) 
			{
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.url = url;
			textFormat.target = urlTargetWindow;
			textFormat.font=font;
			textFormat.color=colorHexCode;
			textFormat.size=fontSize;
			textFormat.bold=boldness;
			textFormat.italic=italics;
			textField.autoSize=TextFieldAutoSize.CENTER;
			textField.defaultTextFormat=textFormat;
			
			
			textField.selectable=false;
			//field2.embedFonts=true;
			textField.multiline=false;
			//textField.width=500;
			textField.wordWrap = false;
			textField.text = textCopy;
			//this.addChild(textField);
			//addScreenToUIContainer();
			createNewHitbox();
			fake_swf_child.name = "swf_child";
			fake_swf_child.addChild(textField);
			fake_swf_child.addChild(hitbox);
			
			//trace("createNewHitBox-----------------------------------------hitbox.parent",hitbox.parent,"parent should NOT be null here");
			assignGraphic(fake_swf_child);
		
			setNewTextFormat();
			this.x = x- this.width/2;
			this.y = y - this.height/2;
		}
		
		//ONLY USE WEBSAFE FONTS
		public function setNewTextFormat(
				url:String = "", 
				urlTargetWindow:String="_blank",
				font:String = 'Verdana',
				colorHexCode:String = "0xff9236",
				fontSize:int = 24,
				boldness:Boolean = true,
				italics:Boolean = true,
				indent:Object = null, 
				leading:Object = null):void
			{
			var textFormat:TextFormat = new TextFormat();
			textFormat.url = url;
			textFormat.target = urlTargetWindow;
			textFormat.font=font;
			textFormat.color=colorHexCode;
			textFormat.size=fontSize;
			textFormat.bold=boldness;
			textFormat.italic=italics;
			//textField.defaultTextFormat = applyTextFormat();
			textField.setTextFormat(textFormat);
		}
		
			
		public function assignGraphic(graphic:DisplayObject):void {
		
			addActorToGameEngine(graphic, EffectsManager.effects);
		
		//	hitbox = this.assignedGraphic[0].swf_child.hitbox;
		//	hitzone = this.assignedGraphic[0].swf_child.hitzone;
			//playAnimation("walk");
		}
		
		public override function updateLoop():void {
			if (time <= lifeTime) {
				time++;
				this.y -= 8;
				this.textField.scaleX *= 1.05;
				this.textField.scaleY *= 1.05;
				if (time > fadeTime) {
					this.alpha -= .1;
				}
			}else {
				markDeathFlag();
			}
			checkForDeathFlag();
		}
		
		public function updateTextField(newText:String):void {
			textField.text = newText;
		}
		
		public function addScreenToUIContainer():void{
			utilities.Engine.UIManager.uiContainer.addChild(this);
		}
		public function removeTextField():void{
			utilities.Engine.UIManager.uiContainer.removeChild(this);
		}
	}
}