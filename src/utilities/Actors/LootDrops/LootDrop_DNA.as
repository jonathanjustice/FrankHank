package utilities.Actors.LootDrops{
	import utilities.Actors.LootDrops.LootDrop;
	public class LootDrop_DNA extends utilities.Actors.LootDrops.LootDrop{
		private var amount:int=0;
		public function LootDrop_DNA(){
			setUp();
		}
		
		public function setUp():void{
			defineGraphics("frank",false);
		}
			
		public override function defineProperties():void{
			//var newDNA = new graphics_DNA();
			//this.addChild(newDNA);
		}
	}
}