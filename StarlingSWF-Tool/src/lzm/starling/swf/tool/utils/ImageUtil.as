package lzm.starling.swf.tool.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import lzm.starling.swf.tool.Starup;
	
	/**
	 * 
	 * @author zmliu
	 * 
	 */
	public class ImageUtil
	{
		
		/**
		 * 获取图片bitmapdata
		 * */
		public static function getBitmapdata(clazz:Class,scale:Number):BitmapData{
			var object:Object = new clazz();
			var image:DisplayObject;
			if(object is BitmapData){
				image = new Bitmap(object as BitmapData);
			}else{
				image = object as DisplayObject;
			}
			image.scaleX = image.scaleY = scale * Util.swfScale;
			
			Starup.tempContent.addChild(image);
			
			var rect:Rectangle = image.getBounds(Starup.tempContent);
			rect.width = rect.width < 1 ? 1 : rect.width;
			rect.height = rect.height < 1 ? 1 : rect.height;
			image.x = -rect.x;
			image.y = -rect.y;
			
			var addWidth:Number = Math.abs((image.x%1) + (rect.width%1));
			var addHeight:Number = Math.abs((image.y%1) + (rect.height%1));
			
			addWidth = (addWidth%1) > 0 ? int(addWidth+1) : addWidth;
			addHeight = (addHeight%1) > 0 ? int(addHeight+1) : addHeight;
			
			rect.width += addWidth;
			rect.height += addHeight;
			
			var bitmapdata:BitmapData = new BitmapData(rect.width,rect.height,true,0);
			bitmapdata.draw(Starup.tempContent);
			
			Starup.tempContent.removeChild(image);
			
			return bitmapdata;
		}
		
		/**
		 * 获取图片信息
		 * */
		public static function getImageInfo(clazz:Class):Array{
			var object:Object = new clazz();
			var image:DisplayObject;
			if(object is BitmapData){
				image = new Bitmap(object as BitmapData);
			}else{
				image = object as DisplayObject;
			}
			
			Starup.tempContent.addChild(image);
			
			var rect:Rectangle = image.getBounds(Starup.tempContent);
			
			Starup.tempContent.removeChild(image);
			
			return [Util.formatNumber(-rect.x * Util.swfScale),Util.formatNumber(-rect.y  * Util.swfScale)];
		}
		
	}
}