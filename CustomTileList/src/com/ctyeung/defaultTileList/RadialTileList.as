package com.ctyeung.defaultTileList
{
	import com.ctyeung.Tile.CImage;
	import com.ctyeung.events.RadialTileListEvent;
	import com.ctyeung.transition.RadialMove;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;

	[Event(name="radialTileListOpened", type="com.ctyeung.events.RadialTileListEvent")]
	[Event(name="radialTileListClosed", type="com.ctyeung.events.RadialTileListEvent")]
	
	public class RadialTileList extends DisplayQueue
	{
		protected var _rise:Number;
		protected var radialMove:RadialMove;
		protected var currentIndex:int = 0;

		public static const TILE_ANGLE_OUTTER:String	= "tileAngleOutter";
		public static const TILE_ANGLE_INNER:String		= "tileAngleInner";
		public static const TILE_ANGLE_NORMAL:String	= "tileAngleNormal";
		public static const TILE_ANGLE_CUSTOM:String	= "tileAngleCustom";
		
		protected var tileStyle:String;;
		public var leftBoundAngle:Number;			// [in] left angle open
		public var rightBoundAngle:Number;			// [in] right angle open
		public var selectedIndex:int;				// [out] current data item index in focus

		public static const ANCHOR_LEFT:String 	 		= "anchorLeft";
		public static const ANCHOR_RIGHT:String  		= "anchorRight";
		public static const ANCHOR_CENTER:String 		= "anchorCenter";
		public static const ANCHOR_CUSTOM:String 		= "anchorCustom";
		
		protected var anchorStyle:String;			// [in] above
		protected var anchorPos:int;				// [in] set center point
		protected var loop:Boolean;					// [in] open/close forever
		protected var center:Point;					// [in] TileList center
		protected var radius:Number;				// [in] distance of tile from center
		
/////////////////////////////////////////////////////////////////////
// construct / destruct
		
		public function RadialTileList(anchorPt:Point=null,
									   anchorPos:int=0,
									   anchorStyle:String=ANCHOR_LEFT,
									   tileStyle:String=TILE_ANGLE_NORMAL,
									   radius:Number=50,
									   leftBoundAngle:Number=0,
									   rightBoundAngle:Number=90,
									   loop:Boolean=false, 
									   duration:Number=1000) {
									   	
			this.anchorStyle 	 = anchorStyle;
			this.anchorPos   	 = anchorPos;
			this.center	 	 	 = anchorPt;
			this.tileStyle		 = tileStyle;
			this.radius		 	 = radius;
			this.leftBoundAngle  = leftBoundAngle;
			this.rightBoundAngle = rightBoundAngle;
			this.loop			 = loop;
			this.center   = new Point();
			
			if(anchorPt){
				this.center.x = anchorPt.x; 
				this.center.y = anchorPt.y;
			}
			else {
				this.center.x = this.width/2;
				this.center.y = this.height/2;
			}
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete, false, 0, true);
			radialMove = new RadialMove();
			radialMove.duration = duration;
		}
		
		protected function onCreationComplete(e:Event):void {
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}
		
		protected function onEnterFrame(e:Event):void {
		}
		
		protected function emptyDisplay():void {
			var num:int = this.numChildren;
			for(var i:int = num-1; i>=0; i--) {
				this.removeChildAt(i);
			}
		}

/////////////////////////////////////////////////////////////////////
// properties

		public function duration(milliSec:Number):void {			// [in] time for every degree of transition
			radialMove.duration = milliSec;
		}

		public function setTileStyle (	style:String, 				// [in] tile style
										angleOpen:Number=-45,		// [in] open angle in degrees
										angleClose:Number=45,		// [in] close angle in degrees
										loop:Boolean=false)			// [in] open & close forever
										:void {
			tileStyle 	    = style;
			leftBoundAngle 	= angleOpen;
			rightBoundAngle = angleClose;
			this.loop		= loop;
		}
		
		public function setAnchorIndex (style:String, 				// [in] anchor style
										index:int=0)				// [in] entry index
										:void {
			anchorStyle = style;
			anchorPos = index;
		}
		
		public function setAnchorPoint( pt:Point ):void {			// [in] tile list center point
			center.x = pt.x;
			center.y = pt.y;
		}

/////////////////////////////////////////////////////////////////////
// Invalidate
		
		public function updateDisplay():void {
			if(queue.length != this.numChildren) emptyDisplay();
			for(var i:int = 0; i<queue.length; i++) {
				var img:CImage = queue[i];
				if(!this.contains(img)) {
					var bmd:BitmapData = img.source.bitmapData;
					img.width = bmd.width;
					img.height = bmd.height;
					img.visible = false;
					this.addChild(queue[i]);
				}
			}
		}
		
		public function invalidate():void {
			// place image at start position !
			
			if(queue.length != this.numChildren) emptyDisplay();
			for(var i:int = 0; i<queue.length; i++) {
				var img:CImage = queue[i];
				var bmd:BitmapData = img.source.bitmapData;
				img.width = bmd.width;
				img.height = bmd.height;
				img.visible = false;
				this.addChild(queue[i]);
			}
		}
		
/////////////////////////////////////////////////////////////////////
// Action open

		public function open():void {
			if(isEmpty()) return;
			currentIndex = 0;
			radialMove.addEventListener(EffectEvent.EFFECT_END, onOpenLeftEnd, false, 0, true);
			openLeft(false);
			//openRight();
		}
		
		protected function openLeft(playReversed:Boolean=false):void {
			radialMove.center 	 = center;
			radialMove.angleFrom = 0;
			radialMove.angleTo   = currentIndex*30%360;
			radialMove.radius	 = radius;
			radialMove.play([queue[currentIndex]], playReversed);
		}
		
		protected function onOpenLeftEnd(e:Event):void {
			currentIndex++;
			if(currentIndex>=queue.length){
				if(radialMove.hasEventListener(EffectEvent.EFFECT_END))
					radialMove.removeEventListener(EffectEvent.EFFECT_END, onOpenLeftEnd);
				return;
			} 
			else
				openLeft(false);
		}
		
		protected function openRight():void {
			for(var i:int=0; i<rightBoundAngle; i++) {
				
			}
		}

/////////////////////////////////////////////////////////////////////
// Action close
		
		public function close():void {
			if (isEmpty())	return;
			currentIndex = queue.length-1;
			radialMove.addEventListener(EffectEvent.EFFECT_END, onCloseLeftEnd, false, 0, true);
			openLeft(true);
		}
		
		protected function onCloseLeftEnd(e:Event):void {
			var img:CImage = queue[currentIndex];
			if(img)	img.visible = false;
			
			currentIndex--;
			if(currentIndex<0){
				if(radialMove.hasEventListener(EffectEvent.EFFECT_END))
					radialMove.removeEventListener(EffectEvent.EFFECT_END, onCloseLeftEnd);
				return;
			} 
			else
				openLeft(true);
		}
		
		protected function closeLeft():void {
			for(var i:int=0; i<leftBoundAngle; i++) {
				
			}
		}
		
		protected function closeRight():void {
			for(var i:int=0; i<rightBoundAngle; i++) {
				
			}
		}
		
		public function rise(pixels:Number):void {
			radius = pixels;
		}
	}
}