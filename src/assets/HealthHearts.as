package assets
{
	import citrus.objects.CitrusSprite;
	
	public class HealthHearts extends CitrusSprite
	{
		private var _healthHeart:CitrusSprite;
		private var _spaceing:int = 10;
		public function HealthHearts(name:String, params:Object=null)
		{
			super(name, params);
			for(var i:int = 0; i > 3 ; i++)
			{
				_healthHeart = new CitrusSprite("full_Heart",{view:"../sprites/heart_full.png", height: 30, width: 30});
				
			}
			
		}
	}
}