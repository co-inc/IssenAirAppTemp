package  
{
	import co.issen.framework.data.SoundData;
	import co.issen.framework.SoundsManager;
	
	/**
	 * ...
	 * @author chitose
	 */
	public class Sounds
	{
		public static const BGM_SAMPLE:SoundData = new SoundData("bgm_maoudamashii_cyber06.mp3", 1);
		
		public static const SE_SAMPLE:SoundData = new SoundData("se_maoudamashii_system46.mp3", 0.5);
		
		//
		static public function changeBGM(bgm:SoundData, loop:Boolean = true):void { return SoundsManager.changeBGM(bgm, loop) };
		static public function playSE(se:SoundData):void { return SoundsManager.playSE(se) };
		
		
		public static function get mute():Boolean { return SoundsManager.mute };
		public static function set mute(value:Boolean):void { SoundsManager.mute = value };
	}
}