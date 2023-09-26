package
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class SpaceshipBase extends Sprite
	{
		private var vr:Number = 0;
		private var thrust:Number = 0;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var _collisionState:Boolean = false;

		public function SpaceshipBase(ship:SpaceshipBase=null)
		{
			super();
			// If ship is not null - construct based on ship properties
			if (ship != null)
			{
				this.rotation = ship.rotation;
				this.x = ship.x;
				this.y = ship.y;
				this.vr = ship.vr;
				this.thrust = ship.thrust;
				this.vx = ship.vx;
				this.vy = ship.vy;
			}			
		}
		
		public function get collisionState():Boolean {
			return _collisionState;
		}
		
		public function set collisionState(state:Boolean):void {
			_collisionState = state;
		}
		
		public function get velocityX():Number {
			return vx;
		}
		
		public function get velocityY():Number {
			return vy;
		}
		
		public function rotationLeft():void
		{
			this.vr = -10;
		}
		
		public function rotationRight():void
		{
			this.vr = 10;
		}
		
		public function rotationStop():void
		{
			this.vr = 0;
		}

		public function thrustStart():void
		{
			this.thrust = 0.5;
		}
		
		public function thrustStop():void
		{
			this.thrust = 0;
		}
		
		// Renders spaceship inside renderBox boundaries
		public function render(renderBox:Rectangle):void
		{
			this.rotation += vr;
			
			var angle:Number = (this.rotation - 90) * Math.PI / 180;
			var ax:Number = Math.cos(angle) * thrust;
			var ay:Number = Math.sin(angle) * thrust;
			
			vx += ax;
			vy += ay;
			
			this.x += vx;
			this.y += vy;
			
			
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