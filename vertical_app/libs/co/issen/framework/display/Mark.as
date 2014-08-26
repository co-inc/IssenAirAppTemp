package co.issen.framework.display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * 目印用オブジェクトクラス
	 * 即時removeされる
	 * @author Chitose
	 */
	public class Mark extends Sprite 
	{
		
		public function Mark() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE,added)
		}
		
		private function added(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			parent.removeChild(this);
		}
		
	}

}