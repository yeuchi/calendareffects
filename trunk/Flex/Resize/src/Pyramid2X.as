package
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.ShaderJob;
	import flash.filters.ShaderFilter;
	import flash.utils.ByteArray;

	public class Pyramid2X
	{
		[Embed(source="asset/Pyramid2X.pbj", mimeType="application/octet-stream")]
		static private var pbFilter:Class;
		
		public function Pyramid2X() {
		}
		
		static public function apply(bmd:BitmapData):BitmapData {
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