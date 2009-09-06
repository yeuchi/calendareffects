//http://flexscript.wordpress.com/2008/09/16/flex-creating-custom-tweeneffect-objects-in-flex/
package com.ctyeung.transition
{
    import mx.effects.IEffectInstance;
    import mx.effects.TweenEffect; 

    public class Rotate3DEffect extends TweenEffect
    {
       public var posFrom:Array;
       public var posTo:Array;
  
       // Define constructor with optional argument.
       public function Rotate3DEffect(targetObj:* = null) {
           super(targetObj);
           instanceClass= Rotate3DTweenInstance;            
       }

       // Override getAffectedProperties() method to return "rotation".
       override public function getAffectedProperties():Array {
           return [];
       }
    
       // Override initInstance() method.
       override protected function initInstance(inst:IEffectInstance):void {
           super.initInstance(inst);
           Rotate3DTweenInstance(inst).posFrom = posFrom;
           Rotate3DTweenInstance(inst).posTo = posTo;
       } 
    }
}