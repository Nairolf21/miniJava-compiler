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
    | newline { Lexing.new_line lexbuf; nexttoken lexbuf }
    | eof { EOF }
    | semicolon { SEMICOLON }
    | typeExpr as t { TYPE t }
    | real as n { NUMBER (float_of_string n) }
    | ident as i { IDENT i }

{

let printtoken = function
    | EOF -> print_string "EOF"
    | SEMICOLON -> print_string ";"
    | TYPE t -> print_string "TYPE("; print_string t; print_string ")"
    | NUMBER n -> print_string "NUMBER("; print_float n; print_string ")"
    | IDENT i -> print_string "IDENT("; print_string i; print_string ")"

let rec readtoken buffer = 
    let res = nexttoken buffer in
    print_string "Reading token in line ";
    print_int buffer.lex_curr_p.pos_lnum;
    print_string " : ";
    printtoken res;
    print_string "\n";
    res
}
