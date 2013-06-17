﻿package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	import utilities.Engine.LevelManager;
	import flash.display.DisplayObject;
	public class SavePoint extends Actor{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var isActive:Boolean = true;
		
		//private var lifeSpan:Number = 2;//3 seconds
		
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "../src/assets/actors/swf_savePoint.swf";
		public function SavePoint(newX:int, newY:int) {
			health = 1;
			this.x = newX,
			this.y = newY;
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			
			alignmentOfParentChildGraphics(this,graphic);
			LevelManager.savePoints.push(this);
			print(String(this.x));
			print(String(this.y));
			print(String(graphic.x));
			print(String(graphic.y));
			print(String(graphic.parent));
			assignedGraphic[0] = graphic;
			setIsSwfLoaded(true);
		}
		
		public function getIsActive():Boolean {
			return isActive;
		}
		
		public function setIsActive(activeState:Boolean):void {
			isActive = activeState;
		}
		
		public function setUp():void {
			print("setUp");
			
			addActorToGameEngine();
			setPreviousPosition();
			defineGraphics("savePoint",false);
		}
		
		public function updateLoop():void{
			//setQuadTreeNode();
			//applyVector();
			//doStuffToEnemyOverTime();
			//checkForDamage();
			//checkForDeathFlag();
			//setPreviousPosition();
		}
	
		
		public function collidedWithAvatar():void {
			
		}
		
		//direction indicator is useful for determine what direction the enemy is faceing / moving in / shooting in
		//make it invisible if its not being used
		//it's commented out because it't not part of the default graphic anymore
		/*private function set_direction_indicator_visibility(){
			directionIndiactor.visible = false;
		}
		*/
		
		//this records the moment the bullet was created
		public function setSpawnTime():void {
         	spawnTime = getTimer();
			//trace("spawnTime",spawnTime);
        }
		/*
		public function takeDamage(amount:int):void{
			health -= amount;
		}
		*/
		public function markKillWithXpFlag():void{
			markDeathFlag();
			applyXP = true;
		}
		
		public function markDeathWithoutXpFlag():void{
			markDeathFlag();
			applyXP = false;
		}
		
		public function get_apply_XP_flag():Boolean{
			return applyXP;
		}
		
		public function get_xpToApply():int{
			return xpToApply;
		}
		
		
	}
}