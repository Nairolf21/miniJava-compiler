{
    open Parser
    open Lexing
    open Error
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let real = digit* ('.' digit*)?
let ident = letter (letter | digit | '_')*
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
    | "public" { PUBLIC }
    | "protected" { PROTECTED } 
    | "private" { PRIVATE }
    | "abstract" { ABSTRACT }
    | "static" { STATIC }
    | "final" { FINAL }
    | "strictfp" { STRICTFP }
    | "int" { INT }
    | "float" { FLOAT }
    | real as n { NUMBER (float_of_string n) }
    | ident as i { IDENT i }
    | _ { raise_error LexingError lexbuf }

{

let printtoken = function
    | EOF -> print_string "EOF"
    | COMMA -> print_string ","
    | SEMICOLON -> print_string ";"
    | NUMBER n -> print_string "NUMBER("; print_float n; print_string ")" 
    | IDENT i -> print_string "IDENT("; print_string i; print_string ")"
    | CLASS -> print_string "class" 
    | LBRACE -> print_string "{"
    | RBRACE -> print_string "}"
    | PUBLIC -> print_string "public"
    | PROTECTED -> print_string "protected"
    | PRIVATE -> print_string "private"
    | ABSTRACT -> print_string "abstract"
    | STATIC -> print_string "static"
    | FINAL -> print_string "final"
    | STRICTFP -> print_string "strictfp" 
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
