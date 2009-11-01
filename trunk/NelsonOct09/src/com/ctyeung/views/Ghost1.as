package com.ctyeung.views
{
	import flash.events.Event;
	
	public class Ghost1 extends Character
	{
		public function Ghost1()
		{
			this.urlStr = "http://www.ctyeung.com/flex/peanut/Oct09/assets/ghost1.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
		}
	}
}