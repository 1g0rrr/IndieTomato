package
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Screen;
	import flash.events.Event;
	
	
	[SWF(width="161", height="101", frameRate="30")]
	public class IndieTomato extends BaseDockingApp
	{
		
		/* Нужно организовать отдельный Гейм. */
		public static var instance:IndieTomato;
		
		private var _game:Game;
		
		private var settingsCommand:NativeMenuItem = new NativeMenuItem("Settings");
		private var aboutCommand:NativeMenuItem = new NativeMenuItem("About");
		
		public function IndieTomato()
		{
			super();
			instance = this;
		}
		
		override protected function initializeHandler(event:Event):void
		{
			super.initializeHandler(event);
			nw.x = Screen.mainScreen.visibleBounds.width - Settings.width - 10;
			nw.y = Screen.mainScreen.visibleBounds.height - Settings.height - 10;
			
			nw.alwaysInFront = true;
			/* ПРиложение прячется, т.к. при нажатии на док, срабатывает - деактивейт 
				Можно поставить флаг, который проверяет, док ли нажат у приложения или оно просто потеряло фокус. 
				Но не обязательно 
			*/
			nw.addEventListener(Event.DEACTIVATE, deactivateHandler);
			
			_game = new Game();
			addChild(_game);
			
		}
		
		protected function deactivateHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			nw.visible = false;
		}
		
		override public function trayLeftClickHandler(event:Event = null):void {
			super.trayLeftClickHandler(event);
			nw.activate();
			NativeApplication.nativeApplication.activate(nw); /* Это важная функция, которая перехватывает фокус приложения. Нужно её вызывать при нажатии на док, чтобы фокус был сразу где надо. */
		}		
		
		override protected function createTrayMenu():NativeMenu{
			var iconMenu:NativeMenu = new NativeMenu();
			
			iconMenu.addItem(settingsCommand);
			settingsCommand.addEventListener(Event.SELECT, settingsHandler);
			settingsCommand.enabled = false;
			
			iconMenu.addItem(aboutCommand);
			aboutCommand.addEventListener(Event.SELECT, aboutHandler);
			aboutCommand.enabled = false;
			
			iconMenu.addItem(new NativeMenuItem("", true));//Separator
			
			if(NativeApplication.supportsSystemTrayIcon){
				
				/* Возможно потом добавлю возможность появления из контекстного меню */
				//iconMenu.addItem(showCommand);
				//showCommand.addEventListener(Event.SELECT, getOutFromDock);
				iconMenu.addItem(new NativeMenuItem("", true));//Separator
				
				/* exit используем только для винды, т.к. в МакОС эта команда встроена */
				var exitCommand: NativeMenuItem = iconMenu.addItem(new NativeMenuItem("Exit"));
				exitCommand.addEventListener(Event.SELECT, exitHandler);
			}
			return iconMenu;
		}
		
		protected function exitHandler(event:Event):void {
			nw.close();
		}
		
		protected function aboutHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function settingsHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
	}
}