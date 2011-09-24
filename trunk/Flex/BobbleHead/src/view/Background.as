package view
{
	import flash.events.Event;
	
	public class Background extends Character
	{
		public function Background()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/back.jpg";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			this.scaleX = 700.0/300;
			this.scaleY = 700.0/300;
			super.onCreationComplete(e);
		}
	}
}