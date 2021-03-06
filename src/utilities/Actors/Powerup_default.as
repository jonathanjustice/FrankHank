﻿package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import flash.utils.getTimer;
	import utilities.Engine.Combat.PowerupManager;
	import flash.display.DisplayObject;
	public class Powerup_default extends Actor{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
	//	private var xVelocity:Number=5;//velocity
	//	private var yVelocity:Number=0;
		private var isGravitySystemEnabled:Boolean = true;
		public var powerupType:String = "default";
		
		//private var availableForTargeting:Boolean=true;
		
		
		private var filePath:String = "";
		public function Powerup_default() {
			setUp();
			
		}
		
		public function assignGraphic(graphic:DisplayObject):void {
			addActorToGameEngine(graphic,PowerupManager.powerups);
		}
		
		public override function getFilePath():String {
			return filePath;
		}
		
		public function setUp():void {
			health = 1;
			powerupType = "default";
			defineGraphics("powerup_default", false);
			
		
		}
		
		public function getPowerupType():String {
			return powerupType;
		}
		
		public function updateLoop():void {
		
		}
	}
}