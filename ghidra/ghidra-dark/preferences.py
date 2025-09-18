from typing import Tuple

class State():
    def __init__(self, value, name=""):
        self.tag = "STATE"
        self.name = name
        self.value = str(value)
        if type(value) == str:
            self.type = "string"
        elif type(value) == bool:
            self.type = "boolean"
        elif type(value) == int:
            self.type = "int"
        else:
            self.type = "unknown"

class Enum():
    def __init__(self, value, classname, name=""):
        self.tag = "ENUM"
        self.type = "enum"
        self.name = name
        self.value = str(value)
        self.classname = classname

class Wrapped():
    def __init__(self, *states: Tuple[State]):
        self.tag = "WRAPPED_OPTION"
        self.states = states
        self.classname = "ghidra.framework.options.Wrapped{}".format(self.__class__.__name__)

class Color(Wrapped):
    def __init__(self, color: str):
        super().__init__(
            State(color, "color")    
        )

class Font(Wrapped):
    def __init__(self, size: int, style: int, family: str):
        super().__init__(
            State(size, "size"),
            State(style, "style"),
            State(family, "family")
        )

class KeyStroke(Wrapped):
    def __init__(self, keyCode: int, modifiers: int):
        super().__init__(
            State(keyCode, "KeyCode"),
            State(modifiers, "Modifiers")
        )

MOUSE_BTN = "ghidra.GhidraOptions$CURSOR_MOUSE_BUTTON_NAMES"

preferences = {
    "Listing Fields": {
        "Cursor Text Highlight.Mouse Button To Activate": Enum("LEFT", MOUSE_BTN), # updated
        "Cursor Text Highlight.Highlight Color": Color(0xCCCCCC),
        "Cursor Text Highlight.Scoped Read Highlight Color": Color(0xCCCCCC),
        "Cursor Text Highlight.Scoped Write Highlight Color": Color(0xCCCCCC),
        "Cursor.Cursor Color - Focused": Color(0xC5C8C6),
        "Cursor.Cursor Color - Unfocused": Color(0x373B41),
        "Cursor.Highlight Cursor Line Color": Color(0x373B41),
        "Selection Colors.Difference Color": Color(0x56585B),
        "Selection Colors.Highlight Color": Color(0x56585B),
        "Selection Colors.Selection Color": Color(0x56585B),
    },
    "Decompiler": {
        "Display.Background Color": Color(0x282A2E),
        "Display.Color Default": Color(0xFFFFFF),
        "Display.Color for Comments": Color(0x339900),
        "Display.Color for Constants": Color(0x66FF33),
        "Display.Color for Current Variable Highlight": Color(0x999999),
        "Display.Color for Function names": Color(0xFFFF00),
        "Display.Color for Keywords": Color(0xFF00FF),
        "Display.Color for Parameters": Color(0x00CCCC),
        "Display.Color for Types": Color(0x3399FF),
        "Display.Color for Variables": Color(0xFFFFFF),
        "Display.Font": Font(12, 0, "Monospaced")
    },
    "Graph": {
        "Function Call Graph.Graph Background Color": Color(0xFFFFFF),
        "Function Graph.Default Vertex Color": Color(0x282A2E),
        "Function Graph.Edge Color - Conditional Jump ": Color(0x33CCFF),
        "Function Graph.Edge Color - Conditional Jump Highlight": Color(0x33CCFF),
        "Function Graph.Edge Color - Fallthrough ": Color(0xFF0000),
        "Function Graph.Edge Color - Fallthrough Highlight": Color(0xFF0000),
        "Function Graph.Edge Color - Unconditional Jump ": Color(0xFFFF00),
        "Function Graph.Edge Color - Unconditional Jump Highlight": Color(0xFFFF00),
        "Function Graph.Graph Background Color": Color(0x45494A),
    },
    "Search": {
        "Highlight Color for Current Match": Color(0x49483E),
        "Highlight Color": Color(0xFFFFC8),
    },
    "Listing Display": {
        "BASE FONT": Font(12, 0, "Monospaced"),
        "Address Color": Color(0xFFFFFF),
        "Background Color": Color(0x282A2E),
        "Bad Reference Address Color": Color(0xFF0000),
        "Bytes Color": Color(0x99FFFF),
        "Comment, Automatic Color": Color(0x5F819D),
        "EOL Comment Color": Color(0x5F819D),
        "Plate Comment Color": Color(0x5F819D),
        "Post-Comment Color": Color(0x5F819D),
        "Pre-Comment Color": Color(0x5F819D),
        "Comment, Referenced Repeatable Color": Color(0x5F819D),
        "Comment, Repeatable Color": Color(0x5F819D),
        "Constant Color": Color(0x66FF33),
        "Entry Point Color": Color(0xFFFF00),
        "External Reference, Resolved Color": Color(0x5E8D87),
        "Field Name Color": Color(0xFFFFFF),
        "Flow Arrow, Active Color": Color(0xC5C8C6),
        "Flow Arrow, Not Active Color": Color(0xA0A0A0), # updated
        "Function Call-Fixup Color": Color(0xB294BB),
        "Function Name Color": Color(0xFFFF00),
        "Function Parameters Color": Color(0x0099FF),
        "Function Return Type Color": Color(0x0066FF),
        "Function Tag Color": Color(0xFF9900),
        "Labels, Local Color": Color(0x8C9440),
        "Labels, Non-primary Color": Color(0xFFFF00),
        "Labels, Primary Color": Color(0xFFFF00),
        "Labels, Unreferenced Color": Color(0xC5C8C6),
        "Mnemonic Color": Color(0xFF00FF),
        "Mnemonic, Override Color": Color(0xFF33FF),
        "Parameter, Custom Storage Color": Color(0x339900),
        "Parameter, Dynamic Storage Color": Color(0x5E8D87),
        "Registers Color": Color(0xFFFFFF),
        "Separator Color": Color(0x339900),
        "Underline Color": Color(0xB294BB),
        "Variable Color": Color(0x339900),
        "Version Track Color": Color(0xB294BB),
        "XRef Color": Color(0x339900),
        "XRef Offcut Color": Color(0x339900),
        "XRef Other Color": Color(0xC5C8C6),
        "XRef Read Color": Color(0x5F819D),
        "XRef Write Color": Color(0xDE935F),
    },
    "Comments": {
        "Enter accepts comment": State(True)
    },
}
