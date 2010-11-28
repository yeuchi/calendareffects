package Renderers
{
	import Util.Point3D;
	
	import flash.geom.Point;
	
	import mx.core.UIComponent;

	public class Flake extends Point3D
	{
		protected var uic:UIComponent;
		protected var radius:Number;
		protected var _magnitude:Number;
		public var adder:Number=0;
		protected var max:Number;
		
		public function Flake(angleX:Number,
							  angleY:Number,
							  angleZ:Number,
							  r:Number,
							  ui:UIComponent) {
			z=0;
			radius = r;
			uic = ui;
			_magnitude = radian( Math.random() * 5);
			polar2Cartesian(angleX, angleY, angleZ);
			max = radian(5);
		}
		
		public function set magnitude(value:Number):void {
			_magnitude += value;
			_magnitude = (_magnitude>max)?max:_magnitude;
		}
		
		public function travel():void {
			
			if(adder>0) {
				// need to change distance from center in a random way.
				adder /=2;
				rotateY(Math.random()*_magnitude);
				rotateX(Math.random()*_magnitude);
				rotateZ(Math.random()*_magnitude);
			}
			else if(_magnitude < 1) {
				rotateY(_magnitude *= (1-Math.random()*.01));
				rotateX(_magnitude);
				rotateZ(_magnitude);
				gravity();
			}
			else {
				rotateY(_magnitude *= .99);
				rotateX(_magnitude);
				rotateZ(_magnitude);
			}
			uic.graphics.drawCircle(x+radius, y+radius, 2);
		}
		
		protected function gravity():void {
			if(Point3D.distance(this, new Point3D())<(radius*.95)||y<0) 
				this.y +=.25;
		}
		
		public function polar2Cartesian( angleX:Number, 
											angleY:Number,
											angleZ:Number)
											:void {
			var rad:Number = radian(angleX);	
			var p:Point = Point.polar(ceiling(.9, Math.random())*radius, rad);
			this.x = p.x;
			this.y = p.y;
			
			rotateY(radian(angleY));		// distribute the particles in z direction randomly.
			rotateZ(radian(angleZ));
		}
		
		private function ceiling(max:Number, 
								 value:Number)
			:Number {
			return (value>max)?max:value;
		}
		
		protected function rotateX(rad:Number):void {
			var ty:Number = y;
			var tz:Number = z;
			y = Math.cos(rad)*ty-Math.sin(rad)*tz;
			z = Math.sin(rad)*ty+Math.cos(rad)*tz;
		}
		
		protected function rotateY(rad:Number):void {
			var tx:Number = x;
			var tz:Number = z;
			x = Math.cos(rad)*tx+Math.sin(rad)*tz;
			z = -Math.sin(rad)*tx+Math.cos(rad)*tz;
		}
		
		protected function rotateZ(rad:Number):void {
			var tx:Number = x;
			var ty:Number = y;
			x = Math.cos(rad)*tx-Math.sin(rad)*ty;
			y = Math.sin(rad)*tx+Math.cos(rad)*ty;
		}
		
		protected function radian(degree:Number):Number {
			return Math.PI / 180 * degree;
		}
	}
}