// ==================================================================
// Module:		CImage
//
// Description:	Extend image class for use with radial travel
//
// Author(s):	C.T. Yeung			cty 
//
// History:		for August09 calendar and RadialTileList	cty
// ==================================================================
package com.ctyeung.Effect
{
    import mx.controls.Image;

    public class CImage extends Image
    {
        public var url:String;
        public var angle:Number;
        public var radius:Number;
        
        public function CImage()
        {
            super();
        }
        
    }
}