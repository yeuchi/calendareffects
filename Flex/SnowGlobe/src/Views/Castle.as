package Views
{
	import flash.events.Event;
	
	public class Castle extends Character
	{
		public function Castle()
		{
			this.urlStr = "http://www.ctyeung.com/flex/SnowGlobe/assets/DisneyCastleDistorted.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = 100;
			this.y = 50;
		}
		
	}
}