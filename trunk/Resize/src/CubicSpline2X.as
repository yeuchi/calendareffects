package
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.ShaderJob;
	import flash.filters.ShaderFilter;
	import flash.utils.ByteArray;

	public class CubicSpline2X extends BiLinear2X
	{
		[Embed(source="asset/CubicSpline2X.pbj", mimeType="application/octet-stream")]
		static protected var pbFilter:Class;
		
		public function CubicSpline2X() {
		}
		
		static public function apply(bmd:BitmapData):BitmapData{
			var bmdDes:BitmapData = new BitmapData(bmd.width, bmd.height);
			var shader:Shader = new Shader();
			shader.byteCode = new pbFilter() as ByteArray;
			shader.data.src = bmd;
			
			var job:ShaderJob = new ShaderJob(shader); 
			job.target = bmdDes; 
			job.start();
				
			return bmdDes;
		}
		
		static public function get shaderFilter():ShaderFilter {
			var shader:Shader = new Shader();
			shader.byteCode = new pbFilter();
			var filter:ShaderFilter;
			filter = new ShaderFilter(shader);
			return filter;
		}
	}
}