package com
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.effects.Move;
	import mx.effects.Resize;
	import mx.events.EffectEvent;
	import flash.net.*;
	
	public class RandomMoveResize extends Canvas
	{
		protected var imgList:Array;
		protected var pathList:Array;
		protected var classList:Array;
		protected var moveList:Array;
		protected var sizeList:Array;
		
		[Bindable][Embed(source="/resource/sep08/01sep08Small.jpg")]public var photo1:Class;
		[Bindable][Embed(source="/resource/sep08/02sep08Small.jpg")]public var photo2:Class;
		[Bindable][Embed(source="/resource/sep08/03sep08Small.jpg")]public var photo3:Class;
		[Bindable][Embed(source="/resource/sep08/04sep08Small.jpg")]public var photo4:Class;
		[Bindable][Embed(source="/resource/sep08/05sep08Small.jpg")]public var photo5:Class;
		[Bindable][Embed(source="/resource/sep08/08sep08Small.jpg")]public var photo6:Class;
		[Bindable][Embed(source="/resource/sep08/09sep08Small.jpg")]public var photo7:Class;
		[Bindable][Embed(source="/resource/sep08/10sep08Small.jpg")]public var photo8:Class;
		[Bindable][Embed(source="/resource/sep08/11sep08Small.jpg")]public var photo9:Class;
		[Bindable][Embed(source="/resource/sep08/12sep08Small.jpg")]public var photo10:Class;
		[Bindable][Embed(source="/resource/sep08/15sep08Small.jpg")]public var photo11:Class;
		[Bindable][Embed(source="/resource/sep08/16sep08Small.jpg")]public var photo12:Class;
		[Bindable][Embed(source="/resource/sep08/17sep08Small.jpg")]public var photo13:Class;
		
		//-----------------------------------------------------------
		// construct
		//-----------------------------------------------------------
		public function RandomMoveResize()
		{
			this.verticalScrollPolicy = "off";
			this.horizontalScrollPolicy = "off";
			
			classList = new Array (photo1,photo2,photo3,photo4,photo5,photo6,photo7,photo8,photo9,photo10,photo11,photo12,photo13);
			pathList = new Array(	"http://www.nelsonyeung.net/daily/sep08/big/01sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/02sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/03sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/04sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/05sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/08sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/09sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/10sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/11sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/12sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/15sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/16sep08.jpg",
									"http://www.nelsonyeung.net/daily/sep08/big/17sep08.jpg");
			initImageList();
			initImageMove();
			initImageSize();
			moveStart();
			resizeStart();
		}
	
		protected function initImageList():void
		{
			imgList = new Array();
			
			for ( var i:int=0; i<13; i++) {
				var image:Image = new Image();
				var photo:Class = classList[i];
				image.source = new Bitmap(new photo().bitmapData);
				image.id=i.toString();
				image.addEventListener(MouseEvent.CLICK, onMouseClick);
				imgList.push(image);
				this.addChild(image);
			}
		}	

		protected function onMouseClick(e:Event):void
		{
			var img:Image = e.currentTarget as Image;
			var index:int = parseInt(img.id);
			var source:String = pathList[index];
			navigateToURL(new URLRequest(source), 'FullSize');
		}

/////////////////////////////////////////////////////////////////////
// Move Effect
		
		protected function initImageMove():void
		{
			var randX:Number;
			var randY:Number;
			moveList = new Array();
			for ( var i:int=0; i<imgList.length; i++) {
				randX = Math.random();
				randY = Math.random();
				var img:Image = imgList[i];
				img.buttonMode=true;
				img.useHandCursor=true;
				
				var move:Move = new Move();
				move.target = img;
				move.duration = 3000;
				move.addEventListener(EffectEvent.EFFECT_END, onMoveEnd);
				move.xTo = randX * this.width;
				move.yTo = randY * this.height;
				move.xTo = (move.xTo<this.width-img.width)?move.xTo:this.width-img.width;
				move.yTo = (move.yTo<this.height-img.height)?move.yTo:this.height-img.height;
				moveList.push(move);
			}
		}
		
		protected function moveStart():void
		{
			for (var i:int=0; i<moveList.length; i++) {
				var move:Move = moveList[i];
				move.end();
				move.play();
			}
		}
		
		protected function onMoveEnd(e:Event):void
		{
			var move:Move = e.currentTarget as Move;
			move.xTo = Math.random() * this.width *.9;
			move.yTo = Math.random() * this.height * .9;
			move.end();
			move.play();
		}
	
/////////////////////////////////////////////////////////////////////
// Resize Effect
		
		protected function initImageSize():void
		{
			var rand:Number;
			sizeList = new Array();
			for ( var i:int=0; i<imgList.length; i++) {
				rand = Math.random();
				rand = (rand > 0.0)?rand:0.5;
				var img:Image = imgList[i];
				var resize:Resize = new Resize();
				resize.target = img;
				resize.duration = 3000;
				resize.addEventListener(EffectEvent.EFFECT_END, onResizeEnd);
				resize.widthTo = rand * img.width;
				resize.heightTo = rand * img.height;
				sizeList.push(resize);
			}
		}
		
		protected function resizeStart():void
		{
			for (var i:int=0; i<sizeList.length; i++) {
				var resize:Resize = sizeList[i];
				resize.end();
				resize.play();
			}
		}
		
		protected function onResizeEnd(e:Event):void
		{
			var resize:Resize = e.currentTarget as Resize;
			var w:int = ( resize.heightTo > resize.widthTo)? 211:281;
			var h:int = ( resize.heightTo > resize.widthTo)? 281:211;
			var rand:Number = Math.random();
			rand = (rand > 0.0)?rand:0.5;
			resize.widthTo = rand * w;
			resize.heightTo = rand * h;
			resize.end();
			resize.play();
		}	
		
	}

}// ActionScript file
