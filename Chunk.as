package
{
    public class Chunk
    {
        private static const $:Boolean = true;
        private static const _:Boolean = false;

        // an atom of tetrominium
        public static const Atom:Chunk = new Chunk([[$]]);

        // the 7 tetrominoes
        public static const SBlock:Chunk = new Chunk([[_, $, $],
                                                      [$, $, _]]);

        public static const ZBlock:Chunk = new Chunk([[$, $, _],
                                                      [_, $, $]]);

        public static const LBlock:Chunk = new Chunk([[$, $, $],
                                                      [$, _, _]]);

        public static const JBlock:Chunk = new Chunk([[$, _, _],
                                                      [$, $, $]]);

        public static const TBlock:Chunk = new Chunk([[_, $, _],
                                                      [$, $, $]]);

        public static const OBlock:Chunk = new Chunk([[$, $],
                                                      [$, $]]);

        public static const IBlock:Chunk = new Chunk([[$, $, $, $]]);

        // creates an empty chunk pattern of the given dimensions
        public static function empty(w:int, h:int):Chunk
        {
            var new_arr:Array = new Array(h);

            for (var y:int = 0; y < h; y++)
            {
                new_arr[y] = new Array(w);

                for (var x:int = 0; x < w; x++)
                {
                    new_arr[y][x] = _;
                }
            }

            return new Chunk(new_arr);
        }

        public function Chunk(pattern:Array)
        {
            arr = pattern;
        }

        // compute "shadows" - the sets of x and y coordinates that contain one or more atoms of tetrominium
        private function computeShadows():void
        {

        }

        // return the state of a given pixel in this chunk
        public function at(x:int, y:int):Boolean
        {
            return arr[y][x];
        }

        private var arr:Array;
    }
}