package
{
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.NotificationType;
	import flash.desktop.SystemTrayIcon;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	
	public class BaseDockingApp extends Sprite
	{

		private var _nw:NativeWindow;
		public function get nw():NativeWindow { return _nw; }
		
		public function BaseDockingApp()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initializeHandler);
		}
		
		protected function initializeHandler(event:Event):void
		{
			_nw = this.stage.nativeWindow;
			prepareTray();
		}
		/*
		public function setTrayIconByClip(clip:MovieClip):void {
			var bd:BitmapData = new BitmapData(16, 16, true,  0x00ffffff); // формат цвета вместе с альфой 
			bd.draw(clip);
			NativeApplication.nativeApplication.icon.bitmaps = [bd];
		}
	*/
		
		public function setTrayIconByClipUni(clip16:MovieClip, clip128):void {
			var bd16:BitmapData = new BitmapData(16, 16, true,  0x00ffffff); /* формат цвета вместе с альфой */
			bd16.draw(clip16);
			var bd128:BitmapData = new BitmapData(128, 128, true,  0x00ffffff); /* формат цвета вместе с альфой */
			bd128.draw(clip128);
			
			
			NativeApplication.nativeApplication.icon.bitmaps = [bd16, bd128];
		}
		
		public function notify():void {
			if(NativeApplication.supportsDockIcon){
				var dock:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
				dock.bounce(NotificationType.CRITICAL);
			} else if (NativeApplication.supportsSystemTrayIcon){
				stage.nativeWindow.notifyUser(NotificationType.CRITICAL);
			}		
		}
		
		
		public function prepareTray():void {
			/*Добавляем событие на клик, а также добавляем меню. */
			/* supportsDockIcon - используется для МакОС. */
			/* supportsSystemTrayIcon - используется для Винды. */
			if(NativeApplication.supportsDockIcon){
				
				var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
				NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, trayLeftClickHandler);
				dockIcon.menu = createTrayMenu();
				
			} else if (NativeApplication.supportsSystemTrayIcon) {
				
				var sysTrayIcon:SystemTrayIcon =
					NativeApplication.nativeApplication.icon as SystemTrayIcon;
				sysTrayIcon.tooltip = "Indie Tomato"; /* !!! Некрасивое место. Универсальный класс зависит от текста тултипа */
				sysTrayIcon.addEventListener(MouseEvent.CLICK, trayLeftClickHandler);
				sysTrayIcon.menu = createTrayMenu();
			}		
		}

		/* Эту функцию нужно переопределять */
		protected function createTrayMenu():NativeMenu{
			return null;
		}		
		
		/* Эту функцию нужно переопределять */
		public function trayLeftClickHandler(event:Event = null):void {
			/* Эту функцию можно переопределить при желании */
		}
		
	}
}