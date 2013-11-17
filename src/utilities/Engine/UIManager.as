package utilities.Engine{
	import utilities.Screens.GameScreens.GameOver;
	import utilities.Screens.GameScreens.LevelComplete;
	import utilities.Screens.GameScreens.LevelFailed;
	import utilities.Screens.GameScreens.Lives;
	import utilities.Screens.GameScreens.LoadingScreen;
	import utilities.Screens.xpBarSystem;
	import utilities.Screens.Screen_Default;
	import utilities.Screens.UIContainer;
	import utilities.Screens.GameScreens.ScreenStart;
	import utilities.Engine.DefaultManager;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class UIManager {
		public static var uiContainer:MovieClip = new utilities.Screens.UIContainer();
		private var padding:int=11;
		private var screen_LevelUp:MovieClip;
		private static var screen_LevelComplete:MovieClip;
		private static var screen_LoadingScreen:MovieClip;
		private static var screen_LevelFailed:MovieClip;
		private static var screen_GameOver:MovieClip;
		private static var screen_Lives:MovieClip;
		
		private static var screen_Start:MovieClip;
		private static var _instance:UIManager;
		
		public function UIManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public static function getInstance():UIManager {
			if(UIManager._instance == null){
				UIManager._instance = new UIManager(new SingletonEnforcer());
				//setUp();
			}
			return _instance;
		}
		
		public function setUp():void {
			Main.theStage.addChild(uiContainer);	
		}
		
		public function getUIContainer():Object{
			return uiContainer;
		}
		
		public static function openStartScreen():void{
			screen_Start = new ScreenStart();
			//trace("start");
		}
		
		public function openLoadingScreen():void {
			screen_LoadingScreen = new LoadingScreen();
			trace("UIManager: opening loading screen",screen_LoadingScreen);
		}
		
		public function closeLoadingScreen():void {
			trace("closing loading screen",screen_LoadingScreen);
			screen_LoadingScreen.removeThisScreen();
			//trace("start");
		}
		
		public function openLevelCompleteScreen():void{
			screen_LevelComplete = new LevelComplete();
			//trace("start");
		}
		
		public function openLevelFailedScreen():void{
			screen_LevelFailed = new LevelFailed();
			//trace("start");
		}
		
		public function openGameOverScreen():void{
			screen_GameOver = new GameOver();
			//trace("start");
		}
		
		public function openLivesScreen():void{
			screen_Lives = new Lives();
			//trace("start");
		}
		
		public function removeLivesScreen():void{
			screen_Lives.removeThisScreen();
			//trace("start");
		}
		
		/*
		private function setUpXpBar(){
			xpBar.x = uiContainer.width - xpBar.width - (1.25*padding) - screen_ReturnToBase.width;//locate it in the upper right hand corner
			xpBar.y = padding;
			xpBar.inner_bar.width=0;
			xpBar.inner_bar.scaleX = xpBarSystem.get_percent_xp_to_level()
			xpBar.txt_xp.text = xpBarSystem.get_CurrentXP() + " / " + xpBarSystem.get_Next_Levels_Required_XP();
			uiContainer.addChild(xpBar);
			//update_xpBar();
		}
		*/
		public function update_xpBar():void{
			
		}
		
		public static function updateLoop():void{
			/*xpBar.txt_xp.text = xpBarSystem.get_CurrentXP() + " / " + xpBarSystem.get_Next_Levels_Required_XP();//update the text display
			//xpBar.inner_bar.scaleX = xpBarSystem.get_percent_xp_to_level();//update the xp bar graphic
			
			if(xpBar.inner_bar.scaleX < xpBarSystem.get_percent_xp_to_level()){//if the bar is less, animate it up
				//xpBar.inner_bar.scaleX += .05;
				xpBar.inner_bar.scaleX = xpBarSystem.get_percent_xp_to_level();
			}
			if(xpBar.inner_bar.scaleX >= xpBarSystem.get_percent_xp_to_level()){//if the bar is more, stop it and match the percent
				xpBar.inner_bar.scaleX = xpBarSystem.get_percent_xp_to_level();
			}
			if(xpBarSystem.check_For_Level_Up()==true){
				showLevelUpScreen();
			}*/
		}
		
		
		
		//move all the screen stuff into here later
		/*private function showLevelUpScreen(){
			screen_LevelUp = new Screen_LevelUp;
			uiContainer.addChild(screen_LevelUp);
			screen_LevelUp.x = 100;
			screen_LevelUp.y = 50;
			trace(screen_LevelUp);
			screen_LevelUp.btn_next.addEventListener(MouseEvent.CLICK, closeLevelUpScreen);
			Main.pauseGame();
			trace("show level up screen focus before click: ",Main.game.focus)
			
		}*/
		
		/*private function closeLevelUpScreen(Event:MouseEvent){
			screen_LevelUp.btn_next.removeEventListener(MouseEvent.CLICK, closeLevelUpScreen);
			uiContainer.removeChild(screen_LevelUp);
			Main.resumeGame();
			trace("show level up screen focus post click: ",Main.theStage.focus);
			//Main.game.focus = null;
			Main.returnFocusToGampelay();
		}*/
		
		/*
		public function showReturnToBase(){
			uiContainer.addChild(screen_ReturnToBase);
			screen_ReturnToBase.x = uiContainer.width - screen_ReturnToBase.width - padding;//locate it in the upper right hand corner
			screen_ReturnToBase.y = padding;
			trace(screen_ReturnToBase);
			screen_ReturnToBase.addEventListener(MouseEvent.CLICK, removeReturnToBase);
		}
		
		public function removeReturnToBase(Event:MouseEvent){
			
			trace("function runs");
			//stop all game functions
			Main.pauseGame();
			//remove return to base button
			screen_ReturnToBase.btn_next.removeEventListener(MouseEvent.CLICK, removeReturnToBase);
			uiContainer.removeChild(screen_ReturnToBase);
			//return to base
		}*/
	}
}
class SingletonEnforcer{}