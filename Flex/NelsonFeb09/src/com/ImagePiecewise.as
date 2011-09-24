// ==================================================================
// Module:		ImagePiecewise
//
// Description:	assemble and disassemble image by pieces..
//
// Input:		a BitmapData, start and destination position
// Output:		a BitmapData travel from start to destination position.
// 
// Author(s):	C.T. Yeung			cty
//
// History:
// 17Jan09		first begin										cty
// ==================================================================
package com
{
	import events.EffectEndEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.easing.Bounce;
	import mx.events.EffectEvent;
	
	[Event(name="effectEnd", type="events.EffectEndEvent")]
	public class ImagePiecewise extends UIComponent
	{
		public var stageWidth:int;
		public var stageHeight:int;
		public var url:String;					// URL to this image
		protected var _bitmapData:BitmapData;	// original full bitmap data
		protected var bmpArray:Array;			// array of bmps
		protected var srcPos:Point;				// start position
		protected var desPos:Point;				// destination
		protected var parallel:Parallel;
		protected var _xPieces:int;				// number of columns to divide image into
		protected var _yPieces:int;				// number of rows to divide image into
		protected var _duration:Number;			// moveEffect duration
		
/////////////////////////////////////////////////////////////////////
// initialize
		
		public function ImagePiecewise(width:int, height:int)
		{
			this.stageWidth = width;
			this.stageHeight = height;
			empty();
		}

		public function empty():void
		{
			emptyUIC();
			
			if(bmpArray) {
				var num:int = bmpArray.length;
				for (var i:int=0; i<num; i++) {
					var bmd:BitmapData = bmpArray.pop();
					bmd.dispose();
					bmd = null;
				}
			}
				
			bmpArray = new Array();
			srcPos = new Point();
			desPos = new Point();
			parallel = new Parallel();
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
			empty();
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
		
		public function set xPieces(p:int):void
		{
			_xPieces = p;
			reset();
		}
		
		public function set yPieces(p:int):void
		{
			_yPieces = p;
			reset();
		}
		
/////////////////////////////////////////////////////////////////////
//	methods
		
		public function reset():Boolean
		{
			if (!_bitmapData) return false;
			if (!_xPieces || !_yPieces){
				this.addChild(new Bitmap(_bitmapData));
				return false;
			}
			
			// split the image up
			emptyUIC();
			bmpArray = new Array();
			parallel = new Parallel();
			parallel.addEventListener(EffectEvent.EFFECT_END, onParallelEnd, false, 0, true);

			var w:Number = Number(_bitmapData.width) / Number(_xPieces);
			var h:Number = Number(_bitmapData.height) / Number(_yPieces);
			for ( var y:int=0; y<_yPieces; y++) {
				for ( var x:int=0; x<_xPieces; x ++ ) {
					// create bitmaps
					var bmpData:BitmapData = new BitmapData(w, h);
					bmpData.copyPixels(_bitmapData, new Rectangle(x*w, y*h, w, h), new Point(0,0));
					bmpArray.push(bmpData);
					
					// create move sequence
					var move:Move = new Move();
					var uic:UIComponent = new UIComponent();
					this.addChild(uic);
					uic.addChild(new Bitmap(bmpData));
					move.target = uic;
					move.duration = _duration;
					//move.xFrom = srcPos.x + x * w;
					//move.yFrom = srcPos.y + y * h;
					move.xFrom = Math.random() * this.stageWidth;
					move.yFrom = Math.random() * this.stageHeight;
					move.xTo = desPos.x + x * w;
					move.yTo = desPos.y + y * h;
					
					move.easingFunction = Bounce.easeOut;
					parallel.addChild(move);
				}
			}
			return true;
		}
		
		public function traverse():Boolean
		{
			if (!parallel )
				return false;
				
			parallel.end();
			parallel.play();
			return true;
		}
		
		protected function onParallelEnd(e:Event):void
		{
			empty();	
			dispatchEvent(new EffectEndEvent(EffectEndEvent.EFFECT_END));
		}
	}
}