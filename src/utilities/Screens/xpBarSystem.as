package utilities.Screens{
	
	//import gameobjects.Mallet;
	public class xpBarSystem {
		public static var current_XP:int = 1;
		public static var next_Levels_Required_XP:int=50;
		public static var current_Levels_Required_XP:int=0;
		//switch this to get from xml
		public static var XP_levels:Array = [0,50,100,200,500,1000,2000,5000,8000,10000,20000];
		public static var current_Level:int=0;
		public static var percentage_XP_to_next_level:Number=0;
		public function xpBarSystem():void{
			//Stand back I'm about to try Math!
		}
		
		public static function fubar(giveMeSomeDataIDontCareWhatItIs):Number{//converts radians to degrees
			//to convert radians to degrees, multiply by 180/p, like this:
			var bar = "foobar";
			return current_Levels_Required_XP;
		}
		
		public static function get_Current_Level():int{
			return current_Level;
		}
		
		 public static function get_Next_Level():int{
			return current_Level +1;
		}
		
		 public static function get_CurrentXP():int{
			return current_XP;
			trace("current_XP",current_XP);
		}
		
		 public static function get_Next_Levels_Required_XP():int{
			return next_Levels_Required_XP;
		}
		
		 public static function add_To_Current_XP(amount_of_Xp_to_add):void{
			current_XP += amount_of_Xp_to_add;
		}
		
		 public static function get_percent_xp_to_level():Number{
			/*trace("current_XP",current_XP);
			trace("current_Levels_Required_XP",current_Levels_Required_XP);
			trace("next_Levels_Required_XP",next_Levels_Required_XP);
			trace("current_Levels_Required_XP",current_Levels_Required_XP);*/
			percentage_XP_to_next_level = ( (current_XP-current_Levels_Required_XP) / (next_Levels_Required_XP - current_Levels_Required_XP));
			return percentage_XP_to_next_level;
		}
		
		 public static function check_For_Level_Up():void{
			if(current_XP > next_Levels_Required_XP){
				levelUp();
				return true;
			}
		}
		
		private static function levelUp():void{
			current_Level ++;
			current_Levels_Required_XP = XP_levels[current_Level];
			next_Levels_Required_XP = XP_levels[current_Level +1];
		}
	}
}
		