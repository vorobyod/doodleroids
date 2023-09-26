package 
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Dennis Granau
	 */
	public class LaserBeam extends Sprite
	{
		public const LASER_BEAM_RANGE:uint = 300;
		public const LASER_BEAM_VELOCITY:uint = 10;
		public const LASER_BEAM_POSITION_PADDING:uint = 0;
		
		[Embed(source="sprites/laser.png")]
		private var SpriteImage:Class;
		
		private var vx:Number = 0;;
		private var vy:Number = 0;
		private var distanceTravelled:Number = 0;
		
		public function LaserBeam(
				baseX:Number, baseY:Number, baseMargin:Number, rotation:Number,
				baseVelX:Number, baseVelY:Number) {
			var spriteImage:Sprite = new Sprite();
			spriteImage.addChild(new SpriteImage());
			addChild(spriteImage);
			// Set registration point to center
			spriteImage.transform.matrix = new Matrix(1, 0, 0, 1, -(spriteImage.width / 2), -(spriteImage.height / 2));	
			
			// Set laser position
			var baseAngle:Number = (rotation - 90) * Math.PI / 180;
			var baseToStartPointDistance:Number = baseMargin + this.width / 2 + LASER_BEAM_POSITION_PADDING;
			this.x = baseX + baseToStartPointDistance * Math.cos(baseAngle);
			this.y = baseY + baseToStartPointDistance * Math.sin(baseAngle);
			this.rotation = rotation;

			// Set laser speed		
			this.vx = baseVelX + this.LASER_BEAM_VELOCITY * Math.cos(baseAngle);
			this.vy = baseVelY + this.LASER_BEAM_VELOCITY * Math.sin(baseAngle);
		}
		
		// Check if laser beam is still active
		public function isActive():Boolean {
			return (distanceTravelled <= LASER_BEAM_RANGE);
		}

		// Renders laser beam inside renderBox boundaries
		public function render(renderBox:Rectangle):void {
			this.x += vx;
			this.y += vy;
			this.distanceTravelled += Math.sqrt(vx*vx + vy*vy);
			
			// Screen wrapping check
			if (this.x > renderBox.width)
			{
				this.x = renderBox.x + (this.x - renderBox.width);
			} else if (this.x < renderBox.x) {
				this.x = renderBox.width + this.x;
			}
			if (this.y < renderBox.y)
			{
				this.y = renderBox.height + this.y;
			} else if (this.y > renderBox.height) {
				this.y = renderBox.y + (this.y - renderBox.height);
			}
		}		

	}
	
}