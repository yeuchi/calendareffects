package view
{
	import flash.events.Event;
	
	public class HeadMarcia extends Character
	{
		public function HeadMarcia()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/marciaHeadSmall.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = 560;
			this.y = 310;
			this.rotation = HEAD_ANGLE;
		}
	}
}