package utilities.Engine.Combat{
	import flash.display.MovieClip;
	import utilities.Actors.Bullet;
	import utilities.dataModels.LevelProgressModel;
	import utilities.Effects.Effect;
	import utilities.Engine.BasicManager;
	import utilities.Engine.DefaultManager;
	import utilities.Actors.Avatar;
	import utilities.Engine.IManager;
	import utilities.Engine.LevelManager;
	import utilities.Engine.EffectsManager
	import utilities.Engine.Combat.PowerupManager;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Mathematics.RectangleCollision;
	import utilities.Input.KeyInputManager;
	import flash.geom.Point;
	public class AvatarManager extends BasicManager implements IManager {
		private static var _instance:AvatarManager;
		public static var avatar:MovieClip;
		public static var avatars:Array;
		public static var isAvatarDoubleJumpEnabled:Boolean = false;
		public function AvatarManager(singletonEnforcer:SingletonEnforcer){
			setUp();			
		}
		
		public function getIsAvatarDoubleJumpEnabled():Boolean {
			return isAvatarDoubleJumpEnabled;
		}
		
		public static function getInstance():AvatarManager {
			if(AvatarManager._instance == null){
				AvatarManager._instance = new AvatarManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		private function setUp():void{
			avatars =[];
		}
		
		public function getAvatarLocation():Point{
			return avatars[0].getAvatarLocation();
		}
		
		public function getAvatarAngle():Number{
			return avatars[0].getAngle();
		}
		
		public function deselectActors():void {
			for each(var myAvatar:Avatar in avatars) {
				myAvatar.deselectActor();
			}
		}
	
		public static function updateLoop():void {
			for each(var myAvatar:Avatar in avatars){
				var isTouchingWall:Boolean = false;
				var additionalVelocity:int = 0;
				myAvatar.updateLoop();
				//collide powersups & avatar
				for (var a:int = 0; a < PowerupManager.powerups.length; a++) {
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, PowerupManager.powerups[a]) == true) {
						myAvatar.toggleDoubleJump(true);
						isAvatarDoubleJumpEnabled = true;
						myAvatar.applyPowerup(PowerupManager.powerups[a].getPowerupType());
						PowerupManager.powerups[a].takeDamage(1);
						PowerupManager.powerups[a].checkForDeathFlag();
					}
				}
				//collide coins & avatar
				for (var b:int = 0; b < LevelManager.coins.length;b++){
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.coins[b]) == true) {
						LevelManager.coins[b].takeDamage(1);
						LevelManager.coins[b].checkForDeathFlag();
					}
				}
				//collide save points & avatar
				for (var c:int = 0; c < LevelManager.savePoints.length; c++) {
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.savePoints[c]) == true) {
						if (LevelManager.savePoints[c].getIsActive() == true) {
								LevelProgressModel.getInstance().setMidMissionProgress(c);
								LevelManager.savePoints[c].setIsActive(false);
						}
					}
				}
				//collide with trigger to trigger moving wall
				for (var d:int = 0; d < LevelManager.triggers.length; d++) {
					//trace("triggers here");
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.triggers[d]) == true) {
						LevelManager.triggers[d].takeDamage(1);
						LevelManager.triggers[d].checkForDeathFlag();
						//trace("touched moveable wall trigger");
					}
				}
				//collide with triggers for endzone
				for (var e:int = 0; e < LevelManager.triggers_endZones.length; e++) {
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.triggers_endZones[e]) == true) {
						LevelManager.triggers_endZones[e].takeDamage(1);
						LevelManager.triggers_endZones[e].checkForDeathFlag();
					}
				}
				//collide with trigger for cutscenes
				for (var f:int = 0; f < LevelManager.triggers_cutScenes.length; f++) {
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.triggers_cutScenes[f]) == true) {
						LevelManager.triggers_cutScenes[f].takeDamage(1);
						LevelManager.triggers_cutScenes[f].checkForDeathFlag();
					}
				}
				
				//collide with trigger for cutscenes
				for (var g:int = 0; g < LevelManager.triggers_cameraLocks.length; g++) {
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.triggers_cameraLocks[g]) == true) {
						LevelManager.triggers_cameraLocks[g].takeDamage(1);
						LevelManager.triggers_cameraLocks[g].checkForDeathFlag();
						trace("tell camera to lock");
					}
				}
				
				//collide with a wall that was triggered to move
				for (var h:int = 0; h < LevelManager.triggerableWalls.length; h++) {
					if (LevelManager.triggerableWalls[h].getType() == "triggeredWall") {
						LevelManager.triggerableWalls[h].updateLoop();
					}
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.triggerableWalls[i]) == true) {
						switch (LevelManager.triggerableWalls[i].getType()){
							case "triggeredWall":
								if (utilities.Mathematics.RectangleCollision.testCollision(myAvatar, LevelManager.triggerableWalls[h]) == "top") {
									trace(LevelManager.triggerableWalls[h]);
									//trace("hitbox width: ",LevelManager.walls[i].hitbox.width);
									//trace("hitbox height: ",LevelManager.walls[i].hitbox.height);
									//trace("TOP -- touched triggered wall");
									//additionalVelocity = LevelManager.triggerableWalls[i].getVelocity().y;
									//isTouchingWall = true;
									myAvatar.jumpingEnded();
									myAvatar.resetGravity();
								}
								break;
						}
					}
				}
				//collide walls & avatar
				for (var i:int = 0; i < LevelManager.walls.length; i++) {
					if (LevelManager.walls[i].getType() == "movingWall") {
						LevelManager.walls[i].updateLoop();
					}
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.walls[i]) == true) {
						switch (LevelManager.walls[i].getType()){
							case "standard":
								//resolves the collision & returns if this touched the top of the other object
								if (utilities.Mathematics.RectangleCollision.testCollision(myAvatar, LevelManager.walls[i]) == "top") {
									myAvatar.jumpingEnded();
									myAvatar.resetGravity();
									//trace("touched standard");
								}
								break;
							case "platform":
								if (utilities.Mathematics.RectangleCollision.testCollisionWithPlatform(myAvatar, LevelManager.walls[i]) == true) {
									//trace("touched platform");
									myAvatar.jumpingEnded();
									myAvatar.resetGravity();
								}
								break;
							case "movingWall":
								//trace("touched movingWall");
								//trace(LevelManager.walls[i].name);
								if (utilities.Mathematics.RectangleCollision.testCollision(myAvatar, LevelManager.walls[i]) == "top") {
									additionalVelocity = LevelManager.walls[i].getVelocity().y;
									isTouchingWall = true;
									myAvatar.jumpingEnded();
									myAvatar.resetGravity();
								}
								break;
							case "movingPlatform":
								if (utilities.Mathematics.RectangleCollision.testCollision(myAvatar, LevelManager.walls[i]) == "top") {
									
								//trace("touched movingPlatform");
									additionalVelocity = LevelManager.walls[i].getVelocity().y;
									isTouchingWall = true;
									//trace("movingPlatform");
									myAvatar.jumpingEnded();
									myAvatar.resetGravity();
									
								}
								break;
							
						}
					}
					//collide bullets  & walls
					for each(var bullet:Bullet in BulletManager.bullets) {
						if (utilities.Mathematics.RectangleCollision.simpleIntersection(bullet, LevelManager.walls[i]) == true) {
							var collisionSide:String = utilities.Mathematics.RectangleCollision.testCollision(bullet, LevelManager.walls[i]);
							if (collisionSide == "top") {
								
								bullet.reverseVelecityY();
							}
							if (collisionSide == "bottom") {
								
								bullet.reverseVelecityY();
							}
							if (collisionSide == "left") {
								
								bullet.reverseVelecityX();
							}
							if (collisionSide == "right") {
								
								bullet.reverseVelecityX();
							}
						}
					}
				}
				//collide enemies & avatar
				for (var j:int = 0; j < EnemyManager.enemies.length; j++) {
					//checks for collision between hitboxes
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, EnemyManager.enemies[j]) == true) {
						//if the enemy is vulnerable, do nothing on bottom/left/right collisions
						if ( EnemyManager.enemies[j].getIsVulnerable() == true) {
							//you pressed the up key to pick up the enemy while it was vulnerable
							if (KeyInputManager.getUpKey() == true) {
								EnemyManager.enemies[j].setAttachToAvatar(true);
								EnemyManager.enemies[j].setRechargePause(true);
								EnemyManager.enemies[j].setThrowable(false)
							}
							
							//you jump on the enemy while it is vulnerable
							var collisionWithEnemyDirection:String = RectangleCollision.testCollision(myAvatar, EnemyManager.enemies[j],false);
							if(collisionWithEnemyDirection=="top"){
								trace("vulnerable and not on top");
								//this is whats causing me to drop in the middle of enemies maybe, because i messed with the function that keeps enemies on platforms?
								trace("vulnerable and on top");
								myAvatar.jumpingEnded();
								myAvatar.jump();
								EnemyManager.enemies[j].takeDamage(myAvatar.getJumpDamage());
								EffectsManager.getInstance().newEffect_FeedbackTextField(myAvatar.x + myAvatar.width/2,myAvatar.getPreviousPosition().y,"HANKED!");
							//you touch the enemy on anywhere but its top side
							}else {
								//you pass through the enemy
							}
						}else{
							//resolves the collision & returns if this touched the top of the other object
							
							//if the avatar is on top of the enemy and the enemy is not in the vulnerable state, then damage it and bounce the avatar
							var collisionDirection:String = "";
							collisionDirection = utilities.Mathematics.RectangleCollision.testCollision(myAvatar, EnemyManager.enemies[j],false);
							if (collisionDirection=="top") {
								myAvatar.jumpingEnded();
								myAvatar.jump();
								EnemyManager.enemies[j].takeDamage(myAvatar.getJumpDamage());
								EnemyManager.enemies[j].setIsVulnerable(true);
								EffectsManager.getInstance().newEffect_FeedbackTextField(myAvatar.x + myAvatar.width/2,myAvatar.getPreviousPosition().y,"FRANKED!");
							//if the enemy is NOT vulnerable and the avatar touches the enemy on anything but the top, the avatar takes damage
							}else {
								if(EnemyManager.enemies[j].getIsBeingThrown() == false){
									EnemyManager.enemies[j].takeDamage(myAvatar.getCollisionDamage());
									myAvatar.setBounceDirection(collisionDirection);
									//if you are invincible, this will cause the enemy to take damage, otherwise it will do nothing
									myAvatar.takeDamage(EnemyManager.enemies[j].getCollisionDamage() );
								}
							}
						}
					}
					//make sure the avatar and his hitbox exist before checking against them
					
					//I think is supposed to check if you attack it?
					if (myAvatar.getiIsGraphicLoaded() == true) {
						if(EnemyManager.enemies[j].hitTestObject(myAvatar.getActorGraphic().assignedGraphics[0].swf_child.hitbox_attack)){
							EnemyManager.enemies[j].takeDamage(myAvatar.getAttackDamage());
						}
					}	
				}
				myAvatar.setPreviousPosition();
				myAvatar.setAdditionalYVelocity(additionalVelocity);
			}
		}
		
		public function createExtraLifeTextFeecbackText():void {
			EffectsManager.getInstance().newEffect_FeedbackTextField(getAvatar().x + getAvatar().width/2,getAvatar().getPreviousPosition().y,"EXTRA LIFE!");
		}
		
		//deprecated
		private static function createAvatar():void {
			avatar = new utilities.Actors.Avatar(0,0);
			avatars.push(avatar);
			//trace();
		}
		
		public function getArray():Array{
			return avatars;
		}
		
		public static function getAvatar():MovieClip {
		/*	trace("avatars[0]", avatars[0]);
			trace("avatars",avatars);
			trace("avatars.numChildren",avatars.numChildren);*/
			return avatars[0];
		}
		
		public static function getAvatarForCheats():MovieClip{
			return avatars[0];
		}
	}
}
class SingletonEnforcer{}