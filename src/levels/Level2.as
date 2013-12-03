package levels
{
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Contacts.b2PolygonContact;
	
	import citrus.core.CitrusEngine;
	import citrus.core.IState;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.displaylist.VirtualButton;
	import citrus.input.controllers.displaylist.VirtualJoystick;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2D;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import citrus.utils.Mobile;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.ACitrusCamera;
	import citrus.view.starlingview.StarlingCamera;
	
	import dragonBones.factorys.StarlingFactory;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;
	
	public class Level2 extends StarlingState
	{
		private var level:MovieClip;
		private var hero:Otto;
		private var fall:Sensor;
		private var reset:Boolean = false;
		private var camera:StarlingCamera;
		private var spikes:Sensor;
		private var goal:Sensor;
		private var state:IState;
		private var youWonGraffic:CitrusSprite;
		private var _jewels:Object;
		private var factory:StarlingFactory;
		
		[Embed(source="../particle/texture.png")]
		protected const fireTex:Class;
		
		[Embed(source="../particle/particle.pex", mimeType="application/octet-stream")]
		protected const firePex:Class;
		private var fireParticle:PDParticleSystem;
		private var flame:CitrusSprite;
		
		
		public function Level2(lvl:MovieClip)
		{
			super();
			
			level = lvl;
			var objectsUsed:Array = [Hero,Platform,Sensor,Crate,Enemy,Coin,MovingPlatform];
		}
		
	
		
		override public function initialize():void
		{
			super.initialize();
			_ce.sound.playSound("gameSong");
			var physics:Box2D = new Box2D("physics");
			//physics.visible = true;
			add(physics);
			
			ObjectMaker2D.FromMovieClip(level);
			
			hero = new Otto("hero", {x:37, y:620, width:66, height:92, view:"../sprites/front.png"});
			add(hero);
			hero.onTakeDamage.add(onTakeDamage);
			
			fall = getObjectByName("fall") as Sensor;
			fall.onBeginContact.add(onFall);

			_jewels = getObjectsByType(Coin);
			for each (var jewel:Coin in _jewels)
			jewel.onBeginContact.add(handleJewelCollected);
			
			fireParticle = new PDParticleSystem(XML(new firePex()), Texture.fromBitmap(new fireTex()));
			fireParticle.start();
			
			flame = new CitrusSprite("flame",{view: fireParticle, x:1301, y: 375, height: 90, width: 90 });
		//	add(flame);
			
			spikes = getObjectByName("spike") as Sensor;
			spikes.onBeginContact.add(onSpike);
			
			goal = getObjectByName("finish") as Sensor;
			goal.onBeginContact.add(onComplete);
			
			camera = view.camera as StarlingCamera;
			camera.setUp(hero, new Point(stage.stageWidth >> 1, stage.stageHeight >> 1), new Rectangle(0,0,3000,800), new Point(.2,.2));
			camera.allowRotation = true;
			camera.allowZoom = true;
			camera.parallaxMode = ACitrusCamera.PARALLAX_MODE_TOPLEFT;
		
		
			if (Mobile.isAndroid()) {
				trace("Is Andriod");
				var vj:VirtualJoystick = new VirtualJoystick("joy",{radius:120});
				vj.circularBounds = true;
				
				
				var vb:VirtualButton = new VirtualButton("buttons",{buttonradius:40});
			
				vb.buttonAction = "jump";
			
			}
		}
		
		private function onTakeDamage():void
		{
			_ce.sound.playSound("ouch");
		}
		
		private function handleJewelCollected(contact:b2Contact):void {
			
			var self:IBox2DPhysicsObject;
			for each (var jewel:Coin in _jewels) {
				
				self = Box2DUtils.CollisionGetSelf(jewel, contact);
				
				if (self == jewel)
					break;
			}
			
			if (Box2DUtils.CollisionGetOther(self, contact) != hero)
				return;
			
			_ce.sound.playSound("Collect");
			
			
		}
		
		private function onComplete(c:b2PolygonContact):void
		{
			if(Box2DUtils.CollisionGetOther(goal,c) is Hero){
				killAllObjects();
				
			}
		}
		
		private function onSpike(c:b2PolygonContact):void
		{
			if(Box2DUtils.CollisionGetOther(spikes,c) is Hero){
				_ce.sound.playSound("die");
				reset = true;
				
			}
		}
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta)
			
			if(reset)
			{
				resetHero(108,439);
				
			}
				
		}
		
		private function resetHero(x:int, y:int):void
		{
			hero.x = x;
			hero.y = y; 
			reset = false;
		}
		
		private function onFall(c:b2PolygonContact):void
		{
			if(Box2DUtils.CollisionGetOther(fall,c) is Hero){
				reset = true;
				CitrusEngine.getInstance().sound.playSound("fall");
				
			}
			
			
		}
	}
}