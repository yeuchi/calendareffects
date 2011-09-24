package com.ctyeung.views
{
	import flash.events.Event;
	
	public class Ghost3 extends Character
	{
		public function Ghost3()
		{
			this.urlStr = "http://www.ctyeung.com/flex/peanut/Oct09/assets/ghost3.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
		}
	}
}