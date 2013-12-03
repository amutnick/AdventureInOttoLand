package levels
{
	import citrus.utils.AGameData;
	
	public class MyGameData extends AGameData
	{
		public function MyGameData()
		{
			super();
			
			_levels = [[Level1, "levels/level1.swf"], [Level2, "levels/level1.swf"]]
		}
		
		public function get levels():Array
		{
			return _levels;
		}
	}
}