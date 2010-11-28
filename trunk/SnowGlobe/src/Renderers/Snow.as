package Renderers
{
	import Util.Point3D;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.UIComponent;

	public class Snow extends UIComponent
	{
		public var globeCenter:Point;				// this center
		public var radius:Number;					// this radius
		
		protected var _magnitude:Number;			// keep track of how much travel a user shakes the globe.
		protected var _travelAngle:Number;			// mean angle of travel a user shakes the globe.
		
		protected var count:int = 700;				// number of snow flakes
		protected var list:Array;					// container of snow flakes' position/size
		protected var sunk:Boolean = true;			
		private static const PAD:int = 12;
		private var radiusSQ:Number;
		
		public function Snow(center:Point,
							 radius:Number) {
			globeCenter = center;
			this.radius = radius;
			this.width = radius*2;
			this.height = radius*2;
			radiusSQ = (radius - PAD)*(radius-PAD);
			
			list = new Array();
			super();
			init();
		}
		
		protected function init():void {
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			
			for (var i:int = 0; i<count; i++) {
				var flake:Flake = new Flake(Math.random()*360,
											Math.random()*360,
											Math.random()*360,
											radius,
											this);		
				list.push(flake);
			}
			sunk = false;		// temporary setting for test
		}
		
		// accumulate magnitude until travel angle change
		public function set magnitude(travel:Number):void {
			for (var i:int=0; i<list.length; i++) {
				var flake:Flake = list[i] as Flake;
				var h:Number = travel/100 * Math.random();
				flake.magnitude = h;
				flake.adder += h;
			}
		}
		
		public function set travelAngle(degree:Number):void {
			
		}
		
		protected function onEnterFrame(e:Event):void {
			this.graphics.clear();
			this.graphics.beginFill(0xFFFFFF, 1);
			for ( var i:int = 0; i < list.length; i ++ ) {
				(list[i] as Flake).travel();
			}
			this.graphics.endFill();
		}
	}
}