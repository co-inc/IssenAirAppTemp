package co.issen.framework.transition 
{
	import co.issen.framework.data.TransitionData;
	import co.issen.framework.Document;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author chitose
	 */
	public class Transition extends EventDispatcher 
	{
		static private var document:Document;
		static private var log:/*TransitionData*/Array;
		static public var active:Boolean = false;
		
		public function Transition(target:flash.events.IEventDispatcher=null) 
		{
			super(target);
			
		}
		
		public static function init(document:Document):void 
		{
			active = true;
			Transition.document = document;
			log = [];
		}
		public static function logClear():void {
			log = [log.pop];
		}
		
		static public function goto(tdata:TransitionData, isLog:Boolean):void 
		{
			ISSEN::DEV { trace(tdata.target, tdata.label) }
			
			try{
				if (isLog) { log.push(tdata); }
				
				if (tdata.isAutoPlay) tdata.target.gotoAndPlay(tdata.label);
				else tdata.target.gotoAndStop(tdata.label);
			}catch (e:*) {
				trace(["Transition", "goto", "err", tdata.target, tdata.label]);
			}
		}
		
		static public function back():void {
			ISSEN::DEV { trace(["back"]) }
			
			log.pop();
			if (log.length == 0) {
				document.closeApp();
			}else {
				var tdata:TransitionData = log[log.length - 1];
				goto(tdata,false)
			}
		}
	}

}