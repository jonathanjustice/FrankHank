package utilities.GraphicsElements{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import utilities.Actors.Actor;
	import utilities.Actors.AFSEnemy;
	import utilities.Actors.Avatar;
	import utilities.Actors.Bullet;
	import utilities.Actors.GameBoardPieces.Trigger_EndZone;
	import utilities.Actors.GameBoardPieces.Trigger_CutScene;
	import utilities.Actors.GameBoardPieces.Trigger_EngineCutScene;
	import utilities.Actors.GameBoardPieces.Trigger_CameraLock;
	import utilities.Actors.GameBoardPieces.Trigger_ActivateBoss;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Actors.GoonEnemy;
	import utilities.Actors.Coin;
	import utilities.Actors.SavePoint;
	import utilities.Actors.Gem;
	import utilities.Actors.Powerup_shoot;
	import utilities.Actors.Powerup_doubleJump;
	import utilities.Actors.Powerup_invincible;
	import utilities.Actors.SelectableActor;
	import utilities.Actors.TankEnemy;
	import utilities.Actors.BossEnemy;
	import utilities.Actors.SpiderEnemy;
	import utilities.Engine.Game;
	import utilities.Engine.CutSceneManager;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Engine.Combat.EnemyManager;
	import utilities.Engine.Combat.PowerupManager;
	import utilities.GraphicsElements.Test_rect;
	import utilities.GraphicsElements.Test_square;
	import utilities.objects.GameObject;
	import utilities.Saving_And_Loading.swfLoader;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Actors.GameBoardPieces.Trigger;
	import utilities.Actors.GameBoardPieces.MovingWall;
	import utilities.Actors.GameBoardPieces.Art;
	import utilities.Engine.LevelManager;
	import flash.system.Security;
	import utilities.Screens.GameScreens.CutScene;


	//this class is insanely inefficient
	//every time I create one graphic, i create EVERY GRAPHIC
	
	public class SwfParser extends GameObject {
		private var childrenToLoad:int = 0;
		private var childrenLoaded:int = 0;
		private var isGraphicLoaded:Boolean = false;
		private static var _instance:SwfParser;
		/*
		 * File paths for swfs
		 * */
		
		//private var avatar:String = new String("../lib/avatar_swf.swf");
		//private var bullet:String = new String("../src/assets/actors/swf_bullet.swf");
		//private var frank:String = new String("../src/assets/actors/swf_frank.swf");
		//private var goon:String = new String("../src/assets/actors/swf_goon.swf");
		//private var afs:String = new String("../src/assets/actors/swf_afs.swf");
		//private var tank:String = new String("../src/assets/actors/swf_tank.swf");
		//private var powerup_doubleJump:String = new String("../src/assets/actors/swf_powerupDoubleJump.swf");
		//private var powerup_invincible:String = new String("../src/assets/actors/swf_powerupInvincible.swf");
		//private var powerup_shoot:String = new String("../src/assets/actors/swf_powerupShoot.swf");
		//private var wall:String = new String("../src/assets/actors/swf_wall.swf");
		//private var coin:String = new String("../src/assets/actors/swf_coin.swf");
		//private var gem:String = new String("../src/assets/actors/swf_gem.swf");
		//private var savePoint:String = new String("../src/assets/actors/swf_savePoint.swf");
		//test stuff
		private var bgSquare:String = new String("../src/assets/actors/swf_bgSquare.swf");
		
		//levels
		private var lvl_1:String = new String("../src/assets/levels/swf_lvl_1.swf");
		private var lvl_2:String = new String("../src/assets/levels/swf_lvl_2.swf");
		private var lvl_3:String = new String("../src/assets/levels/swf_lvl_3.swf");
		private var lvl_4:String = new String("../src/assets/levels/swf_lvl_4.swf");
		private var lvl_5:String = new String("../src/assets/levels/swf_lvl_5.swf");
		//screens & UI
		private var ui_letterBox:String = new String("../src/assets/ui/swf_letterBox.swf");
		private var ui_loadingScreen:String = new String("../src/assets/ui/swf_loadingScreen.swf");
		private var ui_levelComplete:String = new String("../src/assets/ui/swf_levelComplete.swf");
		private var ui_gameOver:String = new String("../src/assets/ui/swf_gameOver.swf");
		private var ui_levelFailed:String = new String("../src/assets/ui/swf_levelFailed.swf");
		private var ui_lives:String = new String("../src/assets/ui/swf_lives.swf");
		private var ui_start:String = new String("../src/assets/ui/swf_start.swf");
		private var ui_continueCode:String = new String("../src/assets/ui/swf_continueCode.swf");
		private var swf_cutScene_1:String = new String("../src/assets/cutScenes/swf_cutScene_1.swf");
		private var swf_cutScene_2:String = new String("../src/assets/cutScenes/swf_cutScene_2.swf");
		private var swf_cutScene_3:String = new String("../src/assets/cutScenes/swf_cutScene_3.swf");
		private var swf_cutScene_4:String = new String("../src/assets/cutScenes/swf_cutScene_4.swf");
		private var swf_cutScene_5:String = new String("../src/assets/cutScenes/swf_cutScene_5.swf");
		private var swf_cutScene_intro:String = new String("../src/assets/cutScenes/swf_cutScene_intro.swf");
		
		private var swf_cutScene_level_1_mid:String = new String("../src/assets/cutScenes/swf_cutScene_level_1_mid.swf");
		//private var swf_cutScene_level_2_mid:String = new String("../src/assets/cutScenes/swf_cutScene_level_2_mid.swf");
		
		
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
		public function SwfParser(singletonEnforcer:SingletonEnforcer):void{
			Security.allowDomain("*");//doing this is real bad, needs to get fixed later
		}
		
		public static function getInstance():SwfParser {
			
			if(SwfParser._instance == null){
				SwfParser._instance = new SwfParser(new SingletonEnforcer());
			}
			return _instance;
		}
		//aka wizard shit, don't make no kind of logical sense
		private function alignmentOfParentChildGraphics(par:MovieClip, ch:MovieClip):void {
			//trace("GraphicsElelement: alignmentOfParentChildGraphics: par:",par,", ch:",ch);
			//trace("-");
			
			//ch.parent.removeChild(ch);
			if (par is Wall) {
				
				/*par.x = ch.x;
				par.y = ch.y;
				ch.x = 0;
				ch.y = 0;*/
			
			}
			if (par is Avatar) {
				//par.addChild(ch);
				//par.setAttackHitbox(ch.hitbox_attack);
			}
			
			if (par is Bullet) {
				
			}else {
				//par.setUp();
			}
			
			if (currentParent is SelectableActor) {
				currentParent.addClickability_onLoadComplete(par);
			}
		}
		
		//sort out nodes, put them into new array in sequence based on their number
		private function sortNodes(actor:Actor, objectToSort:MovieClip):Array {
			var nodeArray:Array = new Array;
			for (var n:int = 0; n < objectToSort.numChildren; n++) {
				var myString:String = "";
				
				myString = String(objectToSort.getChildAt(n).name);
				if (objectToSort.getChildAt(n).name.indexOf("node_") != -1) {	
					var index:int = 0;
					index = int(objectToSort.getChildAt(n).name.charAt(5));
					nodeArray.splice(index, 0, objectToSort.getChildAt(n));
					//trace("parsing nodes: index",index);
				}
			}
			//Goddam fucking voodoo. There is no reason this should need to be a seperate loop. WTF why doesn't it work the other way?!?!
			for (var m:int = 0; m < objectToSort.numChildren; m++) {
				if (objectToSort.getChildAt(m).name == "art") {
					actor.attachAdditionalArt(objectToSort.art);
				}
			}
			
			
			actor.defineNodes(nodeArray);
			return nodeArray;
		}
		
		//objects in the graphic's swf can be accessed through: assignedGraphics[0].swf_child
		//i.e, if you want access to the movieclips hitbox use: assignedGraphics[0].swf_child.hitbox
		public function assignGraphic(graphic:DisplayObject):void {
			assignedGraphics.push(graphic);
			if (isLevel == true) {
				childrenToLoad = assignedGraphics[0].swf_child.numChildren;
				for (var i:int = 0; i < assignedGraphics[0].swf_child.numChildren; i++) {
					tempArray.push(assignedGraphics[0].swf_child.getChildAt(i));
				}
				for (var j:int = 0; j < tempArray.length; j++) {
					
					switch(tempArray[j].name) {
						case "art":
							//childrenToLoad--;//because its not really going to get loaded
							var art:Art = new Art(tempArray[j].x, tempArray[j].y, tempArray[j],0);
							//art.visible = false;
							break;
						case "art_1":
							var art_1:Art = new Art(tempArray[j].x, tempArray[j].y, tempArray[j], 1);
							break;
						case "art_2":
							var art_2:Art = new Art(tempArray[j].x, tempArray[j].y, tempArray[j],2);
							break;
						case "wall":
							var wall:Wall = new Wall(tempArray[j].x,tempArray[j].y,tempArray[j].width,tempArray[j].height, "standard");
							break;
						case "platform":
							var platform:Wall = new Wall(tempArray[j].x,tempArray[j].y,tempArray[j].width,tempArray[j].height, "platform");
							break;
						case "movingWall":
							var movingWall:MovingWall = new MovingWall(tempArray[j].x,tempArray[j].y,tempArray[j].width,tempArray[j].height, "movingWall");
							sortNodes(movingWall, tempArray[j]);
							break;
						case "triggerEndZone":
							var trigger_EndZone:Trigger_EndZone = new Trigger_EndZone(tempArray[j].x, tempArray[j].y, tempArray[j].width, tempArray[j].height);
							break;
						case "triggerCameraLock":
							var trigger_CameraLock:Trigger_CameraLock = new Trigger_CameraLock(tempArray[j].x, tempArray[j].y, tempArray[j].width, tempArray[j].height);
							break;
						case "triggerActivateBoss":
							var trigger_ActivateBoss:Trigger_ActivateBoss = new Trigger_ActivateBoss(tempArray[j].x, tempArray[j].y, tempArray[j].width, tempArray[j].height);
							break;
						case "triggerEngineCutScene":
							var trigger_EngineCutScene:Trigger_EngineCutScene = new Trigger_EngineCutScene(tempArray[j].x,tempArray[j].y,tempArray[j].width,tempArray[j].height);
							trigger_EngineCutScene.x = tempArray[j].x;
							trigger_EngineCutScene.y = tempArray[j].y;
							//wall.setType("standard");
							break;
						case "avatar":
							var avatar:Avatar = new Avatar(tempArray[j].x, tempArray[j].y);
							break;
						case "coin":
							var coin:Coin = new Coin(tempArray[j].x,tempArray[j].y);
							break;
						case "savePoint":
							var savePoint:SavePoint = new SavePoint(tempArray[j].x,tempArray[j].y);
							break;
						case "gem":
							var gem:Gem = new Gem(tempArray[j].x,tempArray[j].y);
							break;
						case "goon":
							var goon:GoonEnemy = new GoonEnemy(tempArray[j].x,tempArray[j].y);
							break;
						case "tank":
							var tank:TankEnemy = new TankEnemy(tempArray[j].x,tempArray[j].y);
							break;
						case "boss":
						//	var boss:BossEnemy = new BossEnemy(tempArray[j].x,tempArray[j].y);
							break;
						case "spider":
							var spider:SpiderEnemy = new SpiderEnemy(tempArray[j].x,tempArray[j].y);
							break;
						case "afs":
							var afs:AFSEnemy = new AFSEnemy(tempArray[j].x,tempArray[j].y);
							break;
						case "p_shoot":
							var shootPowerup:Powerup_shoot = new Powerup_shoot(tempArray[j].x,tempArray[j].y);
							break;
						case "p_doubleJump":
							var doubleJumpPowerup:Powerup_doubleJump = new Powerup_doubleJump(tempArray[j].x,tempArray[j].y);
							break;
						case "p_inv":
							var invinviblePowerup:Powerup_invincible = new Powerup_invincible(tempArray[j].x,tempArray[j].y);
							break;
					}
					if (tempArray[j].name.indexOf("triggerCutScene_") != -1) {
						var cutSceneName:String = tempArray[j].name;
						//trace(cutSceneName.slice(17, cutSceneName.length)); // output: !!!
						//get the name after the "cutScene_Trigger_" part
						cutSceneName = cutSceneName.slice(16, cutSceneName.length);
						var trigger_CutScene_Index:int = tempArray[j].name.charAt(17);
						//trace("triggerIndex",triggerIndex);
						var trigger_CutScene:Trigger_CutScene = new Trigger_CutScene(tempArray[j].x,tempArray[j].y,tempArray[j].width,tempArray[j].height,cutSceneName);
						trigger_CutScene.x = tempArray[j].x;
						trigger_CutScene.y = tempArray[j].y;
						//wall.setType("standard");
					}
					if (tempArray[j].name.indexOf("trigger_") != -1) {
						var trigger_Index:int = tempArray[j].name.charAt(8);
						//trace("triggerIndex",triggerIndex);
						var trigger:Trigger = new Trigger(tempArray[j].x,tempArray[j].y,tempArray[j].width,tempArray[j].height,trigger_Index);
						trigger.x = tempArray[j].x;
						trigger.y = tempArray[j].y;
						
					}
					if (tempArray[j].name.indexOf("triggeredWall_") != -1) {
						var triggeredWallIndex:int = tempArray[j].name.charAt(14);
						var triggeredWall:MovingWall = new MovingWall(tempArray[j].x,tempArray[j].y,tempArray[j].width,tempArray[j].height,"triggeredWall",triggeredWallIndex);
						sortNodes(triggeredWall, tempArray[j]);
					}
				}
			}else{
				currentParent.addChild(graphic);
				currentParent.assignedGraphic.push(graphic);
				isGraphicLoaded = true;
			}
			if (currentParent is SelectableActor) {
				currentParent.addClickability_onLoadComplete(graphic);
				currentParent.addClickability_onLoadComplete(currentParent);
			}
			if (currentParent is CutScene) {
			}
			currentParent.setIsSwfLoaded(true);
			assignedGraphics = [];
			tempArray = [];
		}
		
		public function incrementChildrenLoaded():void {
			childrenLoaded++;
			//trace("childrenToLoad",childrenToLoad);
			//trace("childrenLoaded",childrenLoaded);
			if (childrenLoaded == childrenToLoad) {
				childrenToLoad = 0;
				childrenLoaded = 0;
				Game.setGameState("levelFullyLoaded");
				print("level FUllY Loaded");
			}
		}
		
		public function getChildrenLoaded():int {
			return childrenLoaded;
		}
		
		public function getiIsGraphicLoaded():Boolean {
			return isGraphicLoaded;
		}
		
		//loads a swf based on the filePath from the actor type
		
		
		public function loadLevelSwf(filePath:String, swfParent:MovieClip):void {
			currentParent = swfParent;
			//trace("currentParent",currentParent);
			//trace("loadLevelSwf: level: filePath:",filePath);
			isLevel = true;
			switch(filePath) {
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
			}
			Main.getBulkLoader().beginLoad(this, filePath);
			//var loader:swfLoader = new swfLoader();
			//loader.beginLoad(this, filePath);
			//loader = null;
		}
		
		
		public function loadScreenSwf(filePath:String, swfParent:MovieClip):void {
			//trace("GraphicsElelement: filePath: loadLevelSwf:",filePath,"swfParent:",swfParent);
			//trace("cutScene: filePath:",filePath);
			currentParent = swfParent;
			//trace("currentParent",currentParent);
			isLevel = false;
			
			//trace("filePath", filePath);
			switch(filePath) {
				case "ui_start":
					filePath = ui_start;
					break;
				case "ui_continueCode":
					filePath = ui_continueCode;
					break;
				case "ui_loadingScreen":
					filePath = ui_loadingScreen;
					break;
				case "ui_levelComplete":
					filePath = ui_levelComplete;
					break;
				case "ui_levelFailed":
					filePath = ui_levelFailed;
					break;
				case "ui_gameOver":
					filePath = ui_gameOver;
					break;
				case "ui_lives":
					filePath = ui_lives;
					break;
				case "ui_letterBox":
					filePath = ui_letterBox;
					break;
				case "swf_cutScene_intro":
					filePath = swf_cutScene_intro;
					break;
				case "swf_cutScene_1":
					filePath = swf_cutScene_1;
					break;
				case "swf_cutScene_2":
					filePath = swf_cutScene_2;
					break;
				case "swf_cutScene_3":
					filePath = swf_cutScene_3;
					break;
				case "swf_cutScene_4":
					filePath = swf_cutScene_4;
					break;
				case "swf_cutScene_5":
					filePath = swf_cutScene_5;
					break;
				case "swf_cutScene_level_1_mid":
					filePath = swf_cutScene_level_1_mid;
					break;
			}
			//var loader:swfLoader = new swfLoader();
			//trace("Main.getBulkLoader().beginLoad(swfParent, filePath);");
			//trace("Main.getBulkLoader()",Main.getBulkLoader());
			//trace("swfParent",swfParent);
			//trace("filePath",filePath);
			Main.getBulkLoader().beginLoad(swfParent, filePath);
			//loader.beginLoad(swfParent, filePath);
			//loader = null;
			
			
		}
		
		//format for using movieclips from a MAIN project FLA library
		//used only for quick testing or other nonsense
		public function drawGraphicFromMainFLA():void{
			var newGraphic:utilities.GraphicsElements.Test_rect = new utilities.GraphicsElements.Test_rect();
			this.addChild(newGraphic);
		}
		
		//draws a default graphic, just so the game doesn't crash if I haven't made graphics for an object yet
		
		//wall
	}
}
class SingletonEnforcer{}