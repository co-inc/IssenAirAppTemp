package co.issen.framework 
{
	import co.issen.framework.data.SoundData;
	/**
	 * ...
	 * @author chitose
	 */
	public class SoundsManager 
	{
		private static var currentBgm:SoundData;
		public static const PATH:String = "assets/sounds/";
		
		private static var _mute:Boolean = false;
		public static function get mute():Boolean { return _mute };
		public static function set mute(value:Boolean):void {
			_mute = value
			if(currentBgm){
				if (_mute) {
					currentBgm.stop(0.5);
				}else {
					currentBgm.play(0.5);
				}
			}
		};
		
		static public function changeBGM(bgm:SoundData,loop:Boolean=true):void 
		{
			if (currentBgm == bgm) return;
			if (currentBgm != null) currentBgm.stop(0.5, true);
			try {
				if (loop) {
					currentBgm = bgm.play(0.5, int.MAX_VALUE);
				}else {
					currentBgm = bgm.play(0.5, 0);
				}
			}catch (e:*) {
				currentBgm = null;
			}
		}
		
		static public function playSE(se:SoundData):void {
			se.play(0);
		}
	}

}