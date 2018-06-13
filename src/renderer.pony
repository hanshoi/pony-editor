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
  let main_window: Pointer[Window]

  new create(out': OutStream) =>
    out = out'
    let parent = Nc.initscr()
    main_window = Nc.newwin(60, 80, 26, 2)
    Nc.clear()
    Nc.wclear(main_window)
    Nc.noecho()
    Nc.cbreak()
    Nc.keypad(parent, true)
    Nc.curs_set(0)
    Nc.clear()
    Nc.wprintw(main_window, "wwelcome!")
    Nc.printw("welcome!")
    Nc.refresh()

  fun ref close() =>
    Nc.delwin(main_window)
    Nc.endwin()

  fun ref render(buffer: Buffer) =>
    clear()
    for line in buffer.lines.values() do
      Nc.printw(line)
    end
    Nc.refresh()

  fun ref clear() =>
    Nc.wclear(main_window)

  fun cursor(position: Position val) =>
    Debug.out("")
    // let rend_position = RenderablePosition(position)
    // out.write(ANSI.cursor(rend_position.char, rend_position.line))



