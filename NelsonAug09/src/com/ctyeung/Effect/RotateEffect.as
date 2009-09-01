// ==================================================================
// Module:		RotateEffect
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
    import mx.effects.IEffectInstance;
    import mx.effects.TweenEffect; 

    public class RotateEffect extends TweenEffect
    {
       public var posFrom:Array;
       public var posTo:Array;
  
       // Define constructor with optional argument.
       public function RotateEffect(targetObj:* = null) {
           super(targetObj);
           instanceClass= RotateTweenInstance;            
       }

       // Override getAffectedProperties() method to return "rotation".
       override public function getAffectedProperties():Array {
           return [];
       }
    
       // Override initInstance() method.
       override protected function initInstance(inst:IEffectInstance):void {
           super.initInstance(inst);
           RotateTweenInstance(inst).posFrom = posFrom;
           RotateTweenInstance(inst).posTo = posTo;
       } 
    }
}