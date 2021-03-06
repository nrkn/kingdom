package
{
	import org.flixel.*;
	import flash.ui.Mouse;	
    import mochi.as3.MochiScores;

	public class GameOverState extends FlxState
	{        
		private var nights:int = 0;

		public function GameOverState(nightsSurvived:int){
			this.nights = nightsSurvived;
		}

		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,10,FlxG.width,"Game Over");
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(0,FlxG.height-20,FlxG.width,"click to retry");
			t.alignment = "center";
			add(t);
			
			t = new FlxText(0,32,FlxG.width,"'Kingdom' by noio");
			t.alignment = "center";
			add(t);

			FlxG.stage.displayState = 'normal';

            var o:Object = { n: MochiWrapper.SCOREBOARD_ID, f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
            var boardID:String = o.f(0,"");
            MochiScores.showLeaderboard({boardID: boardID, score: nights,
            	onDisplay: onLeaderboardDisplay,
            	onClose: onLeaderboardClose});
		}

		private function onLeaderboardDisplay():void{
			FlxG.mouse.hide();
			Mouse.show();
		}

		private function onLeaderboardClose():void{
			FlxG.mouse.show();
			Mouse.hide();
		}

		override public function update():void
		{
			super.update();

			if(FlxG.mouse.justPressed())
			{
				FlxG.mouse.hide();
				FlxG.switchState(new MenuState());
				MochiScores.closeLeaderboard();
			}
		}
	}
}
