package co.issen.framework 
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author chitose
	 */
	public class SaveDataManager 
	{
		protected var appName:String;
		protected var so:SharedObject;
		
		/** セーブデータ */
		public var data:Object;
		
		public function SaveDataManager(appName) {
			this.appName = appName;
			
			if (so == null) so = SharedObject.getLocal(appName);
			try {
				data = JSON.parse(so.data.json);
			}catch(e:Error) {
				data = { }
			}
		}
		
		/**
		 * 即時保存します。
		 */
		public function save():void 
		{
			so.data.json = JSON.stringify(data);
			so.flush();
		}
		
		/**
		 * セーブデータを消します（要注意）
		 */
		public function clear():void {
			data = { };
			save();
		}

		/**
		 * 保存領域に保存
		 * @param	name
		 * @param	value
		 */
		public function setV(name:String, value:*):void 
		{
			data[name] = value;
			save();
		}
		
		/**
		 * 保存領域から取得
		 * @param	name
		 * @param	defValue　データが入ってない場合の初期値
		 * @return
		 */
		public function getV(name:String, defValue:*=null):* 
		{
			var v:*= data[name];
			if (v == null || v == undefined) {
				return defValue;
			}else {
				return v;
			}
		}
	}

}