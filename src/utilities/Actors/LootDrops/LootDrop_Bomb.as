package utilities.Actors.LootDrops{
	import utilities.Actors.LootDrops.LootDrop;
	public class LootDrop_Bomb extends utilities.Actors.LootDrops.LootDrop{
		private var amount:int=0;
		public function LootDrop_Bomb(){
			setUp();
		}
		
		public function setUp():void{
			defineGraphics("frank",false);
		}
			
		/*public function defineProperties(){
			//var newBomb = new graphics_Bomb();
			//this.addChild(newBomb);
		}*/
	}
}