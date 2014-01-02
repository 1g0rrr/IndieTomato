package
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundsManager
	{
		private var _soundsMap:Object = new Object();
		public var _currentSoundChannel:SoundChannel;
		public var _currentSoundLabel:Object;
		
		public function SoundsManager()
		{
			_soundsMap[Tick3Sound] = {sound: new Tick3Sound(), volume: 0.5};
			_soundsMap[DingSound] = {sound: new DingSound(), volume: 2};
		}
		
		public function play(label:Object, repeatCount:int = 1):void {
			
			/*
			 * Одновременно может проигрываться только один звук.
			 **/
			if (_currentSoundChannel) {
				_currentSoundChannel.stop();
				_currentSoundChannel = null;
			}			
			
			_currentSoundLabel = label;
			_currentSoundChannel = _soundsMap[label].sound.play(0, repeatCount);
			
			var transform:SoundTransform = new SoundTransform();
			transform.volume = _soundsMap[label].volume;
			_currentSoundChannel.soundTransform = transform;			
		}
		
		public function stop(label:Object = null):void {
			if(label == null) {
				_currentSoundChannel.stop();
			} else {
				if(_currentSoundLabel == label) {
					_currentSoundChannel.stop();
				}
			}
		}
	}
}