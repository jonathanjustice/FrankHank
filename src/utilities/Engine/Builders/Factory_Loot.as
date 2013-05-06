package utilities.Engine.Builders{
	import utilities.Engine.Builders.LootManager;
	public class Factory_Loot{
		import flash.geom.Point;
		private var spawnPoint:Point=new Point();
		private var maxCoins:int = 5;
		private var minCoins:int=1;
		
		private var maxDNA:int = 5;
		private var minDNA:int=1;
		private var maxPremiumCoins:int = 5;
		
		private var newX:Number=0;
		private var newY:Number=0;
		private var amount:Number=1;
		public function Factory_Loot(){
			
		}
		
		public function generateLoot(spawnX:Number,spawnY:Number):void{
			
			setSpawnLocatoin();
			
			spawnPoint.x = spawnX; spawnPoint.y = spawnY;
			//roll for each of the following loot types
			coinDrops(maxCoins,minCoins);
			premiumCoinDrops();
			bombDrops();
			dnaDrops(maxDNA,minDNA);
			cardDrops();
			
			//Not implemented yet
			/*
			powerupDrops();
			cardBoostDrops();
			healthDrops();
			*/
		}
		
		private function cardBoostDrops():void{
			var dropChance:Number = Math.abs(Math.random()*100);
			//trace("cardBoost");
			if(dropChance >= 0){
				amount = 1;
				//Main.game.lootManager.createNewLootDrop(newX,newY,"cardBoost",amount);
			}
		}
		
		private function healthDrops():void{
			var dropChance:Number = Math.abs(Math.random()*100);
			//trace("health");
			if(dropChance >= 0){
				amount = 1;
				//Main.game.lootManager.createNewLootDrop(newX,newY,"health",amount);
			}
		}
		
		private function powerupDrops():void{
			var dropChance:Number = Math.abs(Math.random()*100);
			//trace("powerup");
			if(dropChance >= 0){
				//pick_powerup_from_available_powerups();
				amount = 1;
				//Main.game.lootManager.createNewLootDrop(newX,newY,"powerup",amount);
			}
		}
		
		private function cardDrops():void{
			var dropChance:Number = Math.abs(Math.random()*100);
			trace("Factory_Loot: cardDrops: card");
			if(dropChance >= 0){
				//pick_card_from_available_cards();
				amount = 1;
				//Main.game.lootManager.createNewLootDrop(newX,newY,"card",amount);
			}
		}
		
		private function dnaDrops(maxDNA:int,minDNA:int):void{
			//trace("DNA");
			var number_of_drops:Number = minDNA + Math.abs(Math.random()*maxDNA);
			for(var i:int=0;i < number_of_drops; i++){
				amount = 1;
				//Main.game.lootManager.createNewLootDrop(newX,newY,"DNA",amount);
			}
		}
		
		private function bombDrops():void{
			//trace("BOMB");
			var dropChance:Number = Math.abs(Math.random()*100);
			if(dropChance >= 0){
				amount = 1;
				//Main.game.lootManager.createNewLootDrop(newX,newY,"bomb",amount);
			}
		}
		
		private function coinDrops(maxCoins:int,minCoins:int):void{
			//trace("coin");
			var number_of_drops:Number = minCoins + Math.abs(Math.random()*maxCoins);
			for(var i:int=0;i < number_of_drops; i++){
				var type:Number = Math.abs(Math.random() *100);
				amount = 1;
				//Main.game.lootManager.createNewLootDrop(newX,newY,"coin",amount);
			}
		}
		
		private function premiumCoinDrops():void{
			//trace("premium");
			var dropChance:Number = Math.abs(Math.random()*100);
			if(dropChance >= 0){
				var number_of_drops:Number = Math.abs(Math.random()*maxPremiumCoins);
				for(var i:int=0;i < number_of_drops; i++){
				amount = 1;
					//Main.game.lootManager.createNewLootDrop(newX,newY,"premium",amount);
				}
			}
		}
		
		private function setSpawnLocatoin():void{
			newX = spawnPoint.x + (100 - Math.random() *200);
			newY = spawnPoint.y + (100 - Math.random() *200);
		}
	}
}