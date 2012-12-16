package
{
    public class Geology
    {
        public static const Monomino:Geology = new Geology(1, [Chunk.Monomino]);

        private var _atomStride:int;
        private var _minoSet:Array;

        public function Geology(atom_stride:int, mino_set:Array)
        {
            _atomStride = atom_stride;
            _minoSet = mino_set;
        }

        public function makeChunk(workspace_w:int = 7, workspace_h:int = 7, n_atoms:int = 20):Chunk
        {
            // build an empty chunk
            var workspace:Chunk = Chunk.empty(workspace_w, workspace_h);
            var atom_count:int = 0;

            // drop a mino in the center of it
            var workspace_center_x:int = workspace_w / 2, 
                workspace_center_y:int = workspace_h / 2;
            // FIXME
            workspace = workspace.tryMerge(_minoSet[0], workspace_center_x, workspace_center_y);
            atom_count += _atomStride;

            // until there are enough atoms in the workspace:
            while (atom_count < n_atoms)
            {
                // choose a random mino
                // FIXME
                var mino:Chunk = _minoSet[0];

                // choose a random side/starting position of the workspace
                var x0:int, y0:int, dx:int, dy:int;

                {
                    var side:int = Math.round(Math.random() * 3);
                    var shadow:Array;

                    // choose direction to move, and the edge to start moving it in from
                    if (side == 0)
                    {
                        // top
                        y0 = 0; dx = 0; dy = 1; shadow = workspace.xShadow;
                    }
                    else if (side == 1)
                    {
                        // right
                        x0 = workspace.width - mino.width; dx = -1; dy = 0; shadow = workspace.yShadow;
                    }
                    else if (side == 2)
                    {
                        // bottom
                        y0 = workspace.height - mino.height; dx = 0; dy = -1; shadow = workspace.xShadow;
                    }
                    else if (side == 3)
                    {
                        // left
                        x0 = 0; dx = 1; dy = 0; shadow = workspace.yShadow;
                    }

                    // choose a random other coord that hits the shadow
                    var shadow_coord:int = -1;

                    while (shadow_coord == -1)
                    {
                        var coord:int = Math.round(Math.random() * (shadow.length - 1));

                        if (shadow[coord]) shadow_coord = coord;
                    }

                    // map that back to the coord we didn't set above
                    if (side == 0 || side == 2) x0 = shadow_coord;
                    else if (side == 1 || side == 3) y0 = shadow_coord;
                }

                // fly the mino in from that side:
                var last_good_merge:Chunk = null;
                // drop it on the extreme edge
                var x:int = x0, y:int = y0;

                while (true)
                {
                    var merged:Chunk = workspace.tryMerge(mino, x, y);

                    if (merged)
                    {
                        // this merge works; write it down
                        last_good_merge = merged;
                        // fly in by one
                        x += dx; y += dy;
                    }
                    else
                    {
                        // this merge doesn't work!  give up.
                        break;
                    }
                }

                // and close this iteration out
                if (last_good_merge)
                {
                    // at least one merge succeeded; that's our new workspace.
                    workspace = last_good_merge;
                    atom_count += _atomStride;
                }
                else
                {
                    // no merges succeeded; try again with different parameters.
                    continue;
                }
            }

            return workspace;
        }
    }
}