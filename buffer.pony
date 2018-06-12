primitive MAX


class Buffer
  let name: String
  var lines: Array[String]

  new create(initial: Array[String] = [""]) =>
    lines = initial
    name = "empty"

  fun size(): USize =>
    lines.size()

  fun ref writec(char: U8, position: Position val) =>
    try
      let line = position.line
      var str: String trn = lines(line)?.clone()
      str.insert_byte(position.char.isize(), char)
      lines.delete(line)?
      lines.insert(line, consume str)?
    end

  fun ref new_line(line': USize) =>
    // add new line below current line
    try
      lines.insert(line' + 1, "")?
    end
