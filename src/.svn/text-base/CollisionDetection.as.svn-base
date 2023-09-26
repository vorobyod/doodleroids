package
{
	import flash.display.Sprite;

	public class CollisionDetection
	{
		public static function detect(sprite1:Sprite, sprite2:Sprite):Boolean
		{
			// Will do ditance-based collision detection
			// For now assuming that all sprites are square
			var radius1:Number = Math.round(sprite1.width / 2);
			var radius2:Number = Math.round(sprite2.width / 2);
			var distance:Number = radius1 + radius2;
			var dx:Number = Math.abs(sprite1.x - sprite2.x);
			var dy:Number = Math.abs(sprite1.y - sprite2.y);
			return (Math.sqrt(dx * dx + dy * dy) < distance) ? true : false;
		}		
	}
}
