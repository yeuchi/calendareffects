package view
{
	import flash.events.Event;
	import flash.geom.Point;
	
	public class HeadCT extends Character
	{
		public var angleSignCT:Boolean = true;
		protected var count:int = 0;
		protected var ptRestCT:Point;
		

		public function HeadCT()
		{
			this.urlStr = "http://www.ctyeung.com/flex/BobbleHead/assets/ctHeadSmall.png";
			ptRestCT = new Point(240, 420);
			super();
		}
		
		override protected function onCreationComplete(e:Event):void {
			super.onCreationComplete(e);
			this.x = ptRestCT.x;
			this.y = ptRestCT.y;
			this.rotation = HEAD_ANGLE-20;
		}
		
		public function bobble():void {
			if(count%3) {
			if( (this.rotationZ < (-45))||
		   		(this.rotationZ > (45)))
				angleSignCT = !angleSignCT;
				
			this.rotationZ += 2*((angleSignCT)?1:-1);
			}
			count ++;
		}
		
	}
}