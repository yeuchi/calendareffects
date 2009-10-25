package view
{
	import flash.events.Event;
	
	public class BodyMarcia extends Character
	{
		public function BodyMarcia()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/marciaBodySmall.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = 390;
			this.y = 190;
		}
		
	}
}