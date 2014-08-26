package co.issen.framework.layout 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author chitose
	 */
	public class LayoutOption extends Sprite 
	{
		protected var target:Sprite;
		
		public function LayoutOption() 
		{
			super();
			
			while (numChildren) {
				removeChildAt(0);
			}
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		protected function added(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			target = parent as Sprite;
		}
		
	}

}