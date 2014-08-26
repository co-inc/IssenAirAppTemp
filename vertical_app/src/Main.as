package 
{
	import co.issen.framework.Document;
	import display.Content;
	import flash.events.Event;
	import flash.display.Sprite;
	
	/*
	ISSEN::SWF {
	}
	ISSEN::IOS {
	}
	ISSEN::ANDROID {
	}
	ISSEN::RELEASE {
	}
	ISSEN::DEV {
	}*/
	
	/**
	 * ...
	 * @author chitose
	 */
	public class Main extends Document 
	{
		public var content:Content;
		
		public function Main():void 
		{
			super(640, 960, 1136,true);
			
		}
		
		override protected function initialization(e:Event):void 
		{
			super.initialization(e);
			fitContent(content);
			
			//ここから
		}
		
	}
	
}