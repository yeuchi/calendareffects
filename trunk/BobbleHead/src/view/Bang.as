package view
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	public class Bang extends Character
	{
		protected var soundBang:Sound;
		
		public function Bang()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/bangbang.png";
			super();
			soundBang = new Sound(new URLRequest("http://www.ctyeung.com/flex/BobbleHead/assets/soundBang.mp3"));
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
		}
		
		public function display():void {
			if(int(Math.random()*10) % 11 == 0) {
				this.x = Math.random() * 600;
				this.y = Math.random() * 600;
				this.rotation = Math.random() * 180;
				this.visible = !this.visible;
				if(visible)
				soundBang.play();
			}
		}
	}
}