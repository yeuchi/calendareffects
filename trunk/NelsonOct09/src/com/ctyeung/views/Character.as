package com.ctyeung.views
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;

	public class Character extends UIComponent
	{
		public var loader:Loader;
		public var urlStr:String;
		protected var travel:Move;
		protected var fade:Fade;
		protected var parallel:Parallel;
		protected var appear:Boolean = true;
		
		public function Character()
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete, false, 0, true);
		}
		
		protected function onCreationComplete(e:Event):void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, onInitLoader, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
			loader.load(new URLRequest(urlStr));
			this.addChild(loader);
		}
		
		protected function onInitLoader(e:Event):void {
			travel = new Move(this);
			travel.duration = 3000;
			travel.target = this;
			
			fade = new Fade(this);
			fade.duration = 3000;
			fade.target = this;
			
			parallel = new Parallel();
			parallel.addChild(travel);
			parallel.addChild(fade);
			
			parallel.addEventListener(EffectEvent.EFFECT_END, onEffectEnd, false, 0, true);
			play();
		}
		
		protected function onError(e:Event):void {
			Alert.show(e.toString());
		}
		
		protected function onEffectEnd(e:Event):void {
			play();
		}
		
		protected function play():void {
			if(appear) {
				fade.alphaFrom = 0.0;
				fade.alphaTo = 1.0;
				travel.xFrom = Math.random()*Application.application.stage.width;
				travel.yFrom = Math.random()*Application.application.stage.height;
				travel.xTo = Math.random()*Application.application.stage.width;
				travel.yTo = Math.random()*Application.application.stage.height;
			}
			else {
				fade.alphaFrom = 1.0;
				fade.alphaTo = 0.0;
				travel.xFrom = travel.xTo;
				travel.yFrom = travel.yTo;
				travel.xTo = Math.random()*Application.application.stage.width;
				travel.yTo = Math.random()*Application.application.stage.height;
			}
			appear = !appear;
			parallel.play();
		}
	}
}