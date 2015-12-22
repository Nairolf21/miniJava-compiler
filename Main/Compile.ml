(* verbose is a boolean that you can use to switch to a verbose output (for example, to dump all the ast) *)
let execute lexbuf verbose = 
    let result = Parsexpr.expression Lexexpr.readtoken lexbuf in
    print_string result;


