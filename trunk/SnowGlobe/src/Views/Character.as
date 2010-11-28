package Views
{
	import Events.CharacterEvent;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	[Event(name="loadComplete", type="Events.CharacterEvent")]
	
	public class Character extends UIComponent
	{
		public static const HEAD_ANGLE:Number = -135;
		public var loader:Loader;
		public var urlStr:String;
		
		public function Character()
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete, false, 0, true);
		}
		
		protected function onCreationComplete(e:Event):void {
			loader = new Loader();
			loader.load(new URLRequest(urlStr));
			this.addChild(loader);
			loader.loaderInfo.addEventListener(Event.COMPLETE, onLoadComplete, false, 0, true);
		}
		
		protected function onLoadComplete(e:Event):void {
			var charEvent:CharacterEvent = new CharacterEvent(CharacterEvent.LOAD_COMPLETE);
			dispatchEvent(charEvent);
		}
	}
}