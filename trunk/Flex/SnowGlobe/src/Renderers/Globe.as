package Renderers
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import mx.core.UIComponent;

	public class Globe extends UIComponent {
		public var radius:Number;
		public var ptOrig:Point;
		public var ptDown:Point;
		
		public var mouseDown:Boolean = false;	// where user place mouse down
		
		protected var index:int = 0;
    	protected var ptPanel:Point;
    	protected var wid:int = 100;
		protected var uicSnow:Snow;
		protected var photos:Photos;
		
		public function Globe(wid:int, len:int)
		{
			super();
			drawGlobe(wid, len);
			photos = new Photos();
			photos.width = radius * 2;
			init();
		}
		
		public function set magnitude(travel:Number):void {
			if(uicSnow)
				uicSnow.magnitude = travel;
		}
		
		public function set travelAngle(degree:Number):void {
			if(uicSnow)
				uicSnow.travelAngle = degree;
		}
		
		protected function drawGlobe(wid:int, len:int):void {
			radius = (wid<len)?wid/2.0:len/2.0;
			this.width = radius * 2;
			this.height = radius * 2;
			ptOrig = new Point();
			ptOrig.x = this.x = wid/2.0-radius;
			ptOrig.y = this.y = len/2.0-radius;
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [0xFFFFFF, 0xD234AA];
			var alphas:Array = [.5, .5];
  			var ratios:Array = [0x00, 0xFF];
  			var matr:Matrix = new Matrix();
  			matr.createGradientBox(radius*2, radius*1.8);
  			var spreadMethod:String = SpreadMethod.PAD;
  			this.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
  			this.graphics.drawCircle(radius,radius,radius);
		}
		
		public function init():void {
			ptDown = new Point();
			ptPanel = new Point();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			uicSnow = new Snow(new Point(this.x+this.radius, this.y+this.radius), this.radius);
			this.addChild(uicSnow);
		}
		
		protected function onEnterFrame(e:Event):void {
			if(!mouseDown)
				center();
		}
		
		public function drag(mouseX:int, mouseY:int):void {
			this.x = ptOrig.x + (mouseX-ptDown.x);
			this.y = ptOrig.y + (mouseY-ptDown.y);
			
			this.magnitude = Math.sqrt((mouseX-ptDown.x)*(mouseX-ptDown.x)+
										(mouseY-ptDown.y)*(mouseY-ptDown.y));
		}
		
		public function center():void {
			if(ptOrig.x != this.x) 
				this.x += (ptOrig.x - this.x)*.1;
			
			if(ptOrig.y != this.y)
				this.y += (ptOrig.y - this.y)*.1;
		}
	}
}