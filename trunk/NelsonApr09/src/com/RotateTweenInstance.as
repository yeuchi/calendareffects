package com
{
	import mx.effects.Tween;
	import mx.effects.effectClasses.TweenEffectInstance;

	public class RotateTweenInstance extends TweenEffectInstance
	{
		// Define parameters for the effect.
        public var posFrom:Array;
        public var posTo:Array;
  
  
        public function RotateTweenInstance(targetObj:*) {
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

        	var angle:Number = radian(val[0]);
        	target.x = Math.cos(angle)*(target.x+100)-Math.sin(angle)*(target.y-100);
			target.y = Math.sin(angle)*(target.x+100)+Math.cos(angle)*(target.y-100);
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