open Parsexpr
open Lexexpr
open Error

(* verbose is a boolean that you can use to switch to a verbose output (for example, to dump all the ast) *)
let execute lexbuf verbose = 
    try
        let result = Parsexpr.expression Lexexpr.readtoken lexbuf in
        print_string result;
        print_string "\n";
    with
        | Error(err, _, _, _) as e -> report_error e


