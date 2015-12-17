{
    open Parsexpr
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let real = digit* ('.' digit*)?
let ident = letter (letter | digit | '_')*
let newline = ('\010' | '\013' | "\013\010")
let blank = [' ' '\009']
let semicolon = ';'
let typeExpr = "int" | "float"

rule nexttoken = parse 
    | blank+ { nexttoken lexbuf }
    | eof { EOF }
    | semicolon { SEMICOLON }
    | typeExpr as t { TYPE t }
    | real as n { NUMBER (float_of_string n) }
    | ident as i { IDENT i }
