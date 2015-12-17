%token SEMICOLON EOF
%token <string> TYPE IDENT
%token <float> NUMBER

%start <string> expression

%%

expression:
    s=instruction SEMICOLON EOF { s }

instruction:
    dec=declaration { "declaration("^dec^")" }
    | id=ident_or_const { id }

declaration:
    t=TYPE id=IDENT { "type("^t^"), ident("^id^")" }

ident_or_const:
    id=IDENT { "ident("^id^")" }
    | n=NUMBER { "number("^(string_of_int n)^")" }
