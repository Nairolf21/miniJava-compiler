(*open Parser*)

(*For tests: local type token*)

type token = 
    FLOAT 
    | INT 
    | DOUBLE 
    | LONG;;


type keyword = { k_pattern: string; k_token: token }

let add_keyword pattern_a token_a lst =
    { k_pattern = pattern_a; k_token = token_a}::lst


let rec list_patterns lst =
    match lst with
    | [] -> ""
    | h::tail -> 
            begin
                print_string h.k_pattern;
                match tail with 
                | [] -> print_string ""
                | _ -> ptint_string " | ";
                list_patterns tail
            end

(*let keywords_pattern lst =*) 

let tokenList = []

let tokenList = add_keyword "float" FLOAT tokenList 
let tokenList = add_keyword "int" INT tokenList 
let tokenList = add_keyword "double" DOUBLE tokenList 
let tokenList = add_keyword "long" LONG tokenList 

