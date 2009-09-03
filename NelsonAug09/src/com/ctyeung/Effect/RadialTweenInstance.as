// ==================================================================
// Module:		RotateTweener
//
// Description:	Tweener impelementation for radial travel.
//				Adobe code modified
//
// Reference:	http://flexscript.wordpress.com/2008/09/16/flex-creating-custom-tweeneffect-objects-in-flex/
//
// Author(s):	Adobe
//				C.T. Yeung			cty 
//
// History:		Modified for use in August09 calendar and RadialTileList	cty
// ==================================================================
package com.ctyeung.Effect
{
    import mx.effects.Tween;
    import mx.effects.effectClasses.TweenEffectInstance;

    public class RadialTweenInstance extends TweenEffectInstance
    {
    	public static const ANGLE_INDEX:int = 0;
    	public static const RADIUS_INDEX:int = 1;
    	public static const CENTER_X_INDEX:int = 2;
    	public static const CENTER_Y_INDEX:int = 3;
    	
        // Define parameters for the effect.
        public var posFrom:Array;
        public var posTo:Array;
  
  
        public function RadialTweenInstance(targetObj:*) {
            super(targetObj);
        }
  
        // Override play() method class.
        override public function play():void {
            // All classes must call super.play().
            super.play();
            // Create a Tween object. The tween begins playing immediately.
            var tween:Tween = 
                createTween(this, posFrom, posTo, duration);  
        }

        // Override onTweenUpdate() method.
        override public function onTweenUpdate(val:Object):void {

            var angle:Number = radian(val[ANGLE_INDEX]);
            var centerX:Number = val[CENTER_X_INDEX];
            var centerY:Number = val[CENTER_Y_INDEX];
            target.x = Math.cos(angle)*(val[RADIUS_INDEX])+centerX;//+Math.sin(angle)*(val[1]+wid);
            target.y = Math.sin(angle)*(val[RADIUS_INDEX])+centerY;//+Math.cos(angle)*(val[1]+len);
        }
        
        protected function radian(degree:Number):Number
        {
            return Math.PI / 180 * degree;
        }
  
        // Override onTweenEnd() method.
        override public function onTweenEnd(val:Object):void {
            // All classes that implement onTweenEnd() 
            // must call    super.onTweenEnd().
            super.onTweenEnd(val);
        }
    }
}
