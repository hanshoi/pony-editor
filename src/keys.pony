primitive Enter fun apply(): U8 => 13
primitive BackSpace fun apply(): U8 => 127

type SpecialKey is (Enter | BackSpace)

primitive Up
primitive Down
primitive Left
primitive Right

type NavigationKey is (Up | Down | Right | Left)
