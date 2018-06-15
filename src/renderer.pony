use "term"
use "debug"
use "ncurses-pony"


class Renderer
  let screen: Window
  let main_window: Window
  let debug_window: Window

  new create() =>
    screen = Curses.initscr()
    screen.keypad(true)
    main_window = Curses.newwin()
    debug_window = Curses.newwin(60, 60, 0, 81)
    Curses.noecho()
    Curses.cbreak()
    Curses.clear()
    main_window.clear()

    debug("debug")

    main_window.printw("welcome!")
    main_window.refresh()

  fun ref close() =>
    main_window.delwin()
    Curses.endwin()

  fun ref debug(str: String) =>
    // debug_window.clear()
    debug_window.printw(str)
    debug_window.refresh()

  fun ref render(buffer: Buffer) =>
    // main_window.clear()
    for (index, line) in buffer.lines.pairs() do
      main_window.mvprintw(index.i32(), 0, line)
    end
    main_window.refresh()

  fun ref clear() =>
    main_window.clear()
    debug_window.clear()

  fun ref cursor(position: Position val) =>
    main_window.move(position.line.i32(), position.char.i32())
    main_window.refresh()



