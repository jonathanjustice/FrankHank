package utilities.GraphicsElements{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Actors.SelectableActor;
	import utilities.GraphicsElements.Test_rect;
	import utilities.GraphicsElements.Test_square;
	import utilities.Saving_And_Loading.swfLoader;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Engine.LevelManager;
	
	
	public class GraphicsElement extends MovieClip {
		/*
		 * File paths for swfs
		 * */
		
		//private var avatar:String = new String("../lib/avatar_swf.swf");
		private var bullet:String = new String("../src/assets/swf_bullet.swf");
		private var avatar:String = new String("../src/assets/swf_frank.swf");
		private var goon:String = new String("../src/assets/swf_goon.swf");
		private var afs:String = new String("../src/assets/swf_afs.swf");
		private var tank:String = new String("../src/assets/swf_tank.swf");
		private var powerup_doubleJump:String = new String("../src/assets/swf_powerupDoubleJump.swf");
		private var powerup_invincible:String = new String("../src/assets/swf_powerupInvincible.swf");
		private var powerup_shoot:String = new String("../src/assets/swf_powerupShoot.swf");
		
		//levels
		private var lvl_02:String = new String("../src/assets/swf_lvl_02.swf");
		//private var wall:String = new String("../src/assets/swf_wall.swf");
		
		/*
		 * Everything else
		 * */
		private var myGraphic:Sprite = new Sprite(); 
		public var newGraphic:MovieClip = new MovieClip(); 
		//public var assignedGraphic:MovieClip = new MovieClip(); 
		public var assignedGraphics:Array = new Array();
		private var currentParent:MovieClip = new MovieClip();
		private var isLevel:Boolean = false;
		private var tempArray:Array = new Array();
		public function GraphicsElement():void{
			
		}
		
		//aka wizard shit, don't make no kind of logical sense
		private function alignmentOfParentChildGraphics(par:MovieClip,ch:MovieClip):void {
			par.x = ch.x - ch.parent.x ;
			par.y = ch.y - ch.parent.y;
			ch.x = 0;
			ch.y = 0;
			ch.parent.removeChild(ch);
			par.addChild(ch);
			par.setUp();
			if (currentParent is SelectableActor) {
				currentParent.addClickability_onLoadComplete(par);
			}
		}
		
		//objects in the graphic's swf can be accessed through: assignedGraphics[0].swf_child
		public function assignGraphic(graphic:DisplayObject):void {
			assignedGraphics.push(graphic);
			if (isLevel == true) {
				
				for (var i:int = 0; i < assignedGraphics[0].swf_child.numChildren; i++) {
					tempArray.push(assignedGraphics[0].swf_child.getChildAt(i));
				}
				for (var j:int = 0; j < tempArray.length; j++) {
					trace(currentParent);
					var wall:Wall = new Wall();
					alignmentOfParentChildGraphics(wall,tempArray[j]);
					LevelManager.levels.push(wall);
				}
			}else{
				parent.addChild(graphic);
				currentParent.assignedGraphic.push(graphic);
			}
			if (currentParent is SelectableActor) {
				currentParent.addClickability_onLoadComplete(graphic);
			}
			parent.removeChild(this);
			currentParent.setIsSwfLoaded(true);
		}
		
		//loads a swf based on the filePath from the actor type
		public function loadSwf(filePath:String, swfParent:MovieClip, isLvl:Boolean=false):void {
			currentParent = swfParent;
			if (isLvl == true) {
				isLevel = true;
			}
			switch(filePath) {
				case "frank":
					filePath = avatar;
					break;
				case "goon":
					filePath = goon;
					break;
				case "afs":
					filePath = afs;
					break;
				case "tank":
					filePath = tank;
					break;
				case "wall":
					//filePath = wall;
					break;
				case "powerup_doubleJump":
					filePath = powerup_doubleJump;
					break;
				case "powerup_invincible":
					filePath = powerup_invincible;
					break;
				case "bullet":
					filePath = bullet;
					break;
				case "powerup_shoot":
					filePath = powerup_shoot;
					break;
				case "lvl_02":
					filePath = lvl_02;
					break;
			}
			var loader:swfLoader = new swfLoader();
			loader.beginLoad(this, filePath);
			loader = null;
		}
		
		//format for using movieclips from a MAIN project FLA library
		//used only for quick testing or other stupid bullshit
		public function drawGraphicFromMainFLA():void{
			var newGraphic:utilities.GraphicsElements.Test_rect = new utilities.GraphicsElements.Test_rect();
			this.addChild(newGraphic);
		}
		
		//draws a default graphic, just so the game doesn't crash if I haven't made graphics for an object yet
		
		//wall
		public function drawGraphicDefaultRectangle():void{
			myGraphic.graphics.lineStyle(3,0x0000ff);
			myGraphic.graphics.beginFill(0x8800FF);
			myGraphic.graphics.drawRect(0,0,300,100);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
	}
}
