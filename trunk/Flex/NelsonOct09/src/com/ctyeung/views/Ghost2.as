package com.ctyeung.views
{
	import flash.events.Event;
	
	public class Ghost2 extends Character
	{
		public function Ghost2()
		{
			this.urlStr = "http://www.ctyeung.com/flex/peanut/Oct09/assets/ghost2.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
		}
	}
}