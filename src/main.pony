use "term"
use "debug"

actor Main
  new create(env: Env) =>
    let editor = Editor(env)
    let term = ANSITerm(recover InputNotifier(editor) end, env.input)

    let notify = object iso
      let term: ANSITerm = term
      fun ref apply(data: Array[U8] iso) => term(consume data)
      fun ref dispose() =>
        term.dispose()
        editor.dispose()
    end

    env.input(consume notify)


actor Editor
  var buffer: Buffer
  let cursor: Cursor
  let renderer: Renderer

  new create(env: Env) =>
    renderer = Renderer.create()
    buffer = Buffer()
    cursor = Cursor(buffer)

  be dispose() =>
    renderer.close()

  be handle(input: U8 val) =>
    match input
      | Enter() => new_line()
    else
      write(input)
    end

  fun ref write(char: U8 val) =>
    buffer.writec(char, cursor.position())
    renderer.render(buffer)
    right()
    renderer.cursor(cursor.position())

  fun ref new_line() =>
    buffer.new_line(cursor.position().line)
    cursor.down()
    renderer.cursor(cursor.position())

  be left() =>
    cursor.left()
    renderer.cursor(cursor.position())

  be right() =>
    cursor.right()
    renderer.cursor(cursor.position())

  be down() =>
    cursor.down()
    renderer.cursor(cursor.position())

  be up() =>
    cursor.up()
    renderer.cursor(cursor.position())


class InputNotifier is ANSINotify
  let _editor: Editor

  new create(editor: Editor) =>
    _editor = editor

  fun ref apply(term: ANSITerm ref, input: U8 val) =>
    _editor.handle(input)

  fun ref up(ctrl: Bool, alt: Bool, shift: Bool) =>
    _editor.up()

  fun ref down(ctrl: Bool, alt: Bool, shift: Bool) =>
    _editor.down()

  fun ref left(ctrl: Bool, alt: Bool, shift: Bool) =>
    _editor.left()

  fun ref right(ctrl: Bool, alt: Bool, shift: Bool) =>
    _editor.right()

  fun ref delete(ctrl: Bool, alt: Bool, shift: Bool) =>
    Debug.out("delete")
