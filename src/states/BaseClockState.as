package states
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class BaseClockState extends BaseState
	{
		private var _timer:Timer;
		protected var _totalTickCount:int = 0;
		
		private var _trayIcon16Clip:MovieClip;
		private var _trayIcon128Clip:MovieClip;
		
		public function BaseClockState()
		{
			super();
			Game.instance.sound.play(Tick3Sound, int.MAX_VALUE);
			
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_timer.start();
			
			_trayIcon16Clip = new TrayTime16Clip();
			_trayIcon128Clip = new TrayTime128Clip();
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			_totalTickCount --;
			
			updateTrayIcon();
			
			if(_totalTickCount <= 0) {
				timeIsUp();
			}
		}
		
		private function updateTrayIcon():void
		{
			var minutesCount:int = Math.floor(_totalTickCount / 60);
			var secondsCount:int = _totalTickCount - minutesCount * 60;
			
			var trayText:String;
			if(minutesCount > 0) {
				trayText = '' + minutesCount;
			} else {
				trayText = '' + secondsCount;
			}
			
			if(_trayIcon16Clip.tfLabel.text != trayText) {
				//_trayIconClip.tfLabel.text = trayText;
				_trayIcon16Clip.tfLabel.text = trayText;
				_trayIcon128Clip.tfLabel.text = trayText;
				IndieTomato.instance.setTrayIconByClipUni(_trayIcon16Clip, _trayIcon128Clip);
			}
		}
		
		protected function timeIsUp():void {
			IndieTomato.instance.notify();
			Game.instance.sound.play(DingSound);
			Game.instance.changeState(new MainMenuState());
			
			/* Активируем но не перехватываем фокус */
			IndieTomato.instance.nw.activate();
		}

		/* Функция дестрой - уничтожает всю активность в стейте. Но не уничтожает внешний вид, поэтому есть возможность сделать плавное исчезание в альфу после дестроя. */
		override public function destroy():void {
			super.destroy();
			
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			Game.instance.sound.stop(Tick3Sound);
		}
		
		protected function getCurrentTimeString():String {
			var s:String;
			var minutesCount:int = Math.floor(_totalTickCount / 60);
			var secondsCount:int = _totalTickCount - minutesCount * 60;
			
			/* Минуты красиво смотрятся и без нуля впереди */
			var minutesString:String = '' + minutesCount;
			var secondsString:String = secondsCount <= 9 ? '0' + secondsCount : '' + secondsCount;
			
			s = minutesString + ':' + secondsString;
			return s;
		}
	}
}