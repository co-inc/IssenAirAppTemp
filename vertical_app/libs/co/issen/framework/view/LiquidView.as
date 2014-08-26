package co.issen.framework.view 
{
	import co.issen.framework.display.MetaMovieClip;
	import co.issen.framework.Document;
	import flash.display.FrameLabel;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Chitose
	 */
	public class LiquidView extends MetaMovieClip 
	{
		
		public function LiquidView() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			resize();
		}
		
		private function resize():void 
		{
			var min:int = 0;
			var max:int = 0;
			var leng:int;
			
			for (var i:uint = 0; i < currentLabels.length; i++) {
				var label:FrameLabel = currentLabels[i];
				if (label.name == "min") {
					min = label.frame;
				}else if (label.name == "max") {
					max = label.frame;
				}
			}
			
			if (min == 0 || max == 0) {
				trace("LiquidView", "resize", "minまたはmaxが見つからなかったので、totalframeで作動します")
				min = 1;
				max = totalFrames;
			}
			leng = max - min + 1;
			
			var p:Number = (Document.height - Document.longSideLengthMin) / (Document.longSideLengthMax - Document.longSideLengthMin);
			var f:int = Math.ceil(leng * p);
			if (f < min) f = min;
			else if (f >= max) f = max - 1;
			gotoAndStop(f);
		}
	}

}