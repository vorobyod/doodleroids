
package {
	import flash.display.Sprite;
	
	public class LivesIndicator extends Sprite {
		private var lives:Array = new Array();
		
		public function LivesIndicator(livesCnt:uint, x:Number, y:Number) {
			this.x = x;
			this.y = y;
			drawIndicator(livesCnt);
		}
		
		public function update(livesCnt:uint):void {
			var i:uint;
			for (i=0; i < lives.length; i++) {
				removeChild(lives[i]);
			}
			lives = new Array();
			drawIndicator(livesCnt);
		}
		
		private function drawIndicator(livesCnt:uint):void {
			var i:uint;
			var sprite:Sprite;
			
			var sprite_x:Number = 0;
			for (i=0; i < livesCnt; i++) {
				sprite = new OneSpaceshipLive();
				sprite.x = sprite_x + sprite.width * i;
				sprite.y = 0;
				lives.push(sprite);
				addChild(sprite);
			}
		}
	}
}