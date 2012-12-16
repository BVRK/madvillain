package
{
    import org.flixel.*;

    public class IntroState extends FlxState
    {
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

        public override function create():void
        {
            var chk:Chunk = Geology.makeChunk();
            printChunk(chk);
        }
    }
}
