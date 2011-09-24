// ==================================================================
package com.ctyeung.defaultTileList
{
	import com.ctyeung.Tile.CImage;
	import com.ctyeung.events.RadialTileListEvent;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.core.UIComponent;

	
	[Event(name="radialTileListItemClick", type="com.ctyeung.events.RadialTileListEvent")]
	[Event(name="radialTileListItemRollOver", type="com.ctyeung.events.RadialTileListEvent")]
	[Event(name="radialTileListItemRollOut", type="com.ctyeung.events.RadialTileListEvent")]
		
	public class DisplayQueue extends UIComponent
	{
		protected var queue:Array;
		
		public function DisplayQueue(){
			queue = new Array();
		}
		
		public function empty():void {
			var len:int = queue.length;
			for (var i:int=0; i<len; i++) {
				var obj:Object = queue.pop();
				if(obj is CImage) 
					Bitmap(obj.source).bitmapData.dispose();
				obj = null;
			}
		}
		
		public function isEmpty():Boolean {
			if (queue.length) return false;
			return true;
		}
		
/////////////////////////////////////////////////////////////////////
// Array methods
		
		public function pop():Object {
			return queue.pop();
		}
		
		public function push(obj:Object):Boolean {
			queue.push(obj);
			return true;
		}
		
		public function insert(obj:Object, pos:int):Boolean {
			if(pos<0||pos>queue.length) return false;
			queue.splice(pos, 0, obj);
			return true;
		}
		
		public function extract(pos:int):Object {
			if(pos<0||pos>=queue.length) return null;
			
			var obj:Object = queue[pos];
			queue.splice(pos, 1);
			return obj;
		}
		
		public function get numTiles():int {
			return queue.length;
		}
		
		public function get data():Array {
			return queue;
		}
		
		public function set data(array:Array):void {
			queue = array;
		}
		
/////////////////////////////////////////////////////////////////////
// item

		public function set onItemClick(e:Event):void {
			var event:RadialTileListEvent = new RadialTileListEvent(RadialTileListEvent.RADIAL_TILELIST_ITEM_CLICK);
			event.object = e.currentTarget;
			dispatchEvent(event);
		}
		
		public function set onItemRollOver(e:Event):void {
			var event:RadialTileListEvent = new RadialTileListEvent(RadialTileListEvent.RADIAL_TILELIST_ITEM_ROLLOVER);
			event.object = e.currentTarget;
			dispatchEvent(event);
		}
		
		public function set onItemRollOut(e:Event):void {
			var event:RadialTileListEvent = new RadialTileListEvent(RadialTileListEvent.RADIAL_TILELIST_ITEM_ROLLOUT);
			event.object = e.currentTarget;
			dispatchEvent(event);
		}
	}
}