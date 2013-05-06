package utilities.Engine.Combat{
	import flash.display.MovieClip;
	import utilities.Engine.DefaultManager;
	import utilities.Actors.Avatar;
	import utilities.Engine.LevelManager;
	import utilities.Engine.Combat.PowerupManager;
	import utilities.Actors.GameBoardPieces.Wall;
	import utilities.Mathematics.RectangleCollision;
	import flash.geom.Point;
	public class AvatarManager extends utilities.Engine.DefaultManager{
		public static var avatar:MovieClip;
		public static var avatars:Array;
		public function AvatarManager(){
			setUp();			
		}
		
		private function setUp():void{
			avatars =[];
			//createAvatar();
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
	
		public override function updateLoop():void{
			for each(var myAvatar:Avatar in avatars){
				myAvatar.updateLoop();
				
				for (var a:int = 0; a < PowerupManager.powerups.length; a++) {
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, PowerupManager.powerups[a]) == true) {
						
						myAvatar.toggleDoubleJump(true);
						//trace("1111111111111",PowerupManager.powerups[a]);
						//trace("22222222222222",PowerupManager.powerups[a].getPowerupType());
						myAvatar.applyPowerup(PowerupManager.powerups[a].getPowerupType());
						PowerupManager.powerups[a].takeDamage(1);
						PowerupManager.powerups[a].checkForDeathFlag();
					}
				}
				
				//for some horrible ass backwards reason, I included the level itself in the same array as the walls inside the level, so the iteration needs to start at 1
				//this is unnacceptable and needs to get fixed asap because it is super confusing and inconsistent.
				for(var i:int = 1; i<LevelManager.levels.length;i++){
				//a really uneccessarily long way to write hitTestObject, because I can
					//checks for collision
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, LevelManager.levels[i]) == true) {
						//resolves the collision & returns if this touched the top of the other object
						if (utilities.Mathematics.RectangleCollision.resolveCollisionBetweenMovingAndStationaryRectangles(myAvatar, LevelManager.levels[i]) == "top") {
							myAvatar.jumpingEnded();
							myAvatar.resetGravity();
						}
					}
				}
				for (var j:int = 0; j < EnemyManager.enemies.length;j++){
				//a really uneccessarily long way to write hitTestObject, because I can
					//checks for collision
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(myAvatar, EnemyManager.enemies[j]) == true) {
						//if the avatar is invincible, damage the enemy
						EnemyManager.enemies[j].takeDamage(myAvatar.getCollisionDamage());
						//resolves the collision & returns if this touched the top of the other object
						if (utilities.Mathematics.RectangleCollision.resolveCollisionBetweenMovingAndStationaryRectangles(myAvatar, EnemyManager.enemies[j]) =="top") {
							myAvatar.jumpingEnded();
							myAvatar.jump();
							EnemyManager.enemies[j].takeDamage(myAvatar.getJumpDamage());
						}
					}
				}
				myAvatar.setPreviousPosition();
			}
		}
		
		private static function createAvatar():void{
			avatar = new utilities.Actors.Avatar();
			avatars.push(avatar);
		}
		
		public override function getArray():Array{
			return avatars;
		}
		
		public function getAvatar():MovieClip{
			return avatars[0];
		}
	}
}
