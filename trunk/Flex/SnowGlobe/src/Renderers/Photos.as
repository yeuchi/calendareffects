package Renderers
{
	import Events.PhotoServiceEvent;
	
	import Services.PhotoService;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.core.UIComponent;

	public class Photos extends UIComponent
	{
		protected var service:PhotoService;
		protected var index:int = 0;
		protected var ptPanel:Point;
		protected var wid:int = 100;
		
		protected var _magnitude:Number;			// keep track of how much travel a user shakes the globe.
		protected var _travelAngle:Number;			// mean angle of travel a user shakes the globe.

		public function Photos()
		{
			super();
			ptPanel = new Point(0,200);
			init();
		}
		
		protected function init():void {
			service = new PhotoService();
			service.addEventListener(PhotoServiceEvent.LOAD_COMPLETE, onReadyPhoto, false, 0, true);
		}

/////////////////////////////////////////////////////////////////////
// effect
		
		public function set magnitude(travel:Number):void {
			
		}
		
		public function set travelAngle(degree:Number):void {
			
		}
		
/////////////////////////////////////////////////////////////////////
// photos

		protected function onReadyPhoto(e:Event):void {
			var imgList:Array = service.imgList;	
			var img:CImage = imgList[index] as CImage;
			img.id = index.toString();
			this.addChild(img);
			
			img.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			img.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			img.addEventListener(MouseEvent.CLICK, onClickImage);
			img.buttonMode = true;
			img.useHandCursor = true;
			
			img.x = ptPanel.x;
			img.y = ptPanel.y;
			
			ptPanel.x += wid + 5;
			
			if ( ( ptPanel.x + wid ) >=  this.width ) {
				ptPanel.x = 5;
				ptPanel.y += wid + 5;
			}
			index ++;
		}	
		
		private function onMouseOut(e:MouseEvent):void
		{
			var img:CImage = e.currentTarget as CImage;
			img.alpha = 1;
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			var img:CImage = e.currentTarget as CImage;
			img.alpha = .5;
		}	
	
		private function onClickImage(e:MouseEvent):void
        {
            var img:CImage = e.currentTarget as CImage;
            var url:String = img.url;
            //url = url.toLowerCase();
            url = url.replace("thumb/", "big/");
            url = url.replace("Thumb", "");
            url = url.replace("jpg", "JPG");
            navigateToURL(new URLRequest(url), "_blank");
        }
	}
}