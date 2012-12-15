package
{
	import org.flixel.*;

	[SWF(width="640", height="480", backgroundColor="#000000")]
	public class Madvillain extends FlxGame
	{
		public function Madvillain()
		{
			super(640, 480, IntroState, 1);
			FlxG.debug = true;
		}
	}
}
