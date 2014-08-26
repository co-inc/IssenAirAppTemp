package co.issen.framework.display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author chitose
	 */
	public class MetaSprite extends Sprite implements IMetaSprite
	{
		
		public function MetaSprite() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onMetaData,false,1000);
		}
		
		/* INTERFACE co.issen.framework.display.IMetaSprite */
		
		public function onMetaData(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onMetaData);
			
			for (var i in metaData) {
				try{
					this[i] = metaData[i];
				}catch (e:*) { };
			}
		}
	}

}