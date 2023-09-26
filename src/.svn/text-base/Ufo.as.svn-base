package
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	
	public class Ufo extends Sprite
	{	
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _angle:Number = 0;
		private var _velocity:Number = 3;
		private var _activeRange:Number = 0;
		private var _turnDistance:Number = 0;
		private var _distanceTravelled:Number = 0;
		private var _isActive:Boolean = true;

		[Embed(source="sprites/ufo.png")]		
		private var UfoSpriteImage:Class;

		
		public function Ufo(renderBox:Rectangle, activeRange:Number=0) {
			var spriteImage:Sprite = new Sprite();
			spriteImage.addChild(new UfoSpriteImage());
			
			// Set registration point to center
			addChild(spriteImage);
			spriteImage.transform.matrix = new Matrix(1, 0, 0, 1, -(spriteImage.width / 2), -(spriteImage.height / 2));

			// Set active range (for instance, 2 screens: screen.width * 2)
			_activeRange = activeRange;
			
			// Set random turn distance so that it would appear that UFO changed the direction
			// of flight
			_turnDistance = Math.random() * _activeRange / 2;
			
			// Pick random angle and adjust initial coordinates according to
			// angle value
			_angle = Math.random() * (2 * Math.PI);
			if ((_angle > (Math.PI / 2)) && (_angle <= (Math.PI * 1.5))) {
				this.x = renderBox.width + this.width/2;
			} else {
				this.x = renderBox.x - this.width / 2;
			}
			this.y = renderBox.height * Math.random();
		}
		
		// Check if UFO is still active
		public function isActive():Boolean {
			if (_activeRange > 0) {
				return _isActive;
			}
			return true;
		}
		
		// Render UFO
		public function render(renderBox:Rectangle):void
		{
			// Calculate vertical and horizontal velocity
			var _vx:Number = Math.cos(_angle) * _velocity;
			var _vy:Number = Math.sin(_angle) * _velocity;
						
			this.x += _vx;
			this.y += _vy;
			
			_distanceTravelled += Math.sqrt(_vx * _vx + _vy * _vy);

			// If we passed turn point - turn TURN!!!
			if (_distanceTravelled > _turnDistance) {
				// and by turning we simply peak a new random angle, think crazy UFO
				// cwaaaazy maaaaan woohooo ;)
				_angle = Math.random() * (2 * Math.PI);
				_turnDistance += _distanceTravelled;
			}
			
			// Screen wrapping check
			if (this.x - this.width/2 > renderBox.width)
			{
				if (!updateActiveStatus()) return;
				this.x = renderBox.x + this.width / 2;
			} else if (this.x + this.width / 2 < renderBox.x) {
				if (!updateActiveStatus()) return;
				this.x = renderBox.width - this.width / 2;
			}
			if (this.y + this.height/2 < renderBox.y)
			{
				if (!updateActiveStatus()) return;
				this.y = renderBox.height - this.height / 2;
			} else if (this.y - this.height / 2 > renderBox.height) {
				if (!updateActiveStatus()) return;
				this.y = renderBox.y + this.height / 2;
			}
		}
		
		private function updateActiveStatus():Boolean {
			if (_distanceTravelled > _activeRange) {
				_isActive = false;
			}
			return _isActive;
		}
	}
}
