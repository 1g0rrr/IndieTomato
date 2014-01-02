package states
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;

	public class WorkState extends BaseClockState
	{
		private var _clip:WorkStateClip;
		public function WorkState()
		{
			super();
			_totalTickCount = Settings.tomatoLength;
			_clip = new WorkStateClip();
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