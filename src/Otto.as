package
{
	import citrus.core.CitrusObject;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Hero;
	
	import flash.net.getClassByAlias;
	
	import starling.display.Quad;
	
	public class Otto extends Hero
	{
		private var _healthHeart:CitrusSprite;
		private var heartArray:Array;
		private var hb:CitrusSprite;
		
		public function Otto(name:String, params:Object=null)
		{
			super(name, params);
			onTakeDamage.add(takeDamege)
		}
		
		private function takeDamege():void
		{
			hb.width - 10;
			_ce.state.add(hb);
		}
		
		override public function initialize(poolObjectParams:Object = null):void
		{
			super.initialize(poolObjectParams);
		
			hb = new CitrusSprite("hb",{view: new Quad(100,15,0xae2a00)});
			_ce.state.add(hb);
			
			
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			hb.x = x - 20;
			hb.y = y - height / 2 - 30;
			
		}
	}
}