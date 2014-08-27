package co.issen.framework.data 
{
	import co.issen.framework.SoundsManager;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Sine;
	import org.libspark.betweenas3.tweens.IObjectTween;
	/**
	 * ...
	 * @author Chitose
	 */
	public class SoundData 
	{
		private var url:String;
		private var vol:Number;
		private var startTime:Number;
		
		private var channel:SoundChannel;
		private var req:URLRequest;
		private var sound:Sound;
		private var trans:SoundTransform;
		private var tween:IObjectTween
		
		/**
		 * 音声ファイルの設定
		 * @param	url xxx.mp3
		 * @param	vol 音量
		 * @param	startTime　再生位置
		 */
		public function SoundData(url:String,vol:Number=1,startTime:Number=0) 
		{
			this.url = url;
			this.vol = vol;
			this.startTime = startTime;
		}
		
		public function stop(time:Number,isDespose:Boolean=false):SoundData 
		{
			clearTween();
			tween = BetweenAS3.tween(trans, { volume:0 }, null, time, Sine.easeInOut);
			tween.onUpdate = update;
			tween.onComplete = function():void {
				if (isDespose) {
					channel.stop();
					sound = null;
				}
				channel = null;
				trans = null;
				clearTween();
			}
			tween.play();
			
			return this;
		}
		
		private function clearTween():void 
		{
			if (tween != null) {
				tween.stop();
				tween = null;
			}
		}
		
		/**
		 * 
		 * @param	time　イージング時間
		 * @param	loop
		 * @return
		 */
		public function play(time:Number,loop:int=0):SoundData 
		{
			if (req == null) req = new URLRequest(SoundsManager.PATH + url);
			if (sound == null) sound = new Sound(req);
			
			//clearTween();
			trans = new SoundTransform(0);
			if (time == 0) {
				trans.volume = vol;
				channel = sound.play(startTime, loop, trans);
			}else{
				channel = sound.play(startTime, loop);
				tween = BetweenAS3.tween(trans, { volume:vol }, null, time, Sine.easeInOut);
				tween.onUpdate = update;
				tween.play();
			}
			
			channel.addEventListener(Event.SOUND_COMPLETE,comp)
			
			return this;
		}
		private function update():void {
			channel.soundTransform = trans
		}
		
		private function comp(e:Event):void 
		{
			var _channel:SoundChannel = e.currentTarget as SoundChannel;
			_channel.removeEventListener(Event.SOUND_COMPLETE, comp);
			_channel.stop();
			//stop(0, true);
		}
	}

}