package utilities.Actors.LootDrops{
	import utilities.Actors.Actor;
	public class LootDrop extends utilities.Actors.Actor{
		
		//public var lootAmount:Number=1;
		
		public function LootDrop():void{
			
		}
		
		public override function defineProperties():void{
			
		}
		
		public function updateLoop():void{
			
		}
		
		public static function setAmount(amt:int):void{
			trace("set amount");
			//trace("amount",lootAmount);
			//lootAmount = amt;
		}
		
		public function move_loot_to_target():void{
			//only do this if the math doesn't slow the game down too much
		}
		
		public function addLootToTotals():void{
			
		}
		
		public function playCollectedAnimation():void{
			
		}
		
	}
}