package utilities.Actors{
	//import utilities.Actor;
	import flash.display.MovieClip;
	import flash.events.*;
	import utilities.Actors.LootDrops.LootDrop;
	public class TreasureChest extends utilities.Actors.Actor{
		private var isOpen:Boolean=false;
		private var isBeingOpened:Boolean=false;
		private var openProgress:int=0;
		private var progressMax:int=100;
		private var chestGraphic:MovieClip=new MovieClip();
		private var chestType:String = "Basic";
		public function TreasureChest(){
			defineGraphics("frank",false);
		}
		
		public function updateLoop():void{
			if(isBeingOpened){
				openProgress+=10;
				//trace("openProgress:",openProgress);
				updateProgressBarGraphic(openProgress);
				if(openProgress >= progressMax){
					isBeingOpened = false;
					isOpen = true;
					updateDisplayState();
					openChest();
					setProgressBarVisibility(false);
				}
			}
		}
		
		public function BeginOpeningChest():void{
			if(!isOpen && openProgress < 1){
				isBeingOpened = true;
				setProgressBarVisibility(true);
				updateDisplayState();
			}
		}
		
		public function openChest():void{
			trace("TreasureChest: openChest");
			send_Loot_Data_To_Factory();//function inherited from Actor
		}
		
		public function abortOpeningChest():void{
			isBeingOpened = false;
			openProgress =0;
			setProgressBarVisibility(false);
			updateDisplayState();
		}
		
		public override function defineProperties():void{
			addChestGraphic("Basic");
		}
		
		public function addChestGraphic(type:String):void{
			//trace("new chest");
			chestType = type;
		/*	if(chestType == "Basic"){
				//chestGraphic = new Chest_Basic();
				this.addChild(chestGraphic);
				createProgressBar("Basic");
				setProgressBarVisibility(false);
			}*/
		}
		
		//display states of chest, open, not open, being opened
		public function updateDisplayState():void{
		/*	if(isOpen){
				chestGraphic.gotoAndStop("open");
			}else if(!isOpen){
				chestGraphic.gotoAndStop("closed");
			}else if(isBeingOpened){
				//chestGraphic.gotoAndStop("opening");
			}*/
		}
	}
}