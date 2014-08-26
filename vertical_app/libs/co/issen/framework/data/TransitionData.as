package co.issen.framework.data 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author chitose
	 */
	public class TransitionData 
	{
		public var label:String;
		public var variable:Object;
		public var isAutoPlay:Boolean;
		public var target:MovieClip;
		
		public function TransitionData(label:String,target:MovieClip,variable:Object=null, isAutoPlay:Boolean=false) 
		{
			this.label = label;
			this.variable = variable;
			this.isAutoPlay = isAutoPlay;
			this.target = target;
		}
	}

}