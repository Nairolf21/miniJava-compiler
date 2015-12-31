open Parser
open Lexer
open Error

open Lexing

(* verbose is a boolean that you can use to switch to a verbose output (for example, to dump all the ast) *)
let execute lexbuf verbose = 
    try
        let result = Parser.start Lexer.readtoken lexbuf in
        print_string "\n --- Result --- \n";
        print_string result;
        print_string "\n";
    with
        | Error(err, _, _, _) as e -> report_error e
        | Parser.Error -> 
                let start_p = lexeme_start_p lexbuf in
                let end_p = lexeme_end_p lexbuf in
                let e = Error(ParsingError, start_p, end_p, lexbuf) in
                report_error e
