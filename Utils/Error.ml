(* Contains error types definitions, error handling utility functions etc. *)

open Lexing

type error = 
    LexingError

exception Error of error * position * position * lexbuf

let raise_error err lexbuf =
    raise(Error(err, lexeme_start_p lexbuf, lexeme_end_p lexbuf, lexbuf))

let print_position start_p end_p =
    if(start_p.pos_lnum = end_p.pos_lnum) then
        begin
            print_string " line ";
            print_int start_p.pos_lnum;
            print_string " from character ";
            print_int (start_p.pos_cnum - start_p.pos_bol);
            print_string " to ";
            print_int (end_p.pos_cnum - end_p.pos_bol);
        end
    else
        begin
            print_string " from line ";
            print_int start_p.pos_lnum;
            print_string " character ";
            print_int (start_p.pos_cnum - start_p.pos_bol);
            print_string " to line ";
            print_int end_p.pos_lnum;
            print_string " character ";
            print_int (end_p.pos_cnum - end_p.pos_bol);
        end

let report_error = function
    | Error(LexingError, start_p, end_p, lexbuf) ->
            print_string "LexingError";
            print_position start_p end_p;
            print_string " (";
            print_string (lexeme lexbuf);
            print_string ")";
            print_string "\n";
    | Error(_, start_p, end_p, lexbuf) ->
            print_string "Unknown error"





