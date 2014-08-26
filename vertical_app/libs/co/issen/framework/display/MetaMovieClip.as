package co.issen.framework.display 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author chitose
	 */
	public class MetaMovieClip extends MovieClip implements IMetaSprite
	{
		
		public function MetaMovieClip() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onMetaData,false,1000);
		}
		
		/* INTERFACE co.issen.framework.display.IMetaSprite */
		
		public function onMetaData(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onMetaData);
			
			for (var i in metaData) {
				try {
					switch(typeof this[i]) {
						case "number":
							this[i] = Number(metaData[i]);
							break
						case "boolean":
							this[i] = Boolean(metaData[i]=="1" || metaData[i]=="true");
							break
						default:
							this[i] = metaData[i];
							break
					}
				}catch (e:*) { };
			}
		}
		
	}

}