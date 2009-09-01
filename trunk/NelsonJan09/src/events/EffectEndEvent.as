package events
{
	import flash.events.Event;

	public class EffectEndEvent extends Event
	{
		public static const EFFECT_END:String = "effectEnd";

		public function EffectEndEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new EffectEndEvent(type);
		}
		
	}
}