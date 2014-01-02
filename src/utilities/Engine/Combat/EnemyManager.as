package utilities.Engine.Combat{
	
	import utilities.Actors.Actor;
	import utilities.Actors.SpiderEnemy;
	import utilities.Engine.DefaultManager;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import utilities.Engine.IManager;
	import utilities.Engine.Game;
	import utilities.Engine.BasicManager;
	import utilities.Mathematics.MathFormulas;
	import utilities.Mathematics.RectangleCollision;
	import utilities.Screens.xpBarSystem;
	import utilities.Actors.Enemy;
	import utilities.Actors.AFSEnemy;
	import utilities.Actors.GoonEnemy;
	import utilities.Actors.TankEnemy;
	import utilities.Actors.Bullet;
	import utilities.Engine.LevelManager;
	import utilities.Input.KeyInputManager;
	public class EnemyManager extends BasicManager implements IManager{
		
		private var xVelocity:Number;
		private var yVelocity:Number;
		private var velocityMultiplier:Number;
		public var numEnemies:Number=0;
		public static var enemies:Array;
		private static var numnum:Number = 0;
		private static var _instance:EnemyManager;
		
		//Design Pattern Features
		public function EnemyManager(singletonEnforcer:SingletonEnforcer){
			setUp();
		}
		
		public static function getInstance():EnemyManager {
			if(EnemyManager._instance == null){
				EnemyManager._instance = new EnemyManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		//Interface Features
		public function getArray():Array{
			return enemies;
		}
		
		public function getArrayLength():int{
			return enemies.length;
		}
		
		public function getObjectAtIndex(index:int):Object{
			return enemies[index];
		}
		
		public function setUp():void{
			numnum = 0;
			enemies =[];
			placeholderValues();
			//createNewEnemy();
		}
		
		private function placeholderValues():void{
			velocityMultiplier = 1;
			xVelocity = 1;
			yVelocity = 1;
		}
		
	
		//check the enemies for collisions with bullets
		public static function updateLoop():void{

			checkForCollisionWithBullets();
			checkForCollisionWithWall();
			stayAttachedToAvatar();
			//FPO_checkForLevelComplete();
		}
		
		public static function FPO_checkForLevelComplete():void {
		
			if (enemies.length == 0 && LevelManager.getInstance().getisLevelActive()) {
					
				//trace("enemy manager: no enemies left");
				LevelManager.getInstance().setIsLevelComplete(true);
				LevelManager.getInstance().checkLevelObjectives();
			}
		}
		
		public static function stayAttachedToAvatar():void {
			var buffer:int = 3;
 			for each(var enemy:MovieClip in enemies) {
				//trace(enemy.getThrowable());
				if (KeyInputManager.getUpKey() == false) {
					enemy.setThrowable(true);
				}
				if (enemy.getIsAttachedToAvatar() == true) {
					//trace("is attached to avatar");
					if (KeyInputManager.getUpKey() == true && enemy.getThrowable() == true) {
						//trace("is throwable");
						enemy.setAttachToAvatar(false);
						enemy.setIsVulnerable(false);
						enemy.beThrown(AvatarManager.avatars[0].getDirectionToFace());
					}else {
						//the enemy needs to face the opposite direction of the avatar
						var directionEdgeCaseGarbage:String = AvatarManager.avatars[0].getDirectionToFace();
						if (directionEdgeCaseGarbage == "LEFT") {
							enemy.x = AvatarManager.avatars[0].x + AvatarManager.avatars[0].hitbox.width/2;
							enemy.setDirectionToFace("RIGHT");
						}else {
							enemy.x = AvatarManager.avatars[0].x - AvatarManager.avatars[0].hitbox.width/2;
							enemy.setDirectionToFace("LEFT");
						}
						enemy.y = AvatarManager.avatars[0].y - enemy.height - buffer;
					}
				}
			}
		}
		
		//this could possibly be better abstracted by generalizing the colliding objects, i.e. pass in both arrays rather than hard code them
		public static function checkForCollisionWithBullets():void{
 			for each(var enemy:MovieClip in enemies){
				enemy.updateLoop();
 				for each(var bullet:Bullet in BulletManager.bullets){
					//if(enemy.getQuadTreeNode() == bullet.getQuadTreeNode()){
						//this whole minDist business really should get pushed down into the math formulas, its confusing to read
						//perhaps i need to break it into to 2 functions, one that returns and that doesn't
						var minDist:Number = (bullet.width/2 + enemy.width/2) * (bullet.width/2 + enemy.width/2);
						if(MathFormulas.distanceFormulaOptimized(bullet,enemy) < minDist){
							enemy.takeDamage(bullet.getDamage());
							bullet.markDeathFlag();
						}
					//}
				}
			}
		}
		
		public static function checkForCollisionWithWall():void {
			for each(var enemy:MovieClip in enemies) {
				enemy.setNumberOfWallsBeingTouched(-enemy.getNumberOfWallsBeingTouched());
				for(var i:int = 0; i<LevelManager.walls.length;i++){
					if (utilities.Mathematics.RectangleCollision.simpleIntersection(enemy, LevelManager.walls[i]) == true) {
						//resolves the collision & returns if this touched the top of the other object
						var collisionSide:String = RectangleCollision.testCollision(enemy, LevelManager.walls[i]);
						if (collisionSide == "left" || collisionSide == "right") {
							enemy.reverseVelecityX();
							enemy.resetGravity();
						}
						if (collisionSide == "top") {
							enemy.setIsBeingThrown(false);
							enemy.setNumberOfWallsBeingTouched(1);
							enemy.resetGravity();
							if (enemy is TankEnemy || enemy is SpiderEnemy) {
								//if a tank enemy reaches the end of a platform, make it turn around instead of falling off 
								if (RectangleCollision.isRectangleOnTopAndTryingToExceedBoundsOfLowerRectangle(enemy, LevelManager.walls[i]) && enemy.getNumberOfWallsBeingTouched() == 1) {
									if (enemy.x > LevelManager.walls[i].x) {
										enemy.xVelocity = Math.abs(enemy.xVelocity) * -1;
									}
									if (enemy.x < LevelManager.walls[i].x) {
										enemy.xVelocity = Math.abs(enemy.xVelocity);
									}
									enemy.x = enemy.getPreviousPosition().x;
									enemy.x += enemy.xVelocity * 2;
								}
							}
						}
					}
				}
				enemy.setPreviousPosition();
			}
		}
		
		public function deselectActors():void {
			//trace("enenmyManager: deselectActors");
			for each(var myEnemy:MovieClip in enemies) {
				//trace("enemy to deselect:",myEnemy);
				myEnemy.deselectActor();
			}
		}
		
		
		
		//shitty placeholder enemy creation
		public static function createNewEnemy():void {
			//var AFSenemy:AFSEnemy = new AFSEnemy();
			//var goonEnemy:GoonEnemy = new GoonEnemy();
			//var tankEnemy:TankEnemy = new TankEnemy();
			//enemies.push(AFSenemy);
			//enemies.push(goonEnemy);
			//enemies.push(tankEnemy);
			//give the enemy some placeholder properties
			//AFSenemy.x = 375;
			//AFSenemy.y = 5;
			//goonEnemy.x = 500;
			//goonEnemy.y = -25;
			//tankEnemy.x = 600;
			//tankEnemy.y = -25;
			//var enemyGraphics = enemyFactory.GenerateBody();
		
		}
		
		//another shiity placeholder enemy creation
		public static function createNewRandomEnemy():void {
			/*var AFSenemy:AFSEnemy = new AFSEnemy();
			var Goonenemy:GoonEnemy = new GoonEnemy();
			var enemy:Enemy = new Enemy();*/
			//enemies.push(Goonenemy);
			//give the enemy some placeholder properties
			//Goonenemy.x = Math.random()*500;
			//Goonenemy.y = Math.random()*200;
			//var enemyGraphics = enemyFactory.GenerateBody();
			
			//placeholder debug var
			numnum+=1;
		}
		
		
	}
}

class SingletonEnforcer{}