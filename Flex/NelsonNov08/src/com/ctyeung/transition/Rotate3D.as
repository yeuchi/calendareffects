// ==================================================================
//	Module:			Rotate3D.as
//
//  Description:	rotate x,y,z effect extending custom tween
//
//  Author(s):		C.T. Yeung				cty
//
//	History:
// 04Sep09			start coding								cty
// ==================================================================
package com.ctyeung.transition
{
	import flash.geom.Point;
	
	public class Rotate3D extends Rotate3DEffect
	{
		public function Rotate3D(target:Object=null,
								 xFrom:Number=0,
								 yFrom:Number=0,
								 zFrom:Number=0,
								 xTo:Number=0,
								 yTo:Number=0,
								 zTo:Number=0)
		{
			super();
			
			posFrom = [xFrom, yFrom, zFrom];
			posTo   = [xTo, yTo, zTo];
		}
		
/////////////////////////////////////////////////////////////////////
// properties

		public function set angleXFrom(x:Number):void {
			posFrom[Rotate3DTweenInstance.X_INDEX] = x;
		}
		
		public function set angleYFrom(y:Number):void {
			posFrom[Rotate3DTweenInstance.Y_INDEX] = y;
		}
		
		public function set angleZFrom(z:Number):void {
			posFrom[Rotate3DTweenInstance.Z_INDEX] = z;
		}
		
		public function set angleXTo(x:Number):void {
			posTo[Rotate3DTweenInstance.X_INDEX] = x;
		}
		
		public function set angleYTo(y:Number):void {
			posTo[Rotate3DTweenInstance.Y_INDEX] = y;
		}
		
		public function set angleZTo(z:Number):void {
			posTo[Rotate3DTweenInstance.Z_INDEX] = z;
		}
	}
}