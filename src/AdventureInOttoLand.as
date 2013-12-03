package
{
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.input.controllers.displaylist.VirtualJoystick;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import levels.Level1;
	import levels.MyGameData;
	
	import starling.events.Touch;
	
	[SWF(height="800", width="1024", frameRate="60", backgroundColor="0xDBF2F9")]	
	
	public class AdventureInOttoLand extends StarlingCitrusEngine
	{
		
		private var loader:Loader;
		private var vJoy:VirtualJoystick;
		
		public function AdventureInOttoLand()
		{
			super();
			
			stage ? init() :addEventListener(Event.ADDED_TO_STAGE, onStage);
			
		}
		
		private function init():void
		{
			setUpStarling(true);
			
			sound.addSound("fall", {sound:"../sounds/Falling.mp3"});
			sound.addSound("Collect", {sound:"../sounds/coin1.mp3"});
			sound.addSound("die", {sound:"../sounds/Death.mp3"});
			sound.addSound("gameSong", {sound:"../sounds/gameSong.mp3",playing: -1});
			sound.addSound("ouch", {sound:"../sounds/ouch.mp3"});
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoad);
			loader.load(new URLRequest("../levels/level1.swf"));
			
			gameData = new MyGameData();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private function onStage():void
		{
			setUpStarling(true);
			
		}
		
		protected function onLoad(event:Event):void
		{
			state = new Level1(event.target.loader.content);
			
			loader.removeEventListener(Event.COMPLETE,onLoad);
			//loader.unloadAndStop(true);
			
		}
		
		
		
		
	}
}