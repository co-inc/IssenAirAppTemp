package co.issen.framework.view 
{
	import co.issen.framework.display.MetaMovieClip;
	import co.issen.framework.Document;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Chitose
	 */
	public class ScrollView extends MetaMovieClip 
	{
		public var isHorizontal:Boolean=false;
		public var isVerticale:Boolean=true;
		public var marginLeft:int=0;
		public var marginRight:int=0;
		public var marginTop:int=0;
		public var marginBottom:int = 0;
		public var bgInstans:String = "";
		
		protected var scrollHMax:Number;
		protected var scrollVMax:Number;
		protected var currentPoint:Point = new Point();
		
		public function ScrollView() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			resize();
		}
		
		public function resize():void 
		{	
			var bg:Sprite = this[bgInstans] as Sprite;
			if (bg) bg.visible = false;
			var _w:Number = Document.width - marginRight - marginLeft;
			var _h:Number = Document.height - marginTop - marginBottom;
			if (isHorizontal && _w<width) {
				scrollHMax = _w - width;
			}else {
				scrollHMax = 0;
			}
			if (isVerticale && _h < height) {
				scrollVMax = _h - height;
			}else {
				scrollVMax = 0;
			}
			
			if (bg) {
				bg.width = width;
				bg.height = height;
				bg.visible=true
			}
			update();
			if (scrollHMax + scrollVMax == 0) {
				removeHandler();
			}else {
				addHandler();
			}
		}
		
		private function addHandler():void {
			addEventListener(MouseEvent.MOUSE_DOWN, down);
		}
		private function removeHandler():void {
			try {
				removeEventListener(MouseEvent.MOUSE_DOWN, down);
				stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
			}catch (e:*) {
				
			}
		}
		private function down(e:MouseEvent):void {
			addEventListener(MouseEvent.MOUSE_MOVE, move);
			addEventListener(Event.ENTER_FRAME, enter);
			stage.addEventListener(MouseEvent.MOUSE_UP, up);
			
			var befP:Point = new Point(e.stageX, e.stageY);
			var moveEvent:MouseEvent = e;
			
			function move(_e:MouseEvent):void {
				moveEvent = _e;
			}
			function enter(_e:Event):void {
				var p:Point = new Point(moveEvent.stageX - befP.x, moveEvent.stageY - befP.y);
				var lp:Point = parent.globalToLocal(p);
				currentPoint.x += lp.x;
				currentPoint.y += lp.y;
				befP.x = moveEvent.stageX;
				befP.y = moveEvent.stageY;
				update();
			}
			function up(_e:MouseEvent):void {
				removeEventListener(MouseEvent.MOUSE_MOVE, move);
				removeEventListener(Event.ENTER_FRAME, enter);
				stage.removeEventListener(MouseEvent.MOUSE_UP, up);
			}
		}
		
		public function update():void 
		{
			if (scrollHMax+marginRight > currentPoint.x) {
				currentPoint.x = scrollHMax + marginRight;
			}else if(currentPoint.x>marginLeft) {
				currentPoint.x = marginLeft;
			}
			
			if (scrollVMax+marginBottom > currentPoint.y) {
				currentPoint.y = scrollVMax + marginBottom;
			}else if(currentPoint.y>marginTop) {
				currentPoint.y = marginTop;
			}
			
			if(isHorizontal)x = currentPoint.x;
			if(isVerticale)y = currentPoint.y;
		}
		
	}

}