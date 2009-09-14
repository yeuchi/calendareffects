package com.ctyeung.events
{
	import flash.events.Event;

	public class RadialTileListEvent extends Event
	{
		public static const RADIAL_TILELIST_CREATE_COMPLETE:String 	= "radialTileListCreateComplete";
		public static const RADIAL_TILELIST_ITEM_CLICK:String 		= "radialTileListItemClick";
		public static const RADIAL_TILELIST_ITEM_ROLLOVER:String 	= "radialTileListItemRollOver";
		public static const RADIAL_TILELIST_ITEM_ROLLOUT:String 	= "radialTileListItemRollOut";
		public static const RADIAL_TILELIST_OPENED:String 			= "radialTileListOpened";
		public static const RADIAL_TILELIST_CLOSED:String 			= "radialTileListClosed";
		
		public var object:Object;
		
		public function RadialTileListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new RadialTileListEvent(type);
		}
		
	}
}