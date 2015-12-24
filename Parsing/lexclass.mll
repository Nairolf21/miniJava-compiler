{
    open Parseclass
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let real = digit* ('.' digit*)?
let ident = letter (letter | digit | '_')*
let newline = ('\010' | '\013' | "\013\010")
let blank = [' ' '\009']
let semicolon = ';'
let lbrace = "{"
let rbrace = "}"
let class_keyword = "class"

rule nexttoken = parse 
    | blank+ { nexttoken lexbuf }
    | newline { Lexing.new_line lexbuf; nexttoken lexbuf }
    | class_keyword { CLASS } 
    | ident as i { IDENT i }
    | lbrace { LBRACE }
    | rbrace { RBRACE }

{

let printtoken = function
    | EOF -> print_string "EOF"
    | SEMICOLON -> print_string ";"
    | CLASS -> print_string "class" 
    | IDENT i -> print_string "IDENT("; print_string i; print_string ")"
    | LBRACE -> print_string "{"
    | RBRACE -> print_string "}"

let rec readtoken buffer = 
    let res = nexttoken buffer in
    print_string "Reading token in line ";
    print_int buffer.lex_curr_p.pos_lnum;
    print_string " : ";
    printtoken res;
    print_string "\n";
    res
}
