package co.issen.framework 
{
	import co.issen.framework.transition.Transition;
	import display.Content;
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.media.AudioPlaybackMode;
	import flash.media.SoundMixer;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	ISSEN::ANDROID {
		import flash.events.KeyboardEvent;
		import flash.ui.Keyboard;
		import flash.text.TextField;
		import flash.text.TextFieldType;
	}
	
	/**
	 * ...
	 * @author chitose
	 */
	public class Document extends MovieClip 
	{
		private var _content:MovieClip;
		public function get __content():MovieClip { return _content };
		
		private static var _shortSideLength:int;
		private static var _longSideLengthMin:int;
		private static var _longSideLengthMax:int;
		
		/** 基準短辺　Flashの作成横幅 */
		public static function get shortSideLength():int { return _shortSideLength };
		/** 基準最小長辺　*/
		public static function get longSideLengthMin():int { return _longSideLengthMin };
		/** 基準最長長辺　*/
		public static function get longSideLengthMax():int { return _longSideLengthMax };
		
		private static var _width:int;
		private static var _height:int;
		private static var _scale:Number;
		/** コンテンツの幅　*/
		public static function get width():int { return _width };		
		/** コンテンツの高　*/
		public static function get height():int { return _height };
		/** コンテンツのスケール　*/
		public static function get scale():Number { return _scale };
		
		
		
		public function Document(shortSideLength:int=640, longSideLengthMin:int=960, longSideLengthMax:int=1136,useTransition:Boolean=true) 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_longSideLengthMax = longSideLengthMax;
			_longSideLengthMin = longSideLengthMin;
			_shortSideLength = shortSideLength;
			
			var sw:int = stage.fullScreenWidth;
			var sh:int = stage.fullScreenHeight;
			
			_scale= sw / shortSideLength;
			_width = shortSideLength;
			_height = sh / _scale;
			
			if (useTransition) {
				Transition.init(this);
			}
			
			ISSEN::DEV {
				trace("new Document");
				trace(["\t","scale",_scale]);
				trace(["\t","width",_width]);
				trace(["\t","height",_height]);
				trace(["\t","useTransition",useTransition]);
			}
			
			SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			addEventListener(Event.ADDED_TO_STAGE, initialization);
			
			super();
		}
		
		/**
		 * 立ち上がり後
		 * @param	e
		 */
		protected function initialization(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialization);
			
			stage.addEventListener(Event.ACTIVATE,fromBackground);
			stage.addEventListener(Event.DEACTIVATE, toBackground);
			
			ISSEN::ANDROID {
				if(Transition.active){
					stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
					addEventListener(Event.ADDED, cancelFocus);
				}
			}
		}
		
		/**
		 * バックグラウンドから復帰
		 * @param	e
		 */
		protected function fromBackground(e:Event):void 
		{
			ISSEN::DEV {trace(["Document","fromBackground"])}
		}
		
		/**
		 * バックグラウンドヘ
		 * @param	e
		 */
		protected function toBackground(e:Event):void 
		{
			ISSEN::DEV {trace(["Document","toBackground"])}
		}
		
		/**
		 * アプリ終了
		 */
		public function closeApp():void {
			ISSEN::DEV {trace(["Document","closeApp"])}
			stage.removeEventListener(Event.ACTIVATE,fromBackground);
			stage.removeEventListener(Event.DEACTIVATE, toBackground);
			NativeApplication.nativeApplication.exit();
		}
		
		/**
		 * 画面幅に調整します。
		 * @param	content
		 */
		protected function fitContent(content:Content):void {
			ISSEN::DEV {trace(["Document","fitContent"])}
			_content = content;
			
			_content.scaleX = _content.scaleY = _scale;
		}
		
		/**
		 * backキーとmenuキーをハック
		 * @param	e
		 */
		protected function keyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.BACK){
				stage.focus = null;
				e.preventDefault();
				Transition.back();
			}else if (e.keyCode == Keyboard.MENU){
				//e.preventDefault();
				//menu();
			}
		}
		
		/**
		 * なぜかaddchildが走るたびにフォーカスを失って
		 * keyeventを拾えなくなるので、対処
		 * @param	e
		 */
		protected function cancelFocus(e:Event):void
		{
			if (stage.focus is TextField && TextField(stage.focus).type == TextFieldType.INPUT){
			}else{
				stage.focus = null;
			}
		}
	}

}