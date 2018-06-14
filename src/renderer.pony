use "term"
use "debug"
use "ncurses-pony"

actor Debugger
  let window: Window
  
  new create() =>
    window = Curses.newwin(60, 60, 0, 81)

  be apply(str: String) =>
    window.printw(str)
    window.refresh()


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
    Debugger("debug")

  fun ref close() =>
    main_window.delwin()
    Curses.endwin()

  fun ref render(buffer: Buffer) =>
    clear()
    for (index, line) in buffer.lines.pairs() do
      main_window.mvprintw(index.i32(), 0, line)
    end
    main_window.refresh()

  fun ref clear() =>
    main_window.clear()

  fun ref cursor(position: Position val) =>
    main_window.move(position.line.i32(), position.char.i32())
    main_window.refresh()



