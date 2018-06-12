use "debug"

class Position is Stringable
  let line: USize
  let char: USize

  new val create(line': USize, char': USize) =>
    line = line'
    char = char'

  fun box string(): String iso^ =>
    recover iso
      let str: String = line.string() + ", " + char.string()
      str.clone()
    end

  
class Cursor
  var line: USize
  var char: USize
  var buffer: Buffer

  new create(buffer': Buffer, line': USize = 0, char': USize = 0) =>
    """
    By default start from position 0,0.

    Position starts from upper left corner and counts downwards.
    (0,0) => upper left corner.
    """
    line = line'
    char = char'
    buffer = buffer'

  fun position(): Position val =>
    Position(line, char)

  fun _line_end(str: String): USize =>
    str.size()

  fun ref _increase_line(amount: USize = 1): String ? =>
    let str = buffer.lines(line + amount) ?
    line = line + amount
    str

  fun ref _decrease_line(amount: USize = 1): String ? =>
    let new_amount = line - amount
    let str = buffer.lines(new_amount) ?
    line = new_amount
    str

  fun ref _increase_char(str: String, amount: USize = 1)? =>
    str(char + (amount - 1))? // can be on last empty char
    char = char + amount
    
  fun ref _decrease_char(str: String, amount: USize = 1)? =>
    let new_amount = char - amount
    str(new_amount)?
    char = new_amount
    
  fun ref right() =>
    try
      _increase_char(buffer.lines(line)?)?
    else
      try
        _increase_line()?
        char = 0
      end
    end

  fun ref left() =>
    try
      _decrease_char(buffer.lines(line)?)?
    else
      try
        let old_line = line.usize()
        let str = _decrease_line()?
        if (line == 0) and (old_line == 0) then
          char = 0
        else
          char = _line_end(str)
        end
      end
    end

  fun ref _char_current_or_end_of_line(str: String) =>
    if str.size() < char then
      char = _line_end(str)
    end
  
  fun ref down() =>
    try
      let str = _increase_line()?
      _char_current_or_end_of_line(str)
    end
    
  fun ref up() =>
    try
      let str = _decrease_line()?
      _char_current_or_end_of_line(str)
    end
