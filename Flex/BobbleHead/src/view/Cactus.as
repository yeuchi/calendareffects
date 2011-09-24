package view
{
	import flash.events.Event;
	
	public class Cactus extends Character
	{
		public function Cactus()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/cactus.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = 56;
			this.y = 78;
		}
	}
}