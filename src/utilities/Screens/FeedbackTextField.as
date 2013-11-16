package utilities.Screens {
	import utilities.Engine.UIManager;
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.MovieClip;

	public class DefaultTextField extends MovieClip {
		private var textField:TextField = new TextField();
		public function DefaultTextField(
				x:int = 25, 
				y:int = 25, 
				textCopy:String = "Butts Butts Butts Butts", 
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
			textField.autoSize=TextFieldAutoSize.LEFT;
			textField.defaultTextFormat=textFormat;
			
			textField.x=x;
			textField.y=x;
			textField.selectable=false;
			//field2.embedFonts=true;
			textField.multiline=true;
			textField.width=500;
			textField.wordWrap = true;
			textField.text = textCopy;
			this.addChild(textField);
			addScreenToUIContainer();
			setNewTextFormat();
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