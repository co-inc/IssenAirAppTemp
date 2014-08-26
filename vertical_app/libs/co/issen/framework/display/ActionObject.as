package co.issen.framework.display 
{
	import co.issen.framework.data.TransitionData;
	import co.issen.framework.transition.Transition;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author chitose
	 */
	public class ActionObject extends MetaMovieClip 
	{
		public var type:String = "gotoPlay";
		public var label:String = "";
		public var target:String = "parent";
		public var arg:String = "";
		public var isLog:String = "true";
		
		protected var immediately:Boolean = true;
		
		public function ActionObject() 
		{
			super();
		}
		override public function onMetaData(e:Event):void 
		{
			super.onMetaData(e);
			
			if (immediately) run();
		}
		
		public function run():void {
			switch(type) {
				case "gotoPlay":
				case "gotoAndPlay":
					goto(true);
					break
				case "gotoStop":
				case "gotoAndStop":
					goto(false);
					break
				case "func":
				case "function":
					func();
					break;
				case "back":
					Transition.back();
					break;
				default:
					trace([this, "run", "想定外のtypeです", type]);
					break
			}
		}
		
		private function goto(isPlay:Boolean):void {
			var _target:Object = getTarget();
			var tdata:TransitionData = new TransitionData(label, _target as MovieClip, arg, isPlay);
			Transition.goto(tdata, isLog == "true");
		}
		
		private function func():void {
			var _target:Object = getTarget();
			try {
				if (arg && arg.length > 0)_target[label](arg);
				else _target[label]()
			}catch (e:*) {
				trace(e);
			}
		}
	
		private function getTarget():Object 
		{
			var _tar:Object = parent;
			var arr:Array = target.split(".");
			var str:String;
			while (arr.length) {
				str = arr.shift();
				switch(str) {
					case "this":
						break;
					case "parent":
						_tar = Sprite(_tar).parent;
						break
					default:
						_tar = _tar[str];
						if (_tar == null) {
							var cl:Class = getDefinitionByName(str) as Class;
							if (cl)_tar = cl;
						}
				}
			}
			return Object(_tar);
		}
	}

}