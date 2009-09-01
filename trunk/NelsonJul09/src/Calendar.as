// ==================================================================
// Module:		Calendar.as
//
// Description:	Just horsing around with Papervision example from
//				Ralph's class, flashbelt.  This is from his primitive
//				demo code.
//
// ==================================================================
package
{
	import com.ctyeung.CImage;
	import com.ctyeung.services.PhotoService;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Image;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.render.LazyRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	
	public class Calendar extends UIComponent
	{
		protected var photoService:PhotoService;
		protected var index:int = 0;
		protected var imgList:Array;
		protected var posList:Array;
		protected var planeList:Array;
		[Bindable]protected var _wid:int;
		[Bindable]protected var _len:int;
		[Bindable]protected var _thumbWid:int = 100;
		protected var bFirstTime:Boolean = true;
		protected var scene:Scene3D;
		protected var camera:Camera3D;
		protected var viewport:Viewport3D;
		protected var renderer:LazyRenderEngine;
		protected var plane:Plane;
			
		public function Calendar()
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete, false, 0, true);
		}
		
		private function onCreationComplete(e:Event):void {
			var pt:Point = new Point(10, 140);
			posList = new Array();
			posList.push(pt);
			planeList = new Array();
			
			photoService = new PhotoService();
			photoService.addEventListener("loadCompleted", onLoadCompleted, false, 0, true);
		
			initPV3D();
			startRendering();
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
			this.camera.moveUp(200);
			this.camera.moveRight(600);
			this.camera.moveForward(600);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			
		}
		
		private function initPV3D():void
		{
			//Setup a scene.
			scene = new Scene3D();
			//Setup a camera3d, zoom 3, focus 200.
			camera = new Camera3D();
			//Setup viewport, not interactive, scale to stage, no clipping, add the viewport to stage.
			viewport = new Viewport3D(0,0,true,true,true,false);
			viewport.interactiveSceneManager.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK, onObjectClick, false, 0, true);
			addChild(viewport);
			//set the background to black.
			//Add a lazyrenderer
			renderer = new LazyRenderEngine(scene, camera, viewport);
		}
		
		private function onObjectClick(e:InteractiveScene3DEvent):void
		{
			camera.lookAt(e.displayObject3D);									// a single "center framing" not follow...
			var id:int = e.displayObject3D.id;
			onClickImage(id);
		}
		
		private function onLoadCompleted(e:Event):void
		{
			imgList = photoService.imgList;	
			var img:Image = imgList[index];
			var pt:Point = posList[index];
			
			var newPt:Point = new Point();
			
			newPt.x = pt.x + _thumbWid + 10;
			newPt.y = pt.y;
			
			if ( ( newPt.x + _thumbWid ) >= Application.application.stage.width ) {
				newPt.x = 10;
				newPt.y = pt.y + _thumbWid + 10;
			}
			posList.push(newPt);
			
			
			var bmp:Bitmap = img.source as Bitmap;
			var material:BitmapMaterial = new BitmapMaterial(bmp.bitmapData);
			material.doubleSided = true;
			material.interactive = true;
			plane = new Plane(material,_thumbWid, _thumbWid);
			plane.id = index;
			planeList.push(plane);
			scene.addChild(plane);
			plane.x = newPt.x;
			plane.y = newPt.y;
			index ++;
		}
		
		
		
/////////////////////////////////////////////////////////////////////
// events
		
		private function onClickImage(id:int):void
        {
        	var img:CImage = this.imgList[id] as CImage;
        	var url:String = img.url;
        	url = url.toLowerCase();
        	url = url.replace("thumb/", "big/");
        	url = url.replace("thumb", "");
        	url = url.replace("jpg", "JPG");
        	navigateToURL(new URLRequest(url), "_blank");
        }
        
        private function onMouseOut(e:MouseEvent):void
		{
			var img:Image = e.currentTarget as Image;
			img.alpha = 1;
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			var img:Image = e.currentTarget as Image;
			img.alpha = .6;
		}
		
		private function startRendering():void
		{
			//Create our own enterframe listener.
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		
		public function moveCamera(pt:Point):void {
			if(pt.x < 0) this.camera.yaw(-1);
			else if(pt.x>0) this.camera.yaw(1);
			
			//if(pt.y < 0) this.camera.pitch(-1)
			//else if(pt.y>0) this.camera.pitch(1);
		}
		
		private function onRenderTick(event:Event):void
		{
			if(plane) plane.yaw(1);
			
			for (var i:int=0; i<planeList.length; i++) {
				var plane:Plane = planeList[i];
				if(i%2)	plane.yaw(1);
				else	plane.pitch(1);
			}
			renderer.render();
		}
	}
}