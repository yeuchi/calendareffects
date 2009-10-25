package view
{
	import flash.events.Event;
	
	public class BodyCT extends Character
	{
		public function BodyCT()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/ctBodySmall.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = 150;
			this.y = 300;
		}
		
	}
}