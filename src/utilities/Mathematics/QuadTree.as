package utilities.Mathematics{
	import flash.display.MovieClip;
	public class QuadTree{
		//not exacrly a quadtree right now, but whatev's, its getting the job done
		private static var gameWidthX:int=1024;
		private static var gameWidthY:int=1024;
		private static var node_1_1:Array=[0,0,512,512];
		private static var node_1_2:Array=[512,0,512,1024];
		private static var node_2_1:Array=[0,512,512,1024];
		private static var node_2_2:Array=[512,512,512,1024];
		private static var node:int=0;
		
		public function QuadTree():void{
			
		}
		
		public static function setNode(object:MovieClip):int{
			if(object.x < 512 && object.y < 512){
				node = 1;
			}
			else if(object.x > 512 && object.y < 512){
				node = 2;
			}
			else if(object.x < 512 && object.y > 512){
				node = 3;
			}
			else if(object.x > 512 && object.y > 512){
				node = 4;
			}
			return node;
		}
	}
}