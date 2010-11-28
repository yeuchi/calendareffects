package Events
{
	import flash.events.Event;

	public class PhotoServiceEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "loadComplete";
		
		public function PhotoServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new PhotoServiceEvent(type);
		}
	}
}