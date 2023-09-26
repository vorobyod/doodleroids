
package {
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	
	public class DoodleroidsGame extends MovieClip {
		private static const ASTEROIDS_MAX:uint = 4;
		private static const ASTEROIDS_SPLIT_SIZE:uint = 2;
		private static const ASTEROIDS_PIECE_SIZE:uint = 8;
		private static const LIVES_MAX:uint = 5;
		private static const UFO_APPEARANCE_INTERVAL:uint = 20000;
		
		private static const ASTEROID_RHYTHM_SLOW:uint = 1000;
		private static const ASTEROID_RHYTHM_MEDIUM:uint = 500;
		private static const ASTEROID_RHYTHM_FAST:uint = 250;
		
		[Embed(source='sounds/laser.mp3')]
		private var LaserSound:Class;

		[Embed(source='sounds/thrust.mp3')]
		private var ThrustSound:Class;

		[Embed(source='sounds/rocket_explosion.mp3')]
		private var RocketExplosionSound:Class;

		[Embed(source='sounds/asteroid_blast.mp3')]
		private var AsteroidBlastSound:Class;
		
		[Embed(source='sounds/asteroid_rhythm_up.mp3')]
		private var AsteroidRhythmUpSound:Class;		

		[Embed(source='sounds/asteroid_rhythm_down.mp3')]
		private var AsteroidRhythmDownSound:Class;		
		
		private var ship:SpaceshipBase;
		private var ufo:Ufo;
		private var ufoTimer:Timer;
		private var asteroids:Array;
		private var laserBeams:Array;
		private var livesCnt:uint = LIVES_MAX;
		private var livesIndicator:LivesIndicator;
		private var collisionDetected:Boolean = false;
		private var gameScore:uint = 0;
		private var gameScoreIndicator:GameScoreIndicator;
		private var sounds:Object = new Object;
		private var rhythmTimer:Timer;
		private var rhythmType:Number = 0;
		
		public function DoodleroidsGame() {
			// Create gamefield
			stage.stageWidth = 600;
			stage.stageHeight = 400;
			
			var gd:Graphics = this.graphics;
			gd.lineStyle(1, 0x000000, 1);
			gd.beginFill(0x000000, 1);
			gd.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
			// Init lives indicator
			livesIndicator = new LivesIndicator(LIVES_MAX, 10, 10);
			addChild(livesIndicator);
			
			// Init score indicator
			gameScoreIndicator = new GameScoreIndicator(gameScore, stage.stageWidth - 10, 10);
			addChild(gameScoreIndicator);
			
			// Init sounds
			sounds['laser'] = new LaserSound() as Sound;
			sounds['thrust'] = new ThrustSound() as Sound;
			sounds['rocket_explosion'] = new RocketExplosionSound as Sound;
			sounds['asteroid_blast'] = new AsteroidBlastSound as Sound;
			sounds['asteroid_rhythm_up'] = new AsteroidRhythmUpSound;
			sounds['asteroid_rhythm_down'] = new AsteroidRhythmDownSound;

			// Init game objects
			init();			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function init():void
		{	
			ship = null;
			laserBeams = new Array();
			initAsteroids();
			initRhythmSound();
			initUfo();
		}
		
		private function initAsteroids():void {
			asteroids = new Array();
			for (var i:uint=0; i < ASTEROIDS_MAX; i++) {
				var asteroid:Asteroid = new Asteroid(
					Asteroid.ASTEROID_SIZE_LARGE,
					Math.round(Math.random() * stage.stageWidth),
					Math.round(Math.random() * stage.stageHeight)
				);
				addChild(asteroid);
				asteroids.push(asteroid);
			}			
		}
		
		private function initRhythmSound():void {
			rhythmTimer = new Timer(ASTEROID_RHYTHM_SLOW, 0);
			rhythmTimer.addEventListener(TimerEvent.TIMER, playRhythmSound);
			rhythmTimer.start();
		}
		
		private function playRhythmSound(e:Event):void {			
			if (rhythmType == 0) {
				sounds['asteroid_rhythm_up'].play();
				rhythmType = 1;
			} else {
				sounds['asteroid_rhythm_down'].play();
				rhythmType = 0;
			}			
		}
		
		private function updateRhythmInterval():void {
			var i:uint;
			var asteroidsCount:Array = new Array();
			var asteroid:Asteroid;
			var rhythmInterval:uint = 0;

			// Determine what rate to set based on number of asteroids left and size
			asteroidsCount[Asteroid.ASTEROID_SIZE_LARGE] = 0;
			asteroidsCount[Asteroid.ASTEROID_SIZE_MEDIUM] = 0;
			asteroidsCount[Asteroid.ASTEROID_SIZE_SMALL] = 0;
			
			for (i = 0; i < asteroids.length; i++) {
				asteroid = asteroids[i];
				if (asteroidsCount[asteroid.asteroidSize] == null) {
					asteroidsCount[asteroid.asteroidSize] = 0;
				}
				asteroidsCount[asteroid.asteroidSize]++;
			}
			
			if (asteroidsCount[Asteroid.ASTEROID_SIZE_LARGE] == 0) {
				if (asteroidsCount[Asteroid.ASTEROID_SIZE_MEDIUM] == 0) {
					if (asteroidsCount[Asteroid.ASTEROID_SIZE_SMALL] == 0) {
						rhythmInterval = ASTEROID_RHYTHM_SLOW;
					} else {
						rhythmInterval = ASTEROID_RHYTHM_FAST;
					}
				} else {
					rhythmInterval = ASTEROID_RHYTHM_MEDIUM;
				}
			} else {
				rhythmInterval = ASTEROID_RHYTHM_SLOW;
			}
			if (rhythmTimer.delay != rhythmInterval) {
				rhythmTimer.stop();
				rhythmTimer.delay = rhythmInterval;
				rhythmTimer.start();
			}
		}
		
		private function initUfo():void {
			ufoTimer = new Timer(UFO_APPEARANCE_INTERVAL, 0);
			ufoTimer.addEventListener(TimerEvent.TIMER, startUfo);
			ufoTimer.start();
		}
		
		private function startUfo(e:Event):void {
			if (ufo != null) {
				return;
			}
			ufoTimer.stop();
			ufo = new Ufo(
				new Rectangle(0, 0, stage.stageWidth, stage.stageHeight),
				stage.stageWidth * 2
			);
			addChild(ufo);
		}
		
		private function restart():void {
			var i:uint = 0;
			//removeChild(ship);
			for (i = 0; i < laserBeams.length; i++) {
				removeChild(laserBeams[i]);
			}
			for (i = 0; i < asteroids.length; i++) {
				removeChild(asteroids[i]);
			}
			init();
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var boostedShip:SpaceshipBoost;
			var laserBeam:LaserBeam;
			
			switch(event.keyCode)
			{
				case Keyboard.LEFT:
					ship.rotationLeft();
					break;
					
				case Keyboard.RIGHT:
					ship.rotationRight();
					break;
				
				case Keyboard.UP:
					ship.thrustStart();
					// Replace static rocket image with rocket engines on
					if (ship is Spaceship) {
						removeChild(ship);
						ship = new SpaceshipBoost(ship);
						addChild(ship);
					}
					sounds['thrust'].play();
					break;

				case Keyboard.SPACE:
					// Fire those lasers Jordie! :)
					laserBeam = new LaserBeam(
						ship.x, ship.y, ship.width / 2, ship.rotation,
						ship.velocityX, ship.velocityY
					);
					addChild(laserBeam);
					laserBeams.push(laserBeam);
					sounds["laser"].play();
					break;
					
				default:
					break;
			}
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			switch(event.keyCode) {
				case Keyboard.LEFT:
				case Keyboard.RIGHT:
					// Stop rotation
					ship.rotationStop();
					break;
					
				case Keyboard.UP:
					ship.thrustStop();
					// Remove sprite with rockets on and replace with static rocket sprite
					removeChild(ship);
					ship = new Spaceship(ship);
					addChild(ship);
					break;
			}
		}
		
		private function onEnterFrame(event:Event):void
		{
			var i:uint = 0;
			var j:uint = 0;
			var k:uint = 0;
			var asteroid:Asteroid;
			var asteroidNew:Asteroid;
			var collisionDetected:Boolean = false;
			var renderBox:Rectangle = new Rectangle(
				0,0, stage.stageWidth, stage.stageHeight);
			
			// Init/render spaceship
			if (ship == null) {
				ship = new Spaceship();
				ship.x = stage.stageWidth / 2;
				ship.y = stage.stageHeight / 2;
				do {
					collisionDetected = false;
					for(i=0; i < asteroids.length; i++) {
						if (CollisionDetection.detect(ship, asteroids[i])) {
							collisionDetected = true;
							break;
						}	
					}
				} while (collisionDetected);
				addChild(ship);
			}
			ship.render(renderBox);
			
			// Render laser beams
			for (i = 0; i < laserBeams.length; i++) {
				laserBeams[i].render(renderBox);
			}
			if ((laserBeams.length > 0) && !laserBeams[0].isActive()) {
				removeChild(laserBeams[0]);
				laserBeams.shift();
			}
					
			// Render asteroids - happens when all asteroids are destroyed
			if (asteroids.length == 0) {
				initAsteroids();
			}
			for (i = 0; i < asteroids.length; i++) {
				asteroid = asteroids[i];
				if (asteroid.isActive()) {
					asteroid.render(renderBox);
				} else {
					removeChild(asteroid);
					asteroids.splice(i, 1)
				}
			}
			
			// Render UFO
			if (ufo != null) {
				if (ufo.isActive()) {
					ufo.render(renderBox);
				} else {
					removeChild(ufo);
					ufo = null;
					ufoTimer.start();
				}
			}

			// Detect collisions between laser and asteroids
			collisionDetected = false;
			for (i = 0; i < laserBeams.length; i++) {
				var laserBeam:LaserBeam = laserBeams[i];
				for (j = 0; j < asteroids.length; j++) {
					asteroid = asteroids[j];
					if (CollisionDetection.detect(laserBeam, asteroid)) {
						collisionDetected = true;
						sounds['asteroid_blast'].play();
						gameScore += asteroid.scorePoints;
						gameScoreIndicator.update(gameScore);
						break;
					}
				}
				if (collisionDetected) {
					break;
				}
			}
			if (collisionDetected) {
				// Remove laser beam
				removeChild(laserBeam);
				laserBeams.splice(i, 1);

				// Split/blast asteroid
				var asteroidNewSize:uint = 0;
				var asteroidNewTotal:uint = 0;
				switch (asteroid.asteroidSize) {
					case Asteroid.ASTEROID_SIZE_LARGE:
					case Asteroid.ASTEROID_SIZE_MEDIUM:
						// If asteroid is large (medium) - split to ASTEROIDS_SPLIT_SIZE
						// medium (small) and send them to random directions
						asteroidNewSize = (asteroid.asteroidSize == Asteroid.ASTEROID_SIZE_LARGE) ?
							Asteroid.ASTEROID_SIZE_MEDIUM : Asteroid.ASTEROID_SIZE_SMALL;
						asteroidNewTotal = ASTEROIDS_SPLIT_SIZE;
						break;
							
					case Asteroid.ASTEROID_SIZE_SMALL:
						asteroidNewSize = Asteroid.ASTEROID_SIZE_PIECE;
						asteroidNewTotal = ASTEROIDS_PIECE_SIZE;
						break;
				}
					
				removeChild(asteroid);
				asteroids.splice(j, 1);
				for (k = 0; k < asteroidNewTotal; k++ ) {
					asteroidNew = new Asteroid(
					asteroidNewSize,
						asteroid.x,
						asteroid.y
					);
					asteroids.splice(j + k, 0, asteroidNew);
					addChild(asteroidNew);
				}
				
				// After we updated number of asteroids - check rhythm interval
				// XXX Probably will need to refactor when UFO added
				updateRhythmInterval();
			}
			
			// Detect collisions between ship and asteroids
			collisionDetected = false;
			for (i = 0; i < asteroids.length; i++) {
				// Do not detect collision for pieces of an asteroid
				if (asteroid.asteroidSize == Asteroid.ASTEROID_SIZE_PIECE) {
					continue;
				}
				if (!ship.collisionState && CollisionDetection.detect(ship, asteroids[i])) {
					collisionDetected = true;
					ship.collisionState = true;
					sounds['rocket_explosion'].play();
					break;
				}
			}
			
			// If collision detected - play collision animation,
			// decrease live indicator and restart game.
			// If we out of lives - game over man ;)
			if (ship.collisionState && collisionDetected) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				var damagedSpaceship:SpaceshipFlames = new SpaceshipFlames();
				damagedSpaceship.x = ship.x;
				damagedSpaceship.y = ship.y;
				damagedSpaceship.rotation = ship.rotation;
				removeChild(ship);
				addChild(damagedSpaceship);
				setTimeout(function():void {
					livesCnt--;
					if (livesCnt == 0) {
 						removeEventListener(Event.ENTER_FRAME, onEnterFrame);
						MovieClip(root).gotoAndStop("gameover");
					}
					removeChild(damagedSpaceship);
					livesIndicator.update(livesCnt);
					ship = null;
					stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
					stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				}, 2000);
			}			
		}
	
	}
}