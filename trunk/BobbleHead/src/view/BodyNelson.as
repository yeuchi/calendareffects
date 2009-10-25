package view
{
	import flash.events.Event;
	
	public class BodyNelson extends Character
	{
		public function BodyNelson()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/nelsonBodySmall.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = 300;
			this.y = 380;
		}
		
	}
}