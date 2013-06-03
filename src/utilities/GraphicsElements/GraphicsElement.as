package utilities.GraphicsElements{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import utilities.Actors.AFSEnemy;
	import utilities.Actors.Avatar;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Actors.GoonEnemy;
	import utilities.Actors.Powerup_shoot;
	import utilities.Actors.Powerup_doubleJump;
	import utilities.Actors.Powerup_invincible;
	import utilities.Actors.SelectableActor;
	import utilities.Actors.TankEnemy;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Engine.Combat.PowerupManager;
	import utilities.GraphicsElements.Test_rect;
	import utilities.GraphicsElements.Test_square;
	import utilities.Saving_And_Loading.swfLoader;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Actors.GameBoardPieces.Art;
	import utilities.Engine.LevelManager;
	import flash.system.Security;


	
	
	public class GraphicsElement extends MovieClip {
		/*
		 * File paths for swfs
		 * */
		
		//private var avatar:String = new String("../lib/avatar_swf.swf");
		private var bullet:String = new String("../src/assets/actors/swf_bullet.swf");
		private var frank:String = new String("../src/assets/actors/swf_frank.swf");
		private var goon:String = new String("../src/assets/actors/swf_goon.swf");
		private var afs:String = new String("../src/assets/actors/swf_afs.swf");
		private var tank:String = new String("../src/assets/actors/swf_tank.swf");
		private var powerup_doubleJump:String = new String("../src/assets/actors/swf_powerupDoubleJump.swf");
		private var powerup_invincible:String = new String("../src/assets/actors/swf_powerupInvincible.swf");
		private var powerup_shoot:String = new String("../src/assets/actors/swf_powerupShoot.swf");
		private var wall:String = new String("../src/assets/actors/swf_wall.swf");
		//test stuff
		private var bgSquare:String = new String("../src/assets/actors/swf_bgSquare.swf");
		
		//levels
		private var lvl_1:String = new String("../src/assets/levels/swf_lvl_1.swf");
		private var lvl_2:String = new String("../src/assets/levels/swf_lvl_2.swf");
		private var lvl_3:String = new String("../src/assets/levels/swf_lvl_3.swf");
		private var lvl_4:String = new String("../src/assets/levels/swf_lvl_4.swf");
		private var lvl_5:String = new String("../src/assets/levels/swf_lvl_5.swf");
		
		//screens & UI
		private var ui_levelComplete:String = new String("../src/assets/ui/swf_levelComplete.swf");
		
		
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
			Security.allowDomain("*");//doing this is real bad, needs to get fixed later
		}
		
		//aka wizard shit, don't make no kind of logical sense
		private function alignmentOfParentChildGraphics(par:MovieClip, ch:MovieClip):void {
			
			par.x = ch.x - ch.parent.x ;
			par.y = ch.y - ch.parent.y;
			ch.x = 0;
			ch.y = 0;
			ch.parent.removeChild(ch);
			if (par is Wall) {
				par.scaleX = ch.width;
				par.scaleY = ch.height;
			}
			if (par is Art) {
				par.addChild(ch);
			}
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
					
					if(tempArray[j].name == "art"){
						var art:Art = new Art();
						alignmentOfParentChildGraphics(art,tempArray[j]);
						LevelManager.arts.push(art);
					}
					if(tempArray[j].name == "wall"){
						var wall:Wall = new Wall();
						alignmentOfParentChildGraphics(wall,tempArray[j]);
						LevelManager.levels.push(wall);
					}
					if(tempArray[j].name == "goon"){
						var goon:GoonEnemy = new GoonEnemy();
						alignmentOfParentChildGraphics(goon,tempArray[j]);
						EnemyManager.enemies.push(goon);
					}
					if(tempArray[j].name == "tank"){
						var tank:TankEnemy = new TankEnemy();
						alignmentOfParentChildGraphics(tank,tempArray[j]);
						EnemyManager.enemies.push(tank);
					}
					if(tempArray[j].name == "avatar"){
						var avatar:Avatar  = new Avatar;
						alignmentOfParentChildGraphics(avatar,tempArray[j]);
						AvatarManager.avatars.push(avatar);
					}
					if(tempArray[j].name == "afs"){
						var afs:AFSEnemy = new AFSEnemy;
						alignmentOfParentChildGraphics(afs,tempArray[j]);
						EnemyManager.enemies.push(afs);
					}
					
					if(tempArray[j].name == "p_shoot"){
						var shootPowerup:Powerup_shoot = new Powerup_shoot;
						alignmentOfParentChildGraphics(shootPowerup,tempArray[j]);
						PowerupManager.powerups.push(shootPowerup);
					}
					
					if(tempArray[j].name == "p_doubleJump"){
						var doubleJumpPowerup:Powerup_doubleJump = new Powerup_doubleJump;
						alignmentOfParentChildGraphics(doubleJumpPowerup,tempArray[j]);
						PowerupManager.powerups.push(doubleJumpPowerup);
					}
					
					if(tempArray[j].name == "p_inv"){
						var invinviblePowerup:Powerup_invincible = new Powerup_invincible;
						alignmentOfParentChildGraphics(invinviblePowerup,tempArray[j]);
						PowerupManager.powerups.push(invinviblePowerup);
					}
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
				case "ui_levelComplete":
					filePath = ui_levelComplete;
					trace("graphicsElement: file path is ui_levelComplete");
					break;
				case "frank":
					filePath = frank;
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
					filePath = wall;
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
				case "lvl_1":
					filePath = lvl_1;
					break;
				case "lvl_2":
					filePath = lvl_2;
					break;
				case "lvl_3":
					filePath = lvl_3;
					break;
				case "lvl_4":
					filePath = lvl_4;
					break;
				case "lvl_5":
					filePath = lvl_5;
					break;
					
				case "bgSquare":
					filePath = bgSquare;
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
			myGraphic.graphics.drawRect(0,0,100,100);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
	}
}
