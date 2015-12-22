{
    open Parsexpr
    open Lexing

    type error = 
        LexingError

    exception Error of error * position * position * lexbuf

    let raise_error err lexbuf =
        raise(Error(err, lexeme_start_p lexbuf, lexeme_end_p lexbuf, lexbuf))

    let report_error = function
        | Error(LexingError, start_p, end_p, lexbuf) ->
                print_string "LexingError line ";
                print_int start_p.pos_lnum;
                print_string " from character ";
                print_int (start_p.pos_cnum - start_p.pos_bol);
                print_string " to ";
                print_int (end_p.pos_cnum - end_p.pos_bol);
                print_string " (";
                print_string (lexeme lexbuf);
                print_string ")";
                print_string "\n";
        | Error(_, start_p, end_p, lexbuf) ->
                print_string "Unknown error"
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let real = digit* ('.' digit*)?
let ident = letter (letter | digit | '_')*
let newline = ('\010' | '\013' | "\013\010")
let blank = [' ' '\009']
let semicolon = ';'
let typeExpr = "int" | "float"
let incorrect = [^' ' '\009']* blank

rule nexttoken = parse 
    | blank+ { nexttoken lexbuf }
    | newline { Lexing.new_line lexbuf; nexttoken lexbuf }
    | eof { EOF }
    | semicolon { SEMICOLON }
    | typeExpr as t { TYPE t }
    | real as n { NUMBER (float_of_string n) }
    | ident as i { IDENT i }
    | _ { raise_error LexingError lexbuf }

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
