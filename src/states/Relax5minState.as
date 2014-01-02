package states
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;

	public class Relax5minState extends BaseClockState
	{
		private var _clip:RelaxStateClip;
		public function Relax5minState()
		{
			super();
			_totalTickCount = Settings.shotRelaxLength;
			_clip = new RelaxStateClip();
			addChild(_clip);
			
			_clip.btnStop.addEventListener(MouseEvent.MOUSE_DOWN, stopHandler);

			/* Выставляем начальное положение часов */
			timerHandler(null);
		}
		
		protected function stopHandler(event:MouseEvent):void {
			Game.instance.changeState(new MainMenuState());
		}
		
		override protected function timerHandler(event:TimerEvent):void {
			super.timerHandler(event);
			_clip.tfTime.text = getCurrentTimeString();
		}
	}
}