package
{
    import org.flixel.*;

    public class IntroState extends FlxState
    {
        [Embed(source="./data/domino.png")]
        private var monominoGfx:Class;

        private function printChunk(chunk:Chunk):void
        {
            for (var y:int = 0; y < chunk.height; y++)
            {
                var row_string:String = "";

                for (var x:int = 0; x < chunk.width; x++)
                {
                    row_string += chunk.at(x, y) ? "*" : " ";
                }

                FlxG.log(row_string);
            }
        }

        private function drawChunk(chunk:Chunk, screen_x0:int, screen_y0:int):void
        {
            var sprite:FlxSprite = new FlxSprite(0, 0, monominoGfx);
            var sprite_w:int = sprite.frameWidth, sprite_h:int = sprite.frameHeight;

            for (var y:int = 0; y < chunk.height; y++)
            {
                for (var x:int = 0; x < chunk.width; x++)
                {
                    if (!chunk.at(x, y)) continue;

                    var screen_x:int = screen_x0 + x * sprite_w;
                    var screen_y:int = screen_y0 + y * sprite_h;

                    var sprite:FlxSprite = new FlxSprite(screen_x, screen_y, monominoGfx);
                    add(sprite);
                }
            }
        }

        public override function create():void
        {
            var chk:Chunk = Geology.makeChunk();
            drawChunk(chk, 50, 50);
        }
    }
}
