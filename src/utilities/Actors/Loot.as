package utilities.Actors{
	import utilities.dataModels.LevelProgressModel;
	import utilities.dataModels.ResourceModel;
	import utilities.Engine.UIManager;
	public class Loot extends Actor{
		
		private var filePath:String = "../src/assets/actors/swf_coin.swf";
		private var moneyValue:int = 50;
		public function Loot(){
			
		}
		
		public function updateLoop():void{
			//setQuadTreeNode();
			//applyVector();
			//doStuffToEnemyOverTime();
			//checkForDamage();
			//checkForDeathFlag();
			//setPreviousPosition();
		}
		
		public override function onTakeDamage():void {
			ResourceModel.getInstance().addCoins(getMoneyValue());
			UIManager.getInstance().getLivesScreen().updateScreenDisplay();
		}
		
		public function getMoneyValue():int {
			return moneyValue;
		}
		
		public function setMoneyValue(newMoneyValue:int):void {
			moneyValue = newMoneyValue;
		}
	}
}