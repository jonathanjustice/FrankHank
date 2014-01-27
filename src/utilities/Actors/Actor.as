package utilities.Actors{
	//import air.update.utils.VersionUtils;
	import flash.geom.Rectangle;
	import flash.display.AVM1Movie;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import utilities.Effects.FeedbackTextField;
	import utilities.Effects.FeedbackMovieClip;
	import utilities.Screens.progressBar;
	import utilities.Engine.Game;
	import utilities.Engine.Combat.*;
	import utilities.Actors.LootDrops.*;
	import utilities.Actors.TreasureChest;
	import utilities.Engine.Builders.LootManager;
	import utilities.Actors.Stats.WeaponStats;
	import utilities.Actors.GameBoardPieces.Level;
	import utilities.Actors.GameBoardPieces.Trigger;
	import utilities.Actors.GameBoardPieces.Trigger_CutScene;
	import utilities.Actors.GameBoardPieces.Trigger_EndZone;
	import utilities.Actors.GameBoardPieces.Trigger_CameraLock;
	import utilities.Actors.GameBoardPieces.Trigger_ActivateBoss;
	import utilities.GraphicsElements.SwfParser;
	import utilities.GraphicsElements.Animation;
	import utilities.Mathematics.EasyTint;
	import utilities.Mathematics.MathFormulas;
	import utilities.Mathematics.*;
	import utilities.Mathematics.QuadTree;
	import flash.geom.Point;
	import utilities.Input.KeyInputManager;
	import utilities.Engine.Combat.AnimationManager;
	import utilities.Engine.EffectsManager;
	import utilities.Engine.LevelManager;
	import utilities.objects.GameObject;
	import utilities.Saving_And_Loading.swfLoader;
	import utilities.customEvents.*;
	public class Actor extends GameObject {
		public var directionLastFaced:String = "RIGHT";
		public var attachedArt:MovieClip = new MovieClip;
		public var hitbox:MovieClip = new MovieClip();
		public var hitzone:MovieClip = new MovieClip;
		private var nodes:Array = new Array;
		public var isGraphicLoaded:Boolean = false;
		private var isFalling:Boolean = false;
		private var idleImpatientTime:int = 0;
		private var idleTime:int = 0;
		private var maxIdleTime:int = 90;
		private var isIdle:Boolean = true;
		public var assignedGraphic:Array = new Array();
		private var markedForDeletion:Boolean=false;
		private var availableForTargeting:Boolean=true;
		private var progressBar:MovieClip;
		private var progressBarGraphic:MovieClip;
		private var highLight:MovieClip;
		private var mass:Number;
		private var previousPosition:Point = new Point(0, 0);
		private var velocity:Point = new Point(0, 0);//replace xVelocity and yVelocity with this
		private var quadTreeNode:int;
		private var weaponStats:Object;
		private var actorGraphic:MovieClip;
		private var target:MovieClip;
		private var hasTarget:Boolean = false;
		public var health:Number = 1;
		public var maximumHealth:Number = 1;
		private var gravity:Number = 2;
		private var originalGravity:Number = 0;
		private var currentGravity:Number=1;
		private var gravityModifier:Number = 2;
		private var maxGravity:Number = 2;
		private var hitBoxWidth:Number = 0;
		private var hitBoxHeight:Number = 0;
		private var isInvincible:Boolean = false;
		private var invincibilityTimer:int = 0;
		private var invincibilityFlashTimer:int = 0;
		private var invincibilityFlashMaxTime:int = 0;
		private var invincibilityMaxTime:int = 120;
		private var killsOnContact:Boolean = true;
		private var damagedInvincibilityTimer:int = 0;
		private var damagedInvincibilityMaxTime:int = 30;
		private var animationState:String = "idle"
		private var isSwfLoaded:Boolean = false;
		public var xVelocity:Number=0;//velocity
		public var yVelocity:Number = 0;
		private var knockbackVelocityX:int = -30;
		private var knockbackVelocityY:int = -10;
		private var collisionDamage:Number = 0;
		private var collisionDamageInvincible:Number = 9999;
		private var collisionDamageOriginal:Number = 0;
		private var isAvailableForCollisionWithNonWallActors:Boolean = false;
		private var isShootingEnabled:Boolean = false;
		private var isRiding:Boolean = false;
		private var ridingVelocity:Point = new Point();
		private var isGravitySystemEnabled:Boolean = true;
		private var fireProjectileDelay:int = 9999;
		private var fireProjectileTimer:int = 0;
		private var behaviorState:String = "idle"
		private var filePath:String = "";
		public var lerpTarget:Point = new Point();
		public var lerpAmount:Point = new Point();
		public var lerpMultiplier:Point = new Point();
		public var lerping:Boolean = false;
		public  var invulnerableDueToDamage:Boolean = false;
		public var bulkLoader:BulkLoaderSystem;
		
		public function Actor() {
			
			defineWeaponStats();
			setAnimationState("idle");
			//print(this);
			
		}
		
		public function setIsRiding(newState:Boolean,newRidingVelocity:Point):void {
			isRiding = newState;
			ridingVelocity = newRidingVelocity;
		}
		
		public function getIsRiding():Boolean {
			return isRiding;
		}
		
		public function getRidingVelocity():Point {
			return ridingVelocity;
		}
		
		public function attachAdditionalArt(artToAttach:MovieClip):void {
			attachedArt = artToAttach;
			this.addChild(attachedArt);
			//trace(this.assignedGraphic[0]);
			//trace(this.assignedGraphic[0].swf_child);
			//this.assignedGraphic[0].swf_child.addChild(attachedArt);
		}
		
		public function getFilePath():String {
			return filePath;
		}
		
		/*
		------------GRAVITY
					
		*/
		public function applyGravity(isGravitySystemEnabled:Boolean):int {
			if (isGravitySystemEnabled) {
				currentGravity += gravityModifier;
					//if at max gravity, do not increase velocity exponentially anymore
				if (currentGravity > maxGravity) {
					currentGravity = maxGravity
				}
					yVelocity += currentGravity;
			}
			
			return yVelocity;
		}
		
		//usually through jumping
		public function modifiyGravity(gravityModifier:Number):void {
			currentGravity = -gravityModifier;
		}
		
		public function resetGravity():void {
			currentGravity = originalGravity;
			yVelocity = currentGravity;
		}
		
		
		/*
		------------BEHAVIOR
					This needs to be put somewhere else, this is an awful place for it as long as I am using 1 giant master stats file
					might make sense once once things are more generative...
		*/
		public function defineProperties():void{
			
		}
		
		public function setBehaviorState(newState:String):void {
			behaviorState = newState;
		}
		
		public function getBehaviorState():String {
			return behaviorState;
		}
		
		public function defineWeaponStats():void{
			weaponStats = new utilities.Actors.Stats.WeaponStats();
		}
					
		public function Point_Actor_At_Target(target:Point):void{
			MathFormulas.Point_Object_At_Target(this,target);
		}
		
		public function fireProjectile():void {
			//if the key is down 
			fireProjectileTimer++;
			if (KeyInputManager.getZKey() == true) {
				//if the delay has been reached
				if (fireProjectileTimer >= fireProjectileDelay) {
					fireProjectileTimer = 0;
					//create projectile
					var bullet:Bullet = new Bullet();
				}
			}
		}
		
		
		
		
		/*
		------------CREATION, DESTRUCTION, DAMAGE & DEATH
					
		*/
					
		//creation & destruction
		//future: add ability to add things to game engine at particular orders, right now we are at the mercy of the FLA
		public function addLevelToGameEngine():void {
			utilities.Engine.Game.gameContainer.addChild(this);
		}
		
		//usually from SwfParser
		public function defineNodes(array:Array):void {
			nodes = array;
			//trace("defineNodes: this:", this, "nodes: ", nodes);
			//trace("nodes.length", nodes.length);
		}
		
		public function getNodes():Array {
			return nodes;
		}
		
		public function defineHitbox(newHitbox:MovieClip):void {
			//trace("-------------------------------------definehitbox",this);
			//trace("-------------------------------------hitbox",hitbox);
			hitbox = newHitbox as MovieClip;
			//trace("------------------------------------------------------hitbox",hitbox);
			//hitbox.visible = true;
		}
		
		public function getHitbox():MovieClip {
			return hitbox;
		}
		
		//add actor to array at 0 unless otherwise specified
		public function addActorToGameEngine(graphic:DisplayObject, array:Array, spliceIndex:int = 0):void {
			
			//spliceIndex = array.length;
			//trace("Actor: addActorToGameEngine()",this);
			assignedGraphic[0] = graphic;
			this.addChild(graphic);
			utilities.Engine.Game.gameContainer.addChild(this);
			setIsSwfLoaded(true);
			array.splice(spliceIndex, 0, this);
			try {
				if (assignedGraphic[0].swf_child.getChildByName("hitbox") == null) {
					//trace("it does not have a hitbox");
				}else {
						hitbox = this.assignedGraphic[0].swf_child.hitbox;
						this.assignedGraphic[0].swf_child.removeChild(hitbox);
						this.addChildAt(hitbox,0);
				}
			}catch (error:Error ) {
				//it does not have a hitbox
			}
			try {
				if (assignedGraphic[0].swf_child.getChildByName("hitzone") == null) {
					//trace("it does not have a hitzone");
				}else {
					//trace("it has a hitzone");
						hitzone = this.assignedGraphic[0].swf_child.hitzone;
				}
			}catch (error:Error ) {
				//it does not have a hitzone
			}
			setPreviousPosition();
		}
		
		public function removeActorFromGameEngine(actor:MovieClip, array:Array):void {
			//trace("actor",actor);
			//trace("array",array);
			actor.availableForTargeting=false;
			var index:int = array.indexOf(actor);
			array.splice(index,1);
			utilities.Engine.Game.gameContainer.removeChild(actor);
			actor.setTargetToFalse();
		}
		
		public  function setLerpTarget(newTarget:Point ):void {
			lerpTarget = newTarget;
			//trace("lerpTarget:", lerpTarget);
			//trace("this:", this.x, this.y);
		}
		
		public function getLerpTarget():Point {
			return lerpTarget;
		}
		
		public  function setLerping(newState:Boolean ):void {
			lerping = newState;
		}
		
		public function getLerping():Boolean {
			return lerping;
		}
		
		public function lerpToTarget():void {
			if (lerping) {
				//trace("lerping",lerping);
				lerpAmount.x = (this.x - lerpTarget.x) * lerpMultiplier.x;
				this.x -= lerpAmount.x;
				lerpAmount.y = (this.y - lerpTarget.y) * lerpMultiplier.y;
				this.y -= lerpAmount.y;
				//trace("lerpAmount",lerpAmount);
			}
		}
		
		
		public  function setLerpMultiplier(newXMultiplier:Number, newYMultiplier:Number):void {
			lerpMultiplier.x = newXMultiplier;
			lerpMultiplier.y = newYMultiplier;
		}
		
		public function takeDamage(amount:Number):void {
			//trace("takeDamage",this);
			if (!isInvincible) {
				this.health -= amount;
				onTakeDamage();
				checkForDamage();	
			}
		}
		
		public function onTakeDamage():void {
			//overriden by each individual class
			//used for feedback mostly
		}
		
		public function checkForDamage():void {
			//trace("checkForDamage",this);
			if (health <= 0) {
				if (this is Avatar) {
					if (Game.getLives() > 0) {
						//trace("checkForDamage levelFailed");
						Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","FRANK_DIED"));
						Game.setGameState("levelFailed");
					}else if(Game.getLives() <= 0){
						//trace("checkForDamage: gameOver");
						Game.setGameState("gameOver");
						Main.theStage.dispatchEvent(new SoundEvent("SOUND_START","SONG_GAMEOVER"));
					}
					
				}else{
					markDeathFlag();
				}
			}
		}
		
		
		public function setBounceDirection(bounceDirection:String):void {
			if (bounceDirection == "left") {
				knockbackVelocityX = -1*(Math.abs(knockbackVelocityX));
			}else if (bounceDirection == "right") {
				knockbackVelocityX = Math.abs(knockbackVelocityX);
				
			}
		}
		
		public function bounceBackward():void {
			//bounce backward based on which direction you are moving
			xVelocity = knockbackVelocityX;
			yVelocity = knockbackVelocityY;
		}
		
		//flag actor for deletion, normally on death, collision or time out
		public function markDeathFlag():void {
			markedForDeletion = true;
			availableForTargeting = false;//prevent null reference errors
		}
		
		//this is kinda bad, could be more abstract. I don't think i should have to make a billion cases for each and every item in the game
		//determine what needs to be deleted and then delete it
		//this would be a really nice place to start using Interfaces... hint hint hint
		public function checkForDeathFlag():void{
			if (markedForDeletion) {
				//trace("checkForDeathFlag",this);
				//delete it
				if(this is Bullet){
					removeActorFromGameEngine(this,BulletManager.getInstance().getArray());
				}else if(this is Enemy){
					//delete it
					removeActorFromGameEngine(this,EnemyManager.getInstance().getArray());
				}else if(this is LootDrop){
					//removeActorFromGameEngine(this,LootManager.getInstance()..getTreasureChestArray());
				}
				else if(this is TreasureChest){
					//removeActorFromGameEngine(this,LootManager.getInstance().getTreasureChestArray());
				}else if(this is Powerup_default){
					removeActorFromGameEngine(this,PowerupManager.getInstance().getArray());
				}else if(this is Coin){
					removeActorFromGameEngine(this,LevelManager.getInstance().getCoins());
				}else if(this is Gem){
					removeActorFromGameEngine(this,LevelManager.getInstance().getCoins());
				}else if(this is Trigger){
					removeActorFromGameEngine(this,LevelManager.getInstance().getTriggers());
				}else if(this is Trigger_CutScene){
					removeActorFromGameEngine(this,LevelManager.getInstance().getTriggers_cutScenes());
				}else if(this is Trigger_EndZone){
					removeActorFromGameEngine(this,LevelManager.getInstance().getTriggers_endZones());
				}else if(this is Trigger_CameraLock){
					removeActorFromGameEngine(this,LevelManager.getInstance().getTriggers_cameraLocks());
				}else if(this is Trigger_ActivateBoss){
					removeActorFromGameEngine(this,LevelManager.getInstance().getTriggers_activateBosses());
				}else if (this is FeedbackTextField) {
					removeActorFromGameEngine(this,EffectsManager.getInstance().getEffects());
				}else if (this is Trigger) {
					removeActorFromGameEngine(this,EffectsManager.getInstance().getEffects());
				}else if (this is BossEnemy) {
					removeActorFromGameEngine(this,EnemyManager.getInstance().getBosses());
				}else if (this is FeedbackMovieClip) {
					removeActorFromGameEngine(this,EffectsManager.getInstance().getEffects());
				}
			}
		}
		
		
		/*
		------------DISPLAY & FEEDBACK
					
		*/
		
		//create the grapic for the actor
		//uses a default vector rectangle if nothing else is defined 
		//filepath is passed in from the actor type
		//graphicsElement handles the loading, poorly :(
		//isLevel determines if its a level, and should therefore do some extra snazzy parsing stugg
		
		private function animationStateController():void {
			setAnimationState("idle");
		}
		public function defineGraphics(filePath:String="", isLevel:Boolean=false):void {
			loadActorSwf(getFilePath());
		}
		
		public function loadActorSwf(filePath:String):void {
			
			Main.getBulkLoader().beginLoad(this, filePath);
			//bulkLoader.beginLoad(this, filePath);
			//var loader:swfLoader = new swfLoader();
			//loader.beginLoad(this, filePath);
			//loader = null;
		}
		
		public function getiIsGraphicLoaded():Boolean {
			return isGraphicLoaded;
		}
		
		public function setiIsGraphicLoaded(loadedState:Boolean):void {
			isGraphicLoaded = loadedState;
		}
		
		//only used for placeholder graphics where a swf or png does not exist yet
		public function defineGraphicsDefaultRectangle():void{
			//actorGraphic = SwfParser.getInstance();
			drawGraphicDefaultRectangle();
		}
		
		public function defineGraphicsDefaultSmallRectangle():void {
			drawGraphicDefaultSmallRectangle();
		}
		
		
		//********************NEEDS UPDATE!
		public function defineLevelGraphics(filePath:String,isLevel:Boolean):void {
			actorGraphic = SwfParser.getInstance();
			actorGraphic.loadLevelSwf(filePath, this);
			this.addChild(actorGraphic);
		}
		
		public function createProgressBar(bar:String):void{
			/*switch(bar){
				case "Basic":
					progressBarGraphic = new ProgressGraphic_Basic();
					this.addChild(progressBarGraphic);
					break;
				case "Circular":
					progressBarGraphic = new ProgressGraphic_Basic();
					this.addChild(progressBarGraphic);
					break;
			}*/
		}
		
		//normally used for health bars or timed bars that fill up or down
		public function updateProgressBarGraphic(amount:Number):void{
			//progressBarGraphic.innerBar.scaleX = amount/100;
		}
		
		//for only showing progress or health bars when necessary
		//
		public function setProgressBarVisibility(visibility:Boolean):void{
			if (visibility == true){
				//progressBarGraphic.visible = true;
			}
			if (visibility == false){
				//progressBarGraphic.visible = false;
			}
		}
		
		//used for highlighting things, usually on roll-over or collision
		public function setHighlightState(highlightState:Boolean):void{
			if (highlightState == true){
				//highLight.visible = true;
			}
			if (highlightState == false){
				//highLight.visible = false;
			}
		}
		
		//this also needs to send the type
		//or maybe I can just determine the type in the factory
		public function send_Loot_Data_To_Factory():void{
			LootManager.lootFactory.generateLoot(this.x,this.y);
		}
		
		//this function will thow an undefined object error if runs before the assigned graphic is assigned
		public function playAnimation(animation:String):void {
			//trace(assignedGraphic[0]);
			//trace(assignedGraphic[0].swf_child);
			//trace("play animation")
			assignedGraphic[0].swf_child.gotoAndStop(animation);
			
			//trace("Actor:",this, "Animation:",animation);
			
		}
		
		public function listenForStopFrame():void {
			//trace("listen");
			if (assignedGraphic[0].swf_child.anim.currentLabel == "stop") {
				//trace("current label was stop");
				assignedGraphic[0].swf_child.anim.stop();
			}
		}
		
		/*
		------------GETTERS & SETTERS
					
		*/
					
		public function getIsIdle():Boolean {
			return isIdle;
		}
					
		public function setIsIdle(idleState:Boolean):void {
			isIdle = idleState;
		}
					
		public function getMaxIdleTime():int {
			return maxIdleTime;
		}
		
		public function setIdleImpatientTime(time:int):void {
			idleImpatientTime = time
		}
		
		public function getIdleImpatientTime():int {
			return idleImpatientTime;
		}
					
		public function getIdleTime():int {
			return idleTime;
		}
		
		public function setIdleTime(time:int):void {
			idleTime = time;
		}
					
		public function getAnimationState():String {
			return animationState;
		}
		
		public function setAnimationState(animState:String):void {
			animationState = animState;
		}
		
		public function getDirectionToFace():String {
			return directionLastFaced;
		}
		
		public function setDirectionToFace(direction:String):void {
			directionLastFaced = direction;
			switch(directionLastFaced) {
				case "LEFT":
					assignedGraphic[0].swf_child.anim.scaleX = Math.abs(assignedGraphic[0].swf_child.anim.scaleX) * -1;
					assignedGraphic[0].swf_child.anim.x = 0+assignedGraphic[0].swf_child.anim.width;
					break;
				case "RIGHT":
					assignedGraphic[0].swf_child.anim.scaleX = Math.abs(assignedGraphic[0].swf_child.anim.scaleX);
					assignedGraphic[0].swf_child.anim.x = 0;
					break;
			}
		}
		
		public function getLocation():Point{
			var point:Point=new Point(this.x,this.y);
			return point;
		}

		//useful for collision detection, in case the object gets into an invalid location
		public function setPreviousPosition():void {
			previousPosition.x = this.x + hitbox.x;
			previousPosition.y = this.y + hitbox.y;
		}
		
		public function setIntialPreviousPosition(spawnPosition:Point):void {
			previousPosition.x = spawnPosition.x
			previousPosition.y = spawnPosition.y
		}
		
		//useful for collision detection
		//in case the object gets into an invalid location
		//you can use this to put it back where it was if a new location cannot be resolved
		public function getPreviousPosition():Point{
			return previousPosition;
		}
		
		//returns the angle in god-awful flash degrees
		//convert it somewhere else if you want, try one of the MathFormulas functions
		public function getAngle():Number{
			return this.rotation;
		}
		
		//use the quadtree class to figure out what node the actor is in
		public function setQuadTreeNode():void{
			quadTreeNode = QuadTree.setNode(this);
			//trace("node",node);
		}
		
		//needs to have quadtree class updated so it works right
		public function getQuadTreeNode():int{
			return quadTreeNode;
		}
		
		public function get_availableForTargeting():Boolean{
			return availableForTargeting;
		}
		
		public function set_availableForTargetingToTrue():void{
			availableForTargeting = true;
		}
		
		public function setTarget(newTarget:MovieClip):void{
			if(target == newTarget){
				trace("Actot: setTarget: the old and new targets werer the same: what happened? Something bad!");
			}
			target = newTarget;
			setTargetToTrue();
		}
		
		public function getTarget():MovieClip{
			return target;
		}
		
		public function getActor():MovieClip{
			return this;
		}
		
		public function get_hasTargetFlag():Boolean{
			return hasTarget;
		}
		
		//if this actor is tracking a target
		//force it to no longer track that target
		public function setTargetToFalse():void{
			hasTarget = false;
			target = null;
		}
		public function setTargetToTrue():void{
			hasTarget = true;
		}
		
		public function getIsInvincible():Boolean {
			return isInvincible;
		}
		
		public function getKillsOnContact():Boolean {
			return killsOnContact;
		}
		
		public function setKillsOnContact(newState:Boolean):void {
			killsOnContact = newState;
			if (killsOnContact == true) {
				collisionDamage = collisionDamageInvincible;
			}
		}
		
		public function setInvincibilityEnabled(newState:Boolean):void {
			isInvincible = newState;
			if (isInvincible == true) {
				invincibilityTimer = 0;
				//collisionDamage = collisionDamageInvincible;
	
			}else if(isInvincible == false){
				collisionDamage = collisionDamageOriginal;
				setKillsOnContact(false);
			}
		}
		
		private function pickRandomColor():int {
			var randomNumber:Number;
			var colorValue:int;
			for (var i:int = 0; i < 5; i++ ) {
				randomNumber = Math.random()*1;
			}
			if (randomNumber < .2) {
				colorValue = 0x00FFFF;
			}else if (randomNumber < .4) {
				colorValue = 0xDC143C;
			}else if (randomNumber < .6) {
				colorValue = 0xADFF2F;
			}else if (randomNumber < .8) {
				colorValue = 0xFF8C00;
			}else if (randomNumber < 1) {
				colorValue = 0xFF1493;
			}
			return colorValue;
		}
		
		public function applyInvincibility():void {
			if (isInvincible) {
				invincibilityTimer++;
				invincibilityFlashTimer++;
				if (invincibilityFlashTimer >= invincibilityFlashMaxTime) {
					invincibilityFlashTimer = 0;
					if (this is Avatar) {
						if (invulnerableDueToDamage == false) {
							tintActor(pickRandomColor());
						}
					}
				}
				if (invincibilityTimer > invincibilityMaxTime) {
					resetActorTint();
					setInvincibilityEnabled(false);
				}
			}
		}
		
			public function setInvulnerableDueToDamage(newState:Boolean):void {
			invulnerableDueToDamage = newState;
			setInvincibilityEnabled(true);
		}
		
		public function getInvulnerableDueToDamage():Boolean {
			return invulnerableDueToDamage;
		}
		
		public function getIsShootingEnabled():Boolean {
			return isShootingEnabled;
		}
		
		public function setIsShootingEnabled(shootingState:Boolean):void {
			isShootingEnabled = shootingState;
		}
		
		public function getIsGravitySystemEnabled():Boolean {
			return isGravitySystemEnabled;
		}
		
		public function setIsGravitySystemEnabled(gravitySytemState:Boolean):void {
			isGravitySystemEnabled = gravitySytemState;
		}
		
		public function getCollisionDamage():int {
			return collisionDamage;
		}
		
		public function setCollisionDamage(newCollisionDamage:int):void {
			collisionDamage = newCollisionDamage;
		}
		
		public function getIsFalling(): Boolean {
			return isFalling;
		}
		
		public function setIsFalling(fallingState:Boolean):void {
			isFalling = fallingState;
		}
		
		public function traceProperties():void {
			
		}
		public function testFunction():void{
			trace(this, "Actor: class exists, probably means you fucked up somewhere else, or you can't access the object you want inside the class.");
		}
		
		public function getVelocity():Point {
			//var velocityPoint:Point = new Point(xVelocity,yVelocity);
			
			velocity.x = xVelocity;
			velocity.y = yVelocity;
			return velocity;
		}
		
		//this is normall for when you touch a platform or wall above you
		// it should prevent you from clipping through it
		public function reduceJumpSpeed():void {
			yVelocity = 2;
		}
		
		public function setIsSwfLoaded(loadState:Boolean):void {
			isSwfLoaded = loadState;
			SwfParser.getInstance().incrementChildrenLoaded();
		}
		
		public function getIsSwfLoaded():Boolean {
			return isSwfLoaded;
		}
		
		public function getActorGraphic():MovieClip {
			return actorGraphic;
		}
		
		public function tintActor(newTintColor:int):void {
			utilities.Mathematics.EasyTint.setTint(this,newTintColor);
		}
		
		public function resetActorTint():void {
			trace("resettingTint");
			utilities.Mathematics.EasyTint.resetTint(this);
		}
		
		public function setMaxGravity(newMax:int):void {
			maxGravity = newMax;
		}
		
		//disgusting hack ONLY ONLY ONLY if you don't have access to the FLA to edit the registration point. AVOID USING AT ALL COSTS.
		public function changeRegistrationPoint(displayObject:DisplayObjectContainer,x:Number,y:Number):void {
			var r:Rectangle = displayObject.getRect(displayObject);
			for (var i:int=0; i<displayObject.numChildren; i++) {
				displayObject.getChildAt(i).x-=r.x+x;
				displayObject.getChildAt(i).y-=r.y+y;
			}
			displayObject.x+=r.x+x;
			displayObject.y+=r.y+y;
		}
		
		public function drawGraphicDefaultSmallRectangle():Sprite {
			var myGraphic:Sprite = new Sprite();
			//myGraphic.graphics.lineStyle(3, 0x0000ff);
			myGraphic.graphics.lineStyle();
			myGraphic.graphics.beginFill(0x8800FF);
			myGraphic.graphics.drawRect(0,0,1,1);
			myGraphic.graphics.endFill();
			//this.addChild(myGraphic as MovieClip);
			return (myGraphic);
		}
		
		public function drawGraphicDefaultRectangle():void {
			var myGraphic:Sprite = new Sprite();
			myGraphic.graphics.lineStyle(3,0x0000ff);
			myGraphic.graphics.beginFill(0x8800FF);
			myGraphic.graphics.drawRect(0,0,100,100);
			myGraphic.graphics.endFill();
			this.addChild(myGraphic);
		}
	}
}