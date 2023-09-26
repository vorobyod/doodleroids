package  
{
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Dennis Granau
	 */
	public class GameScoreIndicator extends Sprite
	{	
		[Embed(source="sprites/digits/d0.png")]
		private var LCD0:Class;

		[Embed(source="sprites/digits/d1.png")]
		private var LCD1:Class;

		[Embed(source="sprites/digits/d2.png")]
		private var LCD2:Class;

		[Embed(source="sprites/digits/d3.png")]
		private var LCD3:Class;

		[Embed(source="sprites/digits/d4.png")]
		private var LCD4:Class;

		[Embed(source="sprites/digits/d5.png")]
		private var LCD5:Class;

		[Embed(source="sprites/digits/d6.png")]
		private var LCD6:Class;
		
		[Embed(source="sprites/digits/d7.png")]
		private var LCD7:Class;

		[Embed(source="sprites/digits/d8.png")]
		private var LCD8:Class;

		[Embed(source="sprites/digits/d9.png")]
		private var LCD9:Class;

		private var lcdConvertTable:Array;
		private var right:Number;
		
		public function GameScoreIndicator(score:uint, right:Number, top:Number) 
		{
			this.right = right;
			this.y = top;			
			update(score);
		}
		
		public function update(score:uint):void {
			var i:uint = 0;
			var digitString:String;
			var digitSprite:Sprite;
			var classReference:Class;
			var scoreString:String = score.toString();
			
			while( this.numChildren > 0 ) {
				this.removeChildAt(0);
			}

			var sprite_x:Number = 0;			
			for (i = 0; i < scoreString.length; i++ ) {
				digitString = scoreString.charAt(i);
				digitSprite = new Sprite();
				digitSprite.addChild(new this["LCD" + digitString]);
				digitSprite.x = sprite_x + digitSprite.width * i;
				digitSprite.y = 0;
				addChild(digitSprite);
			}
			this.x = this.right - this.width;
		}
		
	}

}