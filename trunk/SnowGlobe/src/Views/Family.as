package Views
{
	import flash.events.Event;
	
	public class Family extends Character
	{
		public function Family()
		{
			this.urlStr = "http://www.ctyeung.com/flex/SnowGlobe/assets/miceDistorted.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = 140;
			this.y = 390;
		}
		
	}
}