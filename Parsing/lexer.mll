{
    open Parser
    open Lexing
    open Error
}


let letter = ['a'-'z' 'A'-'Z']
let lowercase = ['a'-'z']
let notzero = ['1'-'9']
let digit = ['0'-'9']
let ident = letter ( letter | digit | '_')*
let newline = ('\010' | '\013' | "\013\010")
let blank = [' ' '\009']


rule nexttoken = parse 
    | blank+ { nexttoken lexbuf }
    | newline { Lexing.new_line lexbuf; nexttoken lexbuf }
    | eof { EOF }
    | "true" { TRUE }
    | "false" { FALSE }
    | "null" { NULL }
    | "," { COMMA }
    | ";" { SEMICOLON }
    | ":" { COLON }
    | "(" { LPAREN }
    | ")" { RPAREN }
    | "{" { LBRACE }
    | "}" { RBRACE }
    | "[" { LBRACK }
    | "]" { RBRACK }
    | "." { PERIOD }
    | "++" { INCR }
    | "--" { DECR }
    | "~" { TILDE }
    | "!=" { NOTEQUAL }
    | "!" { EXCL }
    | "==" { TRUEEQUAL }
    | "=" { EQUAL }
    | "*=" { MULTEQUAL }
    | "/=" { DIVEQUAL }
    | "%=" { MODEQUAL }
    | "+=" { PLUSEQUAL }
    | "-=" { MINUSEQUAL }
    | "<<=" { LSHIFTEQUAL }
    | ">>=" { RSHIFTEQUAL }
    | ">>>=" { USHIFTEQUAL }
    | "&=" { BITANDEQUAL }
    | "^=" { BITXOREQUAL }
    | "|=" { BITOREQUAL }
    | "+" { PLUS }
    | "-" { MINUS }
    | "*" { MULT }
    | "/" { DIV }
    | "%" { MOD }
    | ">>>" { USHIFT }
    | ">>" { RSHIFT }
    | "<<" { LSHIFT }
    | "<=" { INFEQUAL }
    | ">=" { SUPEQUAL }
    | "<" { INF }
    | ">" { SUP }
    | "&&" { CONDITIONALAND }
    | "||" { CONDITIONALOR }
    | "?" { CONDITIONAL }
    | "&" { AND }
    | "^" { EXCLUSIVEOR }
    | "|" { INCLUSIVEOR }
    | "instanceof" { INSTANCEOF }
    | "byte" { BYTE }
    | "short" { SHORT }
    | "int" { INT }
    | "long" { LONG }
    | "float" { FLOAT }
    | "double" { DOUBLE }
    | "void" { VOID }
    | "class" { CLASS }
    | "abstract" { ABSTRACT }
    | "final" { FINAL }
    | "native" { NATIVE } 
    | "private" { PRIVATE } 
    | "protected" { PROTECTED } 
    | "public" { PUBLIC } 
    | "super" { SUPER }
    | "static" { STATIC } 
    | "strictfp" { STRICTFP }
    | "synchronized" { SYNCHRONIZED }
    | "new" { NEW }
    | "this" { THIS }
	| "if" { IF }
	| "then" { THEN }
	| "else" { ELSE }
	| "assert" { ASSERT }
	| "switch" { SWITCH }
	| "case" { CASE }
	| "default" { DEFAULT }
	| "while" { WHILE }
	| "do" { DO }
	| "for" { FOR }
	| "break" { BREAK }
	| "continue" { CONTINUE }
	| "return" { RETURN }
	| "throw" { THROW  }
	| "try" { TRY }
	| "catch" { CATCH }
	| "finally" { FINALLY }
    | notzero as nz { NOTZERO(nz) }
    | "0" { ZERO }
    | ident as i { IDENT i }
    | _ { raise_error LexingError lexbuf }

{


let printtoken = function
    | EOF -> print_string "EOF"
    | TRUE -> print_string "true"
    | FALSE -> print_string "false"
    | NULL -> print_string "null"
    | PERIOD -> print_string "."
    | COMMA -> print_string ","
    | SEMICOLON -> print_string ";"
    | COLON -> print_string ":"
    | LPAREN -> print_string "("
    | RPAREN -> print_string ")"
    | LBRACE -> print_string "{"
    | RBRACE -> print_string "}"
    | LBRACK -> print_string "["
    | RBRACK -> print_string "]"
    | PLUS -> print_string "+"
    | MINUS -> print_string "-"
    | INCR -> print_string "++"
    | DECR -> print_string "--"
    | EQUAL -> print_string "="
    | EXCL -> print_string "!"
    | TILDE -> print_string "~"
    | MULT -> print_string "*"
    | DIV -> print_string "/"
    | MOD -> print_string "%"
    | LSHIFT -> print_string "<<"
    | RSHIFT -> print_string ">>"
    | USHIFT -> print_string ">>>"
    | TRUEEQUAL -> print_string "=="
    | NOTEQUAL -> print_string "!="
    | MULTEQUAL -> print_string "*="
    | DIVEQUAL -> print_string "/="
    | MODEQUAL -> print_string "%="
    | PLUSEQUAL -> print_string "+="
    | MINUSEQUAL -> print_string "-="
    | LSHIFTEQUAL -> print_string "<<="
    | RSHIFTEQUAL -> print_string ">>="
    | USHIFTEQUAL-> print_string ">>>="
    | BITANDEQUAL -> print_string "&="
    | BITXOREQUAL -> print_string "^="
    | BITOREQUAL -> print_string "|="
    | INFEQUAL -> print_string "<="
    | SUPEQUAL -> print_string ">="
    | INF -> print_string "<"
    | SUP -> print_string ">"
    | CONDITIONALAND -> print_string "&&"
    | CONDITIONALOR -> print_string "||"
    | CONDITIONAL -> print_string "?"
    | AND -> print_string "&"
    | INCLUSIVEOR -> print_string "|"
    | EXCLUSIVEOR -> print_string "^"
    | INSTANCEOF -> print_string "instanceof"
    | BYTE -> print_string "byte"
    | SHORT -> print_string "short"
    | INT -> print_string "int"
    | LONG -> print_string "long"
    | FLOAT -> print_string "float"
    | DOUBLE -> print_string "double"
    | VOID -> print_string "void"
    | CLASS -> print_string "class" 
    | ABSTRACT -> print_string "abstract"
    | FINAL -> print_string "final"
    | NATIVE -> print_string "native"
    | PRIVATE -> print_string "private"
    | PROTECTED -> print_string "protected"
    | PUBLIC -> print_string "public"
    | SUPER -> print_string "super"
    | STATIC -> print_string "static"
    | STRICTFP -> print_string "strictfp" 
    | SYNCHRONIZED -> print_string "synchronized"
    | NEW -> print_string "new"
    | THIS -> print_string "this"
	| IF -> print_string "if"
	| THEN -> print_string "then"
	| ELSE -> print_string "else"
	| ASSERT -> print_string "assert"
	| SWITCH -> print_string "switch"
	| CASE -> print_string "case"
	| DEFAULT -> print_string "default"
	| WHILE -> print_string "while"
	| DO -> print_string "do"
	| FOR -> print_string "for"
	| BREAK -> print_string "break"
	| CONTINUE -> print_string "continue"
	| RETURN -> print_string "return"
	| THROW -> print_string "throw" 
	| TRY -> print_string "try"
	| CATCH -> print_string "catch"
	| FINALLY -> print_string "finally"
    | NOTZERO n -> print_string (String.make 1 n)
    | ZERO -> print_string "0"
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
