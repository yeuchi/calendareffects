package com.ctyeung.services
{
	import com.ctyeung.renderer.CImage;
	
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	[Event(name="loadCompleted", type="flash.events.Event")]
	
	public class PhotoService
	{
		public var imgList:Array;
        private var index:int=0;
        private var loader:Loader;
        private var service:HTTPService;
        
        [Bindable]public var photoFeed:ArrayCollection;
        [Bindable]private var imgURL:String;
        
        private var urlStr:String       ="http://www.ctyeung.com/php/dailyPics.php?path=daily/oct09/thumb/";
        private var imgURLPrefix:String ="http://www.ctyeung.com/peanut/daily/oct09/thumb/";
            
		public function PhotoService() {
			imgList = new Array();
			service = new HTTPService();
			service.addEventListener(ResultEvent.RESULT, photoHandler, false, 0, true);
			requestPhotos();
		}

		protected function requestPhotos():void {
                if (photoFeed) {
                    photoFeed.removeAll();
                    photoFeed = null;
                }
                
                service.url = urlStr;    
                service.cancel();
                var params:Object = new Object();
                params.format = 'rss_200_enc';
                service.send(params);
            }
            
            protected function photoHandler(event:ResultEvent):void {
                 photoFeed = event.result.html.body.p.data as ArrayCollection;
                 filter(photoFeed);
                 onLoadImage();
            }
            
            protected function filter(photoFeed:ArrayCollection):void
            {
                for ( var i:int=0; i<photoFeed.length; i++ ) {
                    var name:String = photoFeed[i].credit;
                    if ( name.length < 4 )
                        photoFeed.removeItemAt(i);
                }
            }
            
            protected function onLoadImage():void
            {
                if (!photoFeed)
                    return;
                    
                if ( index >= photoFeed.length )
                    return;
                    
                var fileName:String = photoFeed[index].credit;
                imgURL = imgURLPrefix+fileName;
                loader = new Loader();
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded, false, 0, true);
                loader.load(new URLRequest(imgURL));
            }
            
            protected function onImageLoaded(e:Event):void
            {
                var img:CImage = new CImage();
                img.source = loader.content;
                img.url = imgURL;
                imgList.push(img);
                index ++;
                dispatchEvent(new Event("loadCompleted"));
                onLoadImage();
            }
	}
}