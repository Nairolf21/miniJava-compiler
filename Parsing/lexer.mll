{
    open Parser
    open Lexing
    open Error
}

let letter = ['a'-'z' 'A'-'Z']
let capital = ['A'-'Z']
let lowercase = ['a'-'z']
let digit = ['0'-'9']
let real = digit* ('.' digit*)?
let uident = capital ( letter | digit | '_')*
let lident = lowercase ( letter | digit | '_')*
let newline = ('\010' | '\013' | "\013\010")
let blank = [' ' '\009']

rule nexttoken = parse 
    | blank+ { nexttoken lexbuf }
    | newline { Lexing.new_line lexbuf; nexttoken lexbuf }
    | eof { EOF }
    | "," { COMMA }
    | ";" { SEMICOLON } 
    | "{" { LBRACE }
    | "}" { RBRACE }
    | "class" { CLASS } 
    | "static" { STATIC }
    | "int" { INT }
    | "float" { FLOAT }
    | real as n { NUMBER (float_of_string n) }
    | uident as u { UIDENT u }
    | lident as l { LIDENT l }
    | _ { raise_error LexingError lexbuf }

{

let printtoken = function
    | EOF -> print_string "EOF"
    | COMMA -> print_string ","
    | SEMICOLON -> print_string ";"
    | NUMBER n -> print_string "NUMBER("; print_float n; print_string ")" 
    | UIDENT u -> print_string "UIDENT("; print_string u; print_string ")"
    | LIDENT l -> print_string "LIDENT("; print_string l; print_string ")"
    | CLASS -> print_string "class" 
    | LBRACE -> print_string "{"
    | RBRACE -> print_string "}"
    | STATIC -> print_string "static"
    | INT -> print_string "int"
    | FLOAT -> print_string "float"


let rec readtoken buffer = 
    let res = nexttoken buffer in
    print_string "Reading token in line ";
    print_int buffer.lex_curr_p.pos_lnum;
    print_string " : ";
    printtoken res;
    print_string "\n";
    res
}
