package
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;

	public class Asteroid extends Sprite
	{
		public static const ASTEROID_SIZE_LARGE:uint  = 1;
		public static const ASTEROID_SIZE_MEDIUM:uint = 2;
		public static const ASTEROID_SIZE_SMALL:uint  = 3;
		public static const ASTEROID_SIZE_PIECE:uint = 4;
		
		public static const ASTEROID_PIECE_RANGE:uint = 40;
		
		[Embed(source="sprites/asteroid_large.png")]		
		private var AsteroidLargeSpriteImage:Class;
		
		[Embed(source="sprites/asteroid_medium.png")]		
		private var AsteroidMediumSpriteImage:Class;
		
		[Embed(source="sprites/asteroid_small.png")]		
		private var AsteroidSmallSpriteImage:Class;
		
		[Embed(source="sprites/asteroid_piece.png")]		
		private var AsteroidPieceSpriteImage:Class;
				
		private var vx:Number = 0;
		private var vy:Number = 0;
		
		private var _asteroidSize:uint = 0;
		private var _scorePoints:uint = 0;
		private var distanceTravelled:Number = 0;
		private var activeRange:uint = 0;

		public function Asteroid(asteroidSize:Number, posX:Number, posY:Number) {
			var spriteImage:Sprite = new Sprite();
			var thrust:Number = 0;
			
			// Set asteroid sprite and speed multiplier according to asteroid type
			this._asteroidSize = asteroidSize;
			switch(asteroidSize) {
				case ASTEROID_SIZE_LARGE:
					spriteImage.addChild(new AsteroidLargeSpriteImage());
					thrust = 1;
					_scorePoints = 20;
					break;
				case ASTEROID_SIZE_MEDIUM:
					spriteImage.addChild(new AsteroidMediumSpriteImage());
					thrust = 2;
					_scorePoints = 50;
					break;
				case ASTEROID_SIZE_SMALL:
					spriteImage.addChild(new AsteroidSmallSpriteImage());
					thrust = 4;
					_scorePoints = 100;
					break;
				case ASTEROID_SIZE_PIECE:
					spriteImage.addChild(new AsteroidPieceSpriteImage());
					thrust = 6;
					activeRange = ASTEROID_PIECE_RANGE;
					break;
				default:
					throw new Error("Incorrect asteroid size " + asteroidSize);
					break;

			}
			
			// Set registration point to center
			addChild(spriteImage);
			spriteImage.transform.matrix = new Matrix(1, 0, 0, 1, -(spriteImage.width/2), -(spriteImage.height/2));

			// Set asteroid position
			this.x = posX;
			this.y = posY;
			
			// Init asteroid speed vector
			var angle:Number = Math.random() * Math.PI * 2;
			this.vx = Math.cos(angle) * thrust;
			this.vy = Math.sin(angle) * thrust;
		}
	
		public function get scorePoints():uint {
			return this._scorePoints;
		}
		
		public function get asteroidSize():uint {
			return this._asteroidSize;
		}
		
		// Check if asteroid is still active
		public function isActive():Boolean {
			if (activeRange > 0) {
				return (distanceTravelled <= activeRange);
			}
			return true;
		}

		// Renders asteroid inside renderBox boundaries
		public function render(renderBox:Rectangle):void
		{
			this.x += vx;
			this.y += vy;
			
			// Update distanceTravelled only if activeRange is set to 0
			if (this.activeRange > 0) {
				this.distanceTravelled += Math.sqrt(vx * vx + vy * vy);
			}
						
			// Screen wrapping check
			if (this.x - this.width/2 > renderBox.width)
			{
				this.x = renderBox.x + this.width/2;
			} else if (this.x + this.width/2 < renderBox.x) {
				this.x = renderBox.width - this.width/2;
			}
			if (this.y + this.height/2 < renderBox.y)
			{
				this.y = renderBox.height - this.height/2;
			} else if (this.y - this.height/2 > renderBox.height) {
				this.y = renderBox.y + this.height/2;
			}
		}
		
	}
}