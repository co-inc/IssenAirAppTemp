package co.issen.framework.layout 
{
	import co.issen.framework.Document;
	import flash.events.Event;
	/**
	 * ...
	 * @author chitose
	 */
	public class Bottom extends LayoutOption 
	{
		
		public function Bottom() 
		{
			super();
			
		}
		
		override protected function added(e:Event):void 
		{
			super.added(e);
			
			target.y = Document.height;
		}
	}

}