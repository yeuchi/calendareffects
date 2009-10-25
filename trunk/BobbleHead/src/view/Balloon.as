package view
{
	import flash.events.Event;
	
	import mx.effects.Fade;
	
	public class Balloon extends Character
	{
		protected var fadeIn:Fade;
		protected var fadeOut:Fade;
		
		public function Balloon()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/balloon.png";
			fadeIn = new Fade();
			fadeOut = new Fade();
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = 0;
			this.y = 50;
			
			fadeIn.target = this;
			fadeIn.alphaFrom = 0;
			fadeIn.alphaTo = 1;
			fadeIn.duration = 1000;
			
			fadeOut.target = this;
			fadeOut.alphaFrom = 1;
			fadeOut.alphaTo = 0;
			fadeOut.duration = 1000;
		}
		
		public function fly():void {
			this.x = (this.x > parentApplication.width)?0:this.x+1;
			if(Math.random() > .5 ){
				this.y = (this.y >= parentApplication.height-1)?parentApplication.height-1:this.y+1; 
			}
			else if (this.y < parentApplication.height/2) {
				this.y = (this.y <= 0)?0:this.y-1; 
			}
			
			if(!this.x)	fadeIn.play();
			else if (this.x == 600)	fadeOut.play();
		}
	}
}