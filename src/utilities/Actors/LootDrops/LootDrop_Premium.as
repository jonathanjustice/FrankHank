package utilities.Actors.LootDrops{
	import utilities.Actors.LootDrops.LootDrop;
	public class LootDrop_Premium extends utilities.Actors.LootDrops.LootDrop{
		private var amount:int=0;
		public function LootDrop_Premium(){
			setUp();
		}
		
		public function setUp():void{
			defineGraphics("frank",false);
		}
			
		public override function defineProperties():void{
			//var newPremium = new graphics_Premium();
			//this.addChild(newPremium);
		}
	}
}