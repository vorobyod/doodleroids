package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Dennis Granau
	 */
	
	public class OneSpaceshipLive extends Sprite {
		[Embed(source="sprites/spaship_live.png")]
		private var SpriteImage:Class;
		
		public function OneSpaceshipLive() {
			addChild(new SpriteImage());
		}
	}

}