// ==================================================================
//	Module:			RadialMove.as
//
//  Description:	radial move effect extending custom tween
//
//  Author(s):		C.T. Yeung				cty
//
//
//	About:			This is for RadialTileTest component, an exercise only.
//					Source free to distribute as will.
//
//	History:
// 23Aug09			start coding								cty
// ==================================================================
package com.ctyeung.Effect
{
	import flash.geom.Point;
	
	public class RadialMove extends RadialEffect
	{
		public function RadialMove(target:Object=null,
								   center:Point=null,
								   angleFrom:Number=0,
								   angleTo:Number=0,
								   radius:Number=0)
		{
			super();
			posFrom = [0,0,0];
			posTo   = [0,0,0];
			
			if(target)	this.target = target;
			if(angleFrom) posFrom[RadialTweenInstance.ANGLE_INDEX] = angleFrom;
			if(angleTo)	  posTo[RadialTweenInstance.ANGLE_INDEX] = angleTo;
			if(radius) {
				 posFrom[RadialTweenInstance.RADIUS_INDEX] = radius;
				 posTo[RadialTweenInstance.RADIUS_INDEX] = radius;			
			}	 
			if(center) {
				posFrom[RadialTweenInstance.CENTER_X_INDEX] = center.x;
				posFrom[RadialTweenInstance.CENTER_Y_INDEX] = center.y;
				posTo[RadialTweenInstance.CENTER_X_INDEX] = center.x;
				posTo[RadialTweenInstance.CENTER_Y_INDEX] = center.y;
			}
			
		}
		
/////////////////////////////////////////////////////////////////////
// properties

		public function set angleFrom(degrees:Number):void {
			posFrom[RadialTweenInstance.ANGLE_INDEX] = degrees;
		}	
		
		public function get angleFrom():Number {
			return posFrom[RadialTweenInstance.ANGLE_INDEX];
		}
		
		public function set angleTo(degrees:Number):void {
			posTo[RadialTweenInstance.ANGLE_INDEX] = degrees;
		}
		
		public function get angleTo():Number {
			return posTo[RadialTweenInstance.ANGLE_INDEX];
		}
		
		public function set radius(pixels:Number):void {
			posFrom[RadialTweenInstance.RADIUS_INDEX] = pixels;
			posTo[RadialTweenInstance.RADIUS_INDEX] = pixels;
		}
		
		public function get radius():Number {
			return posFrom[RadialTweenInstance.RADIUS_INDEX];
		}
		
		public function set center(midPoint:Point):void {
			posFrom[RadialTweenInstance.CENTER_X_INDEX] = midPoint.x;
			posFrom[RadialTweenInstance.CENTER_Y_INDEX] = midPoint.y;
			posTo[RadialTweenInstance.CENTER_X_INDEX] = midPoint.x;
			posTo[RadialTweenInstance.CENTER_Y_INDEX] = midPoint.y;
		}
		
		public function get center():Point {
			return new Point(posFrom[RadialTweenInstance.CENTER_X_INDEX],
							 posFrom[RadialTweenInstance.CENTER_Y_INDEX]);
		}
	}
}