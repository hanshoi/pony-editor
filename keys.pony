primitive Enter fun apply(): U8 => 0x0A
primitive BackSpace fun apply(): U8 => 127

type SpecialKey is (Enter | BackSpace)

primitive Up
primitive Down
primitive Left
primitive Right

type NavigationKey is (Up | Down | Right | Left)
