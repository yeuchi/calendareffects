package Events
{
	import flash.events.Event;
	
	public class CharacterEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "loadComplete";
		
		public function CharacterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new CharacterEvent(type);
		}
	}
}