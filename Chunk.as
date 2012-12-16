package
{
    public class Chunk
    {
        private static const $:Boolean = true;
        private static const _:Boolean = false;

        // an atom of tetrominium
        public static const Monomino:Chunk = new Chunk([[$]]);

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
            computeShadows();
        }

        // compute "shadows" - the sets of x and y coordinates that contain one or more blocks of tetrominium
        private function computeShadows():void
        {
            var y_shadow:Array = new Array(height);
            var x_shadow:Array = new Array(width);

            // clear shadows
            var clear:Function = function(obj:Object, index:int, arr:Array):void { arr[index] = false; };
            x_shadow.forEach(clear);
            y_shadow.forEach(clear);

            // populate shadows
            for (var y:int = 0; y < height; y++)
            {
                for (var x:int = 0; x < width; x++)
                {
                    if (arr[y][x]) 
                    {
                        x_shadow[x] = true;
                        y_shadow[y] = true;
                    }
                }
            }

            xShadow = x_shadow;
            yShadow = y_shadow;
        }

        // return the state of a given pixel in this chunk
        public function at(x:int, y:int):Boolean
        {
            return arr[y][x];
        }

        public function get width():int { return arr[0].length; }
        public function get height():int { return arr.length; }

        private var arr:Array;

        private var xShadow:Array;
        private var yShadow:Array;
    }
}