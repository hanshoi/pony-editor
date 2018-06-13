use "term"
use "debug"
use "ncurses-pony"

class RenderablePosition
  let line: I32
  let char: I32

  new val create(position: Position val) =>
    """
    Rendering uses different types for cursor placement.
    Also we need to change the programs 0,0 placement to 1,1 here.
    """
    line = position.line.i32() + 1
    char = position.char.i32() + 1


class Renderer
  let out: OutStream
  let main_window: Window

  new create(out': OutStream) =>
    out = out'
    let parent = Curses.initscr()
    parent.keypad(true)
    main_window = Curses.newwin()
    Curses.clear()
    main_window.clear()
    Curses.noecho()
    Curses.cbreak()
    Curses.clear()
    main_window.printw("welcome!")
    main_window.refresh()

  fun ref close() =>
    main_window.dispose()
    Curses.endwin()

  fun ref render(buffer: Buffer) =>
    clear()
    for line in buffer.lines.values() do
      main_window.printw(line)
    end
    main_window.refresh()

  fun ref clear() =>
    main_window.clear()

  fun ref cursor(position: Position val) =>
    let rend_position = RenderablePosition(position)
    main_window.move(rend_position.line, rend_position.char)
    main_window.refresh()



