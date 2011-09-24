package view
{
	import flash.events.Event;
	import flash.geom.Point;
	
	public class HeadNelson extends Character
	{
		public var ptRest:Point;
		protected var factor:Number = 1;
		protected var signNeg:Boolean = true;
		protected var angleSign:Boolean = true;
		protected var offset:Number = 5;
		protected var angle:Number = 0;
		
			
		public function HeadNelson()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/nelsonHeadSmall.png";
			ptRest = new Point(455, 480);
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = ptRest.x;
			this.y = ptRest.y;
			this.rotation = HEAD_ANGLE;
		}
		
		public function bobble(ptLetGo:Point):void {
			this.x = (ptLetGo.x - ptRest.x)*factor + ptRest.x;
			this.y = (ptLetGo.y - ptRest.y)*factor + ptRest.y + Math.cos(getRadian(angle))*offset;
			this.rotation += 2*((angleSign)?1:-1);
			
			if( (this.rotation < (HEAD_ANGLE-25))||
		   		(this.rotation > (HEAD_ANGLE + 25)))
				angleSign = !angleSign;
			
			angle = (angle<360)?angle+20:0;
			factor = (signNeg)?factor-.1:factor+.1;

			if((factor<-1)||(factor>1)) {
				ptLetGo.x = Number(ptLetGo.x-ptRest.x)*.9+ptRest.x;
				ptLetGo.y = Number(ptLetGo.y-ptRest.y)*.9+ptRest.y;
				signNeg = (true)?false:true;
			}
		}
		
		public function reset():void {
			signNeg = true;
			factor = 1;
		}
		
		protected function getRadian(degrees:Number):Number {
			return Math.PI / 180.0 * degrees;
		}
	}
}