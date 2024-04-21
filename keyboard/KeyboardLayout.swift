struct KeyboardLayout {
    var keys: [[String]]
    var hints: [String:String] = [:]
    
    static let anburLayout = KeyboardLayout(
        keys: [
            ["𐍰", "𐍮", "𐍔", "𐍠", "𐍢", "𐍯", "𐍣", "𐍙", "𐍩", "𐍟", "𐍣̈"],
            ["𐍐", "𐍡", "𐍓", "𐍫", "𐍒", "𐍬", "𐍙̈", "𐍚", "𐍛", "𐍩̈", "𐍐̈"],
            ["shift", "𐍥", "𐍗", "𐍕", "𐍭", "𐍑", "𐍝", "𐍜", "𐍤", "backspace"],
            ["123", "globe", "space", ".", "return"]
        ],
        hints: [
            "𐍰": "\'", "𐍮": "W", "𐍔": "E", "𐍠": "R", "𐍢": "T", "𐍯": "Õ", "𐍣": "U", "𐍙": "I", "𐍩": "O", "𐍟": "P",
            "𐍣̈": "Y", "𐍐": "A", "𐍡": "S", "𐍓": "D", "𐍫": "F", "𐍒": "G", "𐍬": "H", "𐍙̈": "J", "𐍚": "K", "𐍛": "L",
            "𐍩̈": "Ö", "𐍐̈": "Ä", "𐍥": "Š", "𐍗": "Z", "𐍕": "Ž", "𐍭": "TS", "𐍑": "B", "𐍝": "N", "𐍜": "M", "𐍤": "CH"
        ]
    )
    
    static let englishLayout = KeyboardLayout(
        keys: [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
            ["shift", "z", "x", "c", "v", "b", "n", "m", "backspace"],
            ["123", "globe", "space", "return"]
        ])
    
    static let punctuationLayout = KeyboardLayout(
        keys: [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
            ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""],
            ["#+=", ".", ",", "?", "!", "\'", "backspace"],
            ["ABC", "globe", "space", "return"]
        ])
    
    static let secondaryPunctuationLayout = KeyboardLayout(
        keys: [
            ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
            ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"],
            ["123", ".", ",", "?", "!", "\'", "backspace"],
            ["ABC", "globe", "space", "return"]
        ])
}
