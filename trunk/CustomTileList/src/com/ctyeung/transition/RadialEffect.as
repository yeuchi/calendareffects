//http://flexscript.wordpress.com/2008/09/16/flex-creating-custom-tweeneffect-objects-in-flex/
package com.ctyeung.transition
{
    import mx.effects.IEffectInstance;
    import mx.effects.TweenEffect; 

    public class RadialEffect extends TweenEffect
    {
       public var posFrom:Array;
       public var posTo:Array;
  
       // Define constructor with optional argument.
       public function RadialEffect(targetObj:* = null) {
           super(targetObj);
           instanceClass= RadialTweenInstance;            
       }

       // Override getAffectedProperties() method to return "rotation".
       override public function getAffectedProperties():Array {
           return [];
       }
    
       // Override initInstance() method.
       override protected function initInstance(inst:IEffectInstance):void {
           super.initInstance(inst);
           RadialTweenInstance(inst).posFrom = posFrom;
           RadialTweenInstance(inst).posTo = posTo;
       } 
    }
}