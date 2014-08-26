package co.issen.framework.layout 
{
	import co.issen.framework.Document;
	import flash.events.Event;
	/**
	 * ...
	 * @author chitose
	 */
	public class Middle extends LayoutOption 
	{
		
		public function Middle() 
		{
			super();
		}
		
		override protected function added(e:Event):void 
		{
			super.added(e);
			
			//target.y = (Document.height - target.height) / 2;
			target.y = Document.height / 2;
		}
	}

}