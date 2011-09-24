package Util
{
	import flash.geom.Point;

	public class Point3D
	{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		//public var m:Number;
		
		public function Point3D(x:Number=0, 
								y:Number=0, 
								z:Number=0)
								//m:Number=0)
		{
			this.x = x;
			this.y = y;
			this.z = z;
			//this.m = m;
		}
		
		static public function distance(p0:Point3D,
									    p1:Point3D)
										:Number {
			return Math.sqrt(Math.pow(p0.x-p1.x,2)+Math.pow(p0.y-p1.y,2)+Math.pow(p0.z-p1.z,2));
		}
		
	}
}