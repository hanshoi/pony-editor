use "term"
use "debug"
use "ncurses-pony"

class RenderablePosition
  let line: U32
  let char: U32

  new val create(position: Position val) =>
    """
    Rendering uses different types for cursor placement.
    Also we need to change the programs 0,0 placement to 1,1 here.
    """
    line = position.line.u32() + 1
    char = position.char.u32() + 1

    
class Renderer
  let out: OutStream

  new create(out': OutStream) =>
    out = out'
    Nc.initscr()
    clear()

  fun render(buffer: Buffer) =>
    clear()
    for line in buffer.lines.values() do
      out.print(line)
    end

  fun clear() =>
    out.write(ANSI.clear())

  fun cursor(position: Position val) =>
    let rend_position = RenderablePosition(position)
    out.write(ANSI.cursor(rend_position.char, rend_position.line))
    

  
