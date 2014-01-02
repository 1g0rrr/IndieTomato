package
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import states.BaseState;
	import states.MainMenuState;
	
	public class Game extends Sprite
	{
		public static var instance:Game;
		
		public var sound:SoundsManager;
		
		private var _state:BaseState;
		private var _oldState:BaseState;
		
		private var _mainBG:MovieClip;

		public function Game()
		{
			super();
			
			instance = this;

			sound = new SoundsManager();
			
			_mainBG = new MainBackgroundClip();
			addChild(_mainBG);
			
			
			changeState(new MainMenuState());
		}
		
		public function changeState(state:BaseState):void {
			var fadeTime:Number = 0.3;
			/* Если не первый запуск приложения и какое-нибудь состояние уже существует, то удаляем его сначала фейдом, а потом окончательно */
			if(_state != null) {
				_oldState = _state;
				_oldState.destroy();
				TweenLite.killTweensOf(_oldState);
				TweenLite.to(_oldState, fadeTime, {alpha: 0, onComplete: hideOldComplete});
			}
			
			/* Показываем фейдом новое состояние */
			_state = state;
			_state.alpha = 0;
			TweenLite.killTweensOf(_state);
			TweenLite.to(_state, fadeTime, {alpha: 1});
			
			this.addChild(_state);
		}
		
		private function hideOldComplete():void {
			if(this.contains(_oldState))
				this.removeChild(_oldState);
		}
		
	}
}