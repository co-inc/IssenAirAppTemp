package  
{
	import co.issen.framework.SaveDataManager;
	/**
	 * ...
	 * 一時保存するものを管理します。
	 * string,int,number,booleanに限定することを勧めます。
	 * @author chitose
	 */
	public class SaveData 
	{
		
		/**
		 * 下記のように予め設定しておくのをおすすめします。
		 */
		static public function get sample():int { return getV("sample", 0) };		
		static public function set sample(value:int):void { setV("sample", value) };
		
		//----------------------------------------
		static private var manager:SaveDataManager;
		static public var data:Object;
		
		/**
		 * appNameで初期化して、セーブデータをチェックします。
		 * @param	appName　ユニークなID
		 */
		static public function init(appName:String):void {
			manager = new SaveDataManager(appName);
			data = manager.data;
		}
		
		
		/**
		 * 即時保存します。
		 */
		static public function save():void { return manager.save() };
		
		/**
		 * セーブデータを消します（要注意）
		 */
		static public function clear():void { return manager.clear() };

		/**
		 * 保存領域に保存
		 * @param	name
		 * @param	value
		 */
		static public function setV(name:String, value:*):void { return manager.setV(name, value) };
		/**
		 * 保存領域から取得
		 * @param	name
		 * @param	defValue　データが入ってない場合の初期値
		 * @return
		 */
		static public function getV(name:String, defValue:*= null):* { return manager.getV(name, defValue) };	
	}
}