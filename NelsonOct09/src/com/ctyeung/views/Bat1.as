package com.ctyeung.views
{
	import flash.events.Event;
	
	public class Bat1 extends Character
	{
		public function Bat1()
		{
			this.urlStr = "http://www.ctyeung.com/flex/peanut/Oct09/assets/bat1.png";
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
		}
	}
}