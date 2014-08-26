package co.issen.framework.layout 
{
	import co.issen.framework.Document;
	import flash.events.Event;
	/**
	 * ...
	 * @author chitose
	 */
	public class Top extends LayoutOption 
	{
		
		public function Top() 
		{
			super();
			
		}
		
		override protected function added(e:Event):void 
		{
			super.added(e);
			
			//target.y = (Document.height - target.height) / 2;
			target.y = 0;
		}
	}

}