package
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Spaceship extends SpaceshipBase
	{
		[Embed(source="sprites/spaceship.png")]
		private var SpriteImage:Class;

		public function Spaceship(ship:SpaceshipBase=null)
		{
			super(ship);
			var spriteImage:Sprite = new Sprite();
			spriteImage.addChild(new SpriteImage());
			addChild(spriteImage);
			// Set registration point to center
			spriteImage.transform.matrix = new Matrix(1, 0, 0, 1, -(spriteImage.width/2), -(spriteImage.height/2));

		}
	}
}
