package utilities.Engine.Combat{
	import flash.display.MovieClip;
	import utilities.Actors.Bullet;
	import utilities.dataModels.LevelProgressModel;
	import utilities.Engine.BasicManager;
	import utilities.Engine.DefaultManager;
	import utilities.Actors.Avatar;
	import utilities.Engine.IManager;
	import utilities.Engine.LevelManager;
	import utilities.Engine.Combat.PowerupManager;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Mathematics.RectangleCollision;
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
			//trace(myAvatar.getAdditionalYVelocity());
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
				//collide with triggers
				for (var d:int = 0; d < LevelManager.triggers.length; d++) {
					//trace("triggers here");
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.triggers[d]) == true) {
						LevelManager.triggers[d].takeDamage(1);
						LevelManager.triggers[d].checkForDeathFlag();
						//trace("touched trigger");
					}
				}
				
				//collide walls & avatar
				for (var e:int = 0; e < LevelManager.triggerableWalls.length; e++) {
					if (LevelManager.triggerableWalls[e].getType() == "triggeredWall") {
						LevelManager.triggerableWalls[e].updateLoop();
					}
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.triggerableWalls[e]) == true) {
						switch (LevelManager.triggerableWalls[e].getType()){
							case "triggeredWall":
								if (utilities.Mathematics.RectangleCollision.testCollision(myAvatar, LevelManager.triggerableWalls[e]) == "top") {
									additionalVelocity = LevelManager.triggerableWalls[i].getVelocity().y;
									isTouchingWall = true;
									//trace("triggeredWall");
									myAvatar.jumpingEnded();
									myAvatar.resetGravity();
									
									
									
									
									
									
									//reduceJumpSpeed.yVelocity();
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
									//trace("standard");
								}
								break;
							case "platform":
								if (utilities.Mathematics.RectangleCollision.testCollisionWithPlatform(myAvatar, LevelManager.walls[i]) == true) {
									//trace("platform");
									myAvatar.jumpingEnded();
									myAvatar.resetGravity();
								}
								break;
							case "movingWall":
								//trace("movingWall");
								//trace(LevelManager.walls[i].name);
								if (utilities.Mathematics.RectangleCollision.testCollision(myAvatar, LevelManager.walls[i]) == "top") {
									additionalVelocity = LevelManager.walls[i].getVelocity().y;
									isTouchingWall = true;
									myAvatar.jumpingEnded();
									myAvatar.resetGravity();
								}
								break;
							case "movingPlatform":
								if (utilities.Mathematics.RectangleCollision.testCollisionWithPlatform(myAvatar, LevelManager.walls[i]) == true) {
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
					//checks for collision
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, EnemyManager.enemies[j]) == true) {
						//if the avatar is invincible, damage the enemy
						//EnemyManager.enemies[j].takeDamage(myAvatar.getCollisionDamage());
						//resolves the collision & returns if this touched the top of the other object
						var collisionDirection:String = "";
						collisionDirection = utilities.Mathematics.RectangleCollision.testCollision(myAvatar, EnemyManager.enemies[j]);
						if (collisionDirection=="top") {
							myAvatar.jumpingEnded();
							myAvatar.jump();
							EnemyManager.enemies[j].takeDamage(myAvatar.getJumpDamage());
						}else {
							myAvatar.setBounceDirection(collisionDirection);
							//if you are invincible, this will cause the enemy to take damage, else it will do nothing
							myAvatar.takeDamage(EnemyManager.enemies[j].getCollisionDamage() );
							//if you are invincible, you will instant kill the enemy, else it will do nothing
							EnemyManager.enemies[j].takeDamage(myAvatar.getCollisionDamage());
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
		
		//deprecated
		private static function createAvatar():void {
			avatar = new utilities.Actors.Avatar(0,0);
			avatars.push(avatar);
		}
		
		public function getArray():Array{
			return avatars;
		}
		
		public function getAvatar():MovieClip{
			return avatars[0];
		}
	}
}
class SingletonEnforcer{}