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
package com.ctyeung.transition
{
    import flash.geom.Point;
    
    import mx.core.Application;
    import mx.effects.Tween;
    import mx.effects.effectClasses.TweenEffectInstance;

    public class Rotate3DTweenInstance extends TweenEffectInstance
    {
    	public static const X_INDEX:int = 0;
    	public static const Y_INDEX:int = 1;
    	public static const Z_INDEX:int = 2;
    	
        // Define parameters for the effect.
        public var posFrom:Array;
        public var posTo:Array;
  
  
        public function Rotate3DTweenInstance(targetObj:*) {
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

			target.rotationX = val[X_INDEX];
			target.rotationY = val[Y_INDEX];
			target.rotationZ = val[Z_INDEX];
        }
        
        // Override onTweenEnd() method.
        override public function onTweenEnd(val:Object):void {
            // All classes that implement onTweenEnd() 
            // must call    super.onTweenEnd().
            super.onTweenEnd(val);
        }
    }
}
