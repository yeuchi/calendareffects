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
		protected var _angleFrom:Number=0;		// [in] starting angle
		protected var _angleTo:Number=0;		// [in] destination angle
		protected var _radius:Number=0;			// [in] offset from center
		protected var _center:Point;			// [in] reference center from sweep
		
		public function RadialMove(target:Object=null,
								   center:Point=null,
								   angleFrom:Number=0,
								   angleTo:Number=0,
								   radius:Number=0)
		{
			super();
			_center = new Point();
			
			if(target)	this.target = target;
			if(center) {
				_center.x = center.x;
				_center.y = center.y;				
			}
			if(angleFrom) _angleFrom = angleFrom;
			if(angleTo)	  _angleTo = angleTo;
			if(radius)	  _radius = radius;
			
			posFrom = [_angleFrom, _radius, _center.x];
			posTo   = [_angleTo, _radius, _center.y];
		}
		
/////////////////////////////////////////////////////////////////////
// properties

		public function set angleFrom(degrees:Number):void {
			_angleFrom = degrees;
			posFrom[RadialTweenInstance.ANGLE_INDEX] = degrees;
		}	
		
		public function get angleFrom():Number {
			return _angleFrom;
		}
		
		public function set angleTo(degrees:Number):void {
			_angleTo = degrees;
			posTo[RadialTweenInstance.ANGLE_INDEX] = degrees;
		}
		
		public function get angleTo():Number {
			return _angleTo;
		}
		
		public function set radius(pixels:Number):void {
			_radius = pixels;
			posFrom[RadialTweenInstance.RADIUS_INDEX] = pixels;
			posTo[RadialTweenInstance.RADIUS_INDEX] = pixels;
		}
		
		public function get radius():Number {
			return _radius;
		}
		
		public function set center(midPoint:Point):void {
			_center.x = midPoint.x;
			_center.y = midPoint.y;
			posFrom[RadialTweenInstance.CENTER_X_INDEX] = midPoint.x;
			posFrom[RadialTweenInstance.CENTER_Y_INDEX] = midPoint.y;
			posTo[RadialTweenInstance.CENTER_X_INDEX] = midPoint.x;
			posTo[RadialTweenInstance.CENTER_Y_INDEX] = midPoint.y;
		}
		
		public function get center():Point {
			return _center;
		}
	}
}