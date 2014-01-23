package utilities.Engine.Builders{
	import flash.display.MovieClip;
	import utilities.Actors.Avatar;
	import utilities.Actors.TreasureChest;
	import utilities.Actors.LootDrops.LootDrop;
	import utilities.Engine.Combat.AvatarManager;
	import utilities.Engine.IManager;
	import utilities.Input.KeyInputManager;
	import utilities.Engine.DefaultManager;
	import utilities.Engine.Game;
	import utilities.Engine.BasicManager;
	import utilities.Actors.LootDrops.*;
	import utilities.Actors.LootDrops.LootDrop_Coin;
	import utilities.Actors.LootDrops.LootDrop_Premium;
	import utilities.Actors.LootDrops.LootDrop_Card;
	import utilities.Actors.LootDrops.LootDrop_Bomb;
	import utilities.Actors.LootDrops.LootDrop_DNA;
	
	//import lootDrops.PowerUp;
	//import lootDrops.CardBoost;
	//import lootDrops.Health;
	
	public class LootManager extends BasicManager {
		public static var lootDrops:Array;
		public static var treasureChests:Array;
		public static var lootFactory:Factory_Loot = new Factory_Loot();
		private static var _instance:LootManager;
		
		public function LootManager(singletonEnforcer:SingletonEnforcer){
			//trace("loot manager");
			setUp();
		}
		
		public static function getInstance():LootManager {
			if(LootManager._instance == null){
				LootManager._instance = new LootManager(new SingletonEnforcer());
				
			}
			return _instance;
		}
	
		
		public function setUp():void{
			treasureChests = [];
			lootDrops = [];
			//createNewTreasureChest(200,300);
		}
		
		public static function updateLoop():void{
			updateLootDrops();
			updateTreasureChests();
		}
		
		//determine if the avatar is touching the loot
		private static function updateLootDrops():void{
			for each(var lootDrop:LootDrop in lootDrops){
				lootDrop.move_loot_to_target();
				check_For_Collision_With_Avatar(lootDrop);
				lootDrop.checkForDeathFlag();
			}
		}
		
		//if the avatar is close enough and pressing the activate key then open the chest
		private static function updateTreasureChests():void{
			for each(var chest:TreasureChest in treasureChests){
				chest.updateLoop();//controls opening progress & states
				if(chest.hitTestObject(AvatarManager.getAvatar())){
					chest.setHighlightState(true);
					if(Main.keyInputManager.getSpace()){
						chest.BeginOpeningChest();
					}
				}else{
					chest.setHighlightState(false);
					chest.abortOpeningChest();
				}
			}
		}
		
		public static function check_For_Collision_With_Avatar(lootDrop:MovieClip):void{
			if(lootDrop.hitTestObject(Main.game.avatar)){
				lootDrop.addLootToTotals();
				lootDrop.markDeathFlag();
			}
		}
		
		//create a new loot drop, spawn it at the actor, usually an enemy or chest
		public function createNewLootDrop(spawnX:Number,spawnY:Number,type:String,amt:Number):void{
			var amount:int = amt;
			var loot:MovieClip;
			trace("------------------------------loot type is:",type);
			switch(type){
				case "coin":
					loot = new LootDrop_Coin();
					break;
				case "premium":
					loot = new LootDrop_Premium();
					break;
				case "bomb":
					loot = new LootDrop_Bomb();
					break;
				case "DNA":
					loot = new LootDrop_DNA();
					break;
				case "card":
					loot = new LootDrop_Card();
					break;
					/*
				case "powerup":
					loot = new Powerup();
					break;
				case "health":
					loot = new Health();
					break;
				case "cardBoost":
					loot = new CardBoost();
					break;
					*/
			}
			
			//loot.setAmount(amount);
			//give the loot properties based on loot drop tables
			loot.defineProperties();
			loot.x = spawnX;
			loot.y = spawnY;
			lootDrops.push(loot);
			//place the new bullet into the game
			Main.game.gameContainer.addChild(loot);
			//trace("create new loot");
			
		}
		
		//delete the loot
		public static function deleteLoot(loot:MovieClip):void{
			var index:int = lootDrops.indexOf(loot);
			lootDrops.splice(index,1);
			Main.game.gameContainer.removeChild(loot);
		}
		
		//delete the treasure chest
		public static function deleteTreasureChest(chest:MovieClip):void{
			var index:int = treasureChests.indexOf(chest);
			treasureChests.splice(index,1);
			Main.game.gameContainer.removeChild(chest);
		}
		
		//create a new treasure chest
		public function createNewTreasureChest(locationX:Number,locationY:Number):void{
			//trace("Loot Manager:create new chest")
			var chest:MovieClip = new TreasureChest();
			//give the bullet properties based on loot drop tables
			chest.defineProperties();
			chest.x = locationX;
			chest.y = locationY;
			//trace("chest:",chest);
			//trace("treasureChests:",treasureChests);
			treasureChests.push(chest);
			//Main.game.gameContainer.addChild(chest);
			chest.addActorToGameEngine();
		}
		
		public function getLootDropArray():Array{
			return lootDrops;
		}
		
		public function getTreasureChestArray():Array{
			return lootDrops;
		}
	}
}
/*
	cardBoost
	health
	powerup
	card
	DNA
	bomb
	premium
	coin
*/
class SingletonEnforcer{}