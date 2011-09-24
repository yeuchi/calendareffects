// ==================================================================
// Module:		ImageColor
//
// Description:	assemble and disassemble image by color channel
//
// Input:		a BitmapData, start and destination position
// Output:		a BitmapData travel from start to destination position.
// 
// Author(s):	C.T. Yeung			cty
//
// History:
// 25Mar09		first complete									cty
// ==================================================================
package com
{
	import events.EffectEndEvent;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.BitmapDataChannel;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	import mx.effects.Move;
	import mx.effects.Sequence;
	import mx.effects.easing.Bounce;
	import mx.events.EffectEvent;
	
	[Event(name="effectEnd", type="events.EffectEndEvent")]
	public class ImageColor extends UIComponent
	{
		public var stageWidth:int;
		public var stageHeight:int;
		public var url:String;					// URL to this image
		protected var _bitmapData:BitmapData;	// original full bitmap data
		protected var bmpArray:Array;			// array of bmps
		protected var srcPos:Point;				// start position
		protected var desPos:Point;				// destination
		protected var sequence:Sequence;
		protected var _xPieces:int;				// number of columns to divide image into
		protected var _yPieces:int;				// number of rows to divide image into
		protected var _duration:Number;			// moveEffect duration
		
/////////////////////////////////////////////////////////////////////
// initialize
		
		public function ImageColor(width:int, height:int)
		{
			this.stageWidth = width;
			this.stageHeight = height;
			empty();
		}

		public function empty():void
		{
			emptyUIC();
				
			bmpArray = new Array();
			_bitmapData = null;
			srcPos = new Point();
			desPos = new Point();
			sequence = new Sequence();
		}
		
		public function emptyUIC():void
		{
			var nofc:int = this.numChildren;
			for (var i:int=nofc-1; i>=0; i--)
				this.removeChildAt(i);
		}
		
		public function isEmpty():Boolean
		{
			if ( bmpArray.length )
				return false;
			return true;
		}

/////////////////////////////////////////////////////////////////////
// properties
		
		public function set bitmapData(b:BitmapData):void
		{
			_bitmapData = b;
			reset();
		}
		
		public function set xFrom(x:int):void
		{
			srcPos.x = x;
			reset();
		}
		
		public function set yFrom(y:int):void
		{
			srcPos.y = y;
			reset();
		}
		
		public function set xTo(x:int):void
		{
			desPos.x = x;
			reset();
		}
		
		public function set yTo(y:int):void
		{
			desPos.y = y;
			reset();
		}
		
		public function set duration(time:int):void
		{
			_duration = time;
			reset();
		}
		
/////////////////////////////////////////////////////////////////////
//	methods
		
		public function reset():Boolean
		{
			if (!_bitmapData) return false;
			
			// split the image up
			emptyUIC();
			bmpArray = new Array();
			sequence = new Sequence();
			sequence.addEventListener(EffectEvent.EFFECT_END, onEffectEnd, false, 0, true);
			
			for ( var x:int=0; x<3; x ++ ) {
				var channel:uint = (x==0)?BitmapDataChannel.RED:(x==1)?BitmapDataChannel.GREEN:BitmapDataChannel.BLUE;
				// create bitmaps
				var bmpData:BitmapData = new BitmapData(_bitmapData.width, _bitmapData.height, true);
				bmpData.copyChannel(_bitmapData, 
									new Rectangle(0, 0, _bitmapData.width, _bitmapData.height),
									new Point(0,0),
									channel,
									channel);
									
				bmpArray.push(bmpData);
				
				// create move sequence
				var move:Move = new Move();
				var uic:UIComponent = new UIComponent();
				var bmp:Bitmap = new Bitmap(bmpData);
				uic.addChild(new Bitmap(bmpData));
				this.addChild(uic);
				move.target = uic;
				move.duration = _duration;
				move.xFrom = uic.x = Math.random() * this.stageWidth;
				move.yFrom = uic.y = Math.random() * this.stageHeight;
				move.xTo = desPos.x ;
				move.yTo = desPos.y ;
				move.addEventListener(EffectEvent.EFFECT_END, onEndMove, false, 0, true);
				//move.easingFunction = Bounce.easeOut;
				sequence.addChild(move);
			}
			return true;
		}
		
		protected var iCount:int = 0;
		protected function onEndMove(e:Event):void
		{
			if(iCount==1)
			{
				var bmpData:BitmapData = _bitmapData.clone();
				var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 255, 0)
				bmpData.colorTransform(new Rectangle(0,0,bmpData.width, bmpData.height),colorTransform);
				var uic:UIComponent = new UIComponent();
				uic.x = desPos.x;
				uic.y = desPos.y;
				uic.addChild(new Bitmap(bmpData));
				this.addChild(uic);
			}
			iCount ++;
		}
		
		public function traverse():Boolean
		{
			if (!sequence )return false;
				
			sequence.end();
			sequence.play();
			return true;
		}
		
		protected function onEffectEnd(e:Event):void
		{
			iCount = 0;
			emptyUIC();
			this.visible = true;
			this.x = desPos.x;
			this.y = desPos.y;
			this.addChild(new Bitmap(_bitmapData));
			dispatchEvent(new EffectEndEvent(EffectEndEvent.EFFECT_END));
		}
	}
}