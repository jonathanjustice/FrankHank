package utilities{
	public class RenderManager extends MovieClip{
		public function RenderManager(){
			
		}
		
		public function setUp():void{
			
		}
		//testing working with bitmapdata
		public function getBitmapData(){
			//if the game already has some fun bitmap data, erase that business
			if (bmd){
				bmd = null;
			}
			//target.width and target.height can also be replaced with a fixed number.
			var bmd : BitmapData = new BitmapData(1280, 1024,true, 0x00000000);
			
			bmd.draw( stage );
			var bm:Bitmap = new Bitmap(bmd);
			empty.addChild(bm);
			bm.x = -640;
			bm.y = -512; 
			empty.x = 640;
			empty.y = 512;
			empty.alpha =1;
		}
	}
}