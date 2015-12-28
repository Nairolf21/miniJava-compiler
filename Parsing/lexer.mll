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
    | "(" { LPAREN }
    | ")" { RPAREN }
    | "{" { LBRACE }
    | "}" { RBRACE }
    | "abstract" { ABSTRACT }
    | "class" { CLASS }
    | "int" { INT }
    | "final" { FINAL }
    | "float" { FLOAT }
    | "native" { NATIVE } 
    | "private" { PRIVATE } 
    | "protected" { PROTECTED } 
    | "public" { PUBLIC } 
    | "static" { STATIC } 
    | "strictfp" { STRICTFP } 
    | "synchronized" { SYNCHRONIZED }
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
    | LPAREN -> print_string "("
    | RPAREN -> print_string ")"
    | LBRACE -> print_string "{"
    | RBRACE -> print_string "}"
    | ABSTRACT -> print_string "abstract"
    | CLASS -> print_string "class" 
    | INT -> print_string "int"
    | FINAL -> print_string "final"
    | FLOAT -> print_string "float"
    | NATIVE -> print_string "native"
    | PRIVATE -> print_string "private"
    | PROTECTED -> print_string "protected"
    | PUBLIC -> print_string "public"
    | STATIC -> print_string "static"
    | STRICTFP -> print_string "strictfp" 
    | SYNCHRONIZED -> print_string "synchronized"

let rec readtoken buffer = 
    let res = nexttoken buffer in
    print_string "Reading token in line ";
    print_int buffer.lex_curr_p.pos_lnum;
    print_string " : ";
    printtoken res;
    print_string "\n";
    res
}
