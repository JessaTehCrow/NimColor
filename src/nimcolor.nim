import nre
import tables
import strutils
import strformat
import parseutils


type
    Rgb = array[3,string]


proc getKeys(table:Table[string,int]): seq[string] =
    var keys:seq[string] = @[]

    for k,v in table:
        keys.add(k)
    
    return keys


const
    colors:Table[string, int] = {
        "reset" : 0,
        "bold" : 1,

        "underline" : 4,
        "invert" : 7,

        "black" : 30,
        "darkRed" : 31,
        "darkGreen" : 32,
        "gold" : 33,
        "darkBlue" : 34,
        "darkPurple" : 35,
        "darkCyan" : 36,

        "bgReset" : 40,
        "bgDarkRed" : 41,
        "bgDarkGreen" : 42,
        "bgGold" : 43,
        "bgDarkBlue": 44,
        "bgDarkPurple" : 45,
        "bgDarkCyan" : 46,
        "bgWhite" : 47,

        "gray" : 90,
        "red" : 91,
        "green" : 92,
        "yellow" : 93,
        "blue" : 94,
        "purple" : 95,
        "cyan" : 96,
        "brightWhite" : 97,

        "bgGray" : 100,
        "bgRed" : 101,
        "bgGreen" : 102,
        "bgYellow": 103,
        "bgBlue" : 104,
        "bgPurple" : 105,
        "bgCyan" : 106,
        "bgBrightWhite": 107
    }.toTable


let rgb:string = """\d{1,3},\d{1,3},\d{1,3}"""
let hex:string = "[0-9a-fA-F]{6}"
let full:string = fmt"&({rgb}|{hex}|bg{rgb}|bg{hex}|" & colors.getKeys.join("|") & ");"


proc stringToRgb(str:string): Rgb = 
    let nums = str.findAll(re"\d{1,3}")
    var col:Rgb = ["0", "0", "0"]

    for i,v in nums:
        col[i] = v
    
    return col


proc hexToRgb(str:string): Rgb =
    let nums = str.findAll(re"[0-9a-fA-F]{2}")
    var col:Rgb = ["0", "0", "0"]

    for i,v in nums:
        var res:int
        discard parseHex(v, res)
        col[i] = res.intToStr

    return col


proc valueToKey(table:Table[string,int], value:int):string =
    for k,v in table:
        if v == value:
            return k


proc color*(raw:string, autoReset:bool=true): string =
    var inp = raw

    if autoReset and raw.endsWith("[0m") != true and raw.endsWith("&reset;") != true:
        inp = raw & "&reset;"

    let strMatch = inp.findAll(full.re)
    var newString = inp

    for raw in strMatch:
        # Prepare regex and color
        let reg = raw[1..^2]
        var col:Rgb

        # Check if hex or rgb and set col to rgb values
        if reg.match(fmt"({rgb}|bg{rgb})".re).isSome: 
            col = stringToRgb(reg)
        elif reg.match(fmt"({hex}|bg{hex})".re).isSome:
            col = hexToRgb(reg)

        # Check if hex/rgb is for foreground or background
        var groundCol:string = "38"
        if reg[0..1] == "bg":
            groundCol = "48"

        # set rgb color values
        var colString:string = "\e[" & groundCol & ";2;" & col.join(";") & "m"

        # If not rgb/hex, set as defined values
        if col == ["","",""]:
            colString = "\e[" & colors[reg].intToStr & "m"

        # Replace part in string with colored value
        newString = newString.replace(raw, colString)

    return newString


proc colorEscape*(buf:string): string = 
    let strMatch = buf.findAll(full.re)
    var newString = buf

    for raw in strMatch:
        newString = newString.replace(raw, raw[0..^2] & ":")

    return newString


proc colorUnEscape*(buf:string): string = 
    let strMatch = buf.findAll( (full[0..^2]&":").re )
    var newString = buf

    for raw in strMatch:
        newString = newString.replace(raw, raw[0..^2] & ";")
    
    return newString


proc unColor*(buf:string): string = 
    let strMatch = buf.findAll(re"\e\[[0-9;]+m")
    var newString = buf

    for raw in strMatch:
        if raw[1..3] == "[38":
            let col = stringToRgb(raw[7..^2])
            newString = newString.replace(raw, fmt"&{col[0]},{col[1]},{col[2]};")
            continue

        var color:int
        discard parseInt(raw.find(re"\d+").get.match, color)
        newString = newString.replace(raw, fmt"&{colors.valueToKey(color)};")

    return newString