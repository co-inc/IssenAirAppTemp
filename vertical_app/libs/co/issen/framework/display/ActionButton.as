package co.issen.framework.display 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author chitose
	 */
	public class ActionButton extends ActionObject 
	{
		
		public function ActionButton() 
		{
			super();
			immediately = false;
			
			addEventListener(MouseEvent.CLICK, click);
		}
		
		private function click(e:MouseEvent):void 
		{
			run();
		}
		
	}

}