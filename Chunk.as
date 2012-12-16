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

        public function Chunk(pattern:Array, x_shadow:Array = null, y_shadow:Array = null)
        {
            _arr = pattern;

            if (x_shadow == null || y_shadow == null)
            {
                computeShadows();
            }
            else
            {
                _xShadow = x_shadow;
                _yShadow = y_shadow;
            }
        }

        public function clone():Chunk
        {
            // deep-copy chunk array
            var new_arr:Array = new Array(_arr.length);
            
            for (var y:int = 0; y < _arr.length; y++)
            {
                // one weird trick discovered by a mom to deep-copy an array
                new_arr[y] = _arr[y].concat();
            }
            
            return new Chunk(new_arr, _xShadow.concat(), _yShadow.concat());
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
                    if (_arr[y][x]) 
                    {
                        x_shadow[x] = true;
                        y_shadow[y] = true;
                    }
                }
            }

            _xShadow = x_shadow;
            _yShadow = y_shadow;
        }

        // try to draw the small chunk on this chunk at the given coordinates
        public function tryMerge(small:Chunk, small_x0:int, small_y0:int):Chunk
        {
            // if the small chunk is off the left/top, fail
            if (small_x0 < 0 || small_y0 < 0) return null;
            // if the small chunk is off the right/bottom, fail
            if (small_x0 + small.width > width || small_y0 + small.height > height) return null;

            // build a place to put the merged chunk.
            var newChunk:Chunk = clone();

            // for each pixel in the small chunk:
            for (var small_y:int = 0; small_y < small.height; small_y++)
            {
                for (var small_x:int = 0; small_x < + small.width; small_x++)
                {
                    // if pixel is set:
                    if (small.at(small_x, small_y))
                    {
                        // compute transformed coordinate
                        var xform_x:int = small_x + small_x0, xform_y:int = small_y + small_y0;
                        // if this chunk is set at coordinate, bomb out
                        if (at(xform_x, xform_y)) return null;
                        // otherwise scribble on the new chunk
                        newChunk.set(xform_x, xform_y);
                    }
                }
            }
            
            // recompute the chunk's shadows.
            newChunk.computeShadows();

            return newChunk;
        }

        // return the state of a given pixel in this chunk
        public function at(x:int, y:int):Boolean
        {
            return _arr[y][x];
        }

        // fill in a given pixel in this chunk
        private function set(x:int, y:int):void
        {
            _arr[y][x] = true;
        }

        public function get width():int { return _arr[0].length; }
        public function get height():int { return _arr.length; }

        public function get xShadow():Array { return _xShadow; }
        public function get yShadow():Array { return _yShadow; }

        private var _arr:Array;

        private var _xShadow:Array;
        private var _yShadow:Array;
    }
}