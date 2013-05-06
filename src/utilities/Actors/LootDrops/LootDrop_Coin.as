package utilities.Actors.LootDrops{
	import flash.display.MovieClip;
	import utilities.Actors.LootDrops.LootDrop;
	public class LootDrop_Coin extends utilities.Actors.LootDrops.LootDrop{
		private var amount:int=0;
		public function LootDrop_Coin(){
			setUp();
		}
		
		public function setUp():void{
			defineGraphics("frank",false);
		}
			
		public override function defineProperties():void{
			var newCoin:MovieClip;
			if(amount <= 5){
				//newCoin = new graphic_CoinSmall();
			}else if(amount > 5 && amount <= 25){
				//newCoin = new graphic_CoinLarge();
			}else if(amount > 5 && amount <= 100){
				//newCoin = new graphic_CoinBag();
			}else if(amount > 5 && amount <= 500){
				//newCoin = new graphic_CoinBars();
			}else if(amount > 5 && amount <= 5000){
				//newCoin = new graphic_CoinBars();
			}
			this.addChild(newCoin);
		}
	}
}