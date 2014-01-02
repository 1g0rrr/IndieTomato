package states
{
	import flash.events.MouseEvent;

	public class MainMenuState extends BaseState
	{
		private var _clip:MainStateClip;
		public function MainMenuState()
		{
			super();
			_clip = new MainStateClip();
			addChild(_clip);
			
			_clip.btn25min.addEventListener(MouseEvent.MOUSE_DOWN, btn25minHandler);
			_clip.btn15min.addEventListener(MouseEvent.MOUSE_DOWN, btn15minHandler);
			_clip.btn5min.addEventListener(MouseEvent.MOUSE_DOWN, btn5minHandler);
			
			var trayIcon16Clip:TrayInit16Clip = new TrayInit16Clip();
			var trayIcon128Clip:TrayInit128Clip = new TrayInit128Clip();
			IndieTomato.instance.setTrayIconByClipUni(trayIcon16Clip, trayIcon128Clip);
		}
		
		protected function btn25minHandler(event:MouseEvent):void {
			Game.instance.changeState(new WorkState());
		}
		
		
		protected function btn15minHandler(event:MouseEvent):void {
			Game.instance.changeState(new Relax15minState());
		}
		
		
		protected function btn5minHandler(event:MouseEvent):void {
			Game.instance.changeState(new Relax5minState());
		}
	}
}