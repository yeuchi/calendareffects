package Views
{
	import flash.events.Event;
	
	public class CT extends Character
	{
		public function CT()
		{
			this.urlStr = "http://www.ctyeung.com/flex/SnowGlobe/assets/CT.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = 350;
			this.y = 370;
		}
		
	}
}