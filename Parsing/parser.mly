(* operators *)

(* delimitors *)
%token COMMA SEMICOLON LPAREN RPAREN LBRACE RBRACE

(* keyword *)
%token ABSTRACT CLASS INT FINAL FLOAT NATIVE PRIVATE PROTECTED PUBLIC STATIC STRICTFP 
SYNCHRONIZED

(* special *)
%token EOF 
%token <string> IDENT
%token <float> NUMBER

%start <string> compilationUnit

%%

(* 7.3 Compilation Units *)
compilationUnit: 
      tps=typeDeclarations EOF { tps } 

typeDeclarations:
      tp=typeDeclaration { tp }
    | tps=typeDeclarations tp=typeDeclaration { tps^"\n"^tp }

(* 7.6 Top Level Type Declarations *)
typeDeclaration:
      cd=classDeclaration { cd }
    | SEMICOLON { ";" } 

(* 8.1 Class Declaration *)
classDeclaration:
    ncd=normalClassDeclaration { ncd }

normalClassDeclaration:
      CLASS id=identifier cb=classBody { "class "^id^" "^cb } 
    | cms=classModifiers CLASS id=identifier cb=classBody { cms^" class "^id^" "^cb }

classModifiers:
      cm=classModifier { cm }
    | cms=classModifiers cm=classModifier { cms^" "^cm }

classModifier:
      PUBLIC { "public" }
    | PROTECTED { "protected" }
    | PRIVATE { "private" }
    | ABSTRACT { "abstract" }
    | STATIC { "static" }
    | FINAL { "final" }
    | STRICTFP { "strictfp" }

classBody:
      LBRACE cbds=classBodyDeclarations RBRACE { " {"^cbds^" }" }
    | LBRACE RBRACE { " {} "}

classBodyDeclarations:
      cbd=classBodyDeclaration { cbd }
    | cbds=classBodyDeclarations cbd=classBodyDeclaration { cbds^"\n"^cbd }

classBodyDeclaration:
      cmd=classMemberDeclaration { cmd }

classMemberDeclaration:
      (*fd=fieldDeclaration { fd } *)
    | md=methodDeclaration { md }
    | SEMICOLON { ";" } 
    
(* 8.3 Field Declarations *)
fieldDeclaration:
    ut=unannType vdl=variableDeclaratorList SEMICOLON { ut^" "^vdl^";"}

(* 8.4 Method Declarations *)
methodDeclaration:
      mh=methodHeader mb=methodBody { mh^" "^mb }

methodHeader:
    r=result md=methodDeclarator { r^" "^md } 

methodDeclarator:
    id=identifier LPAREN RPAREN { id^" ( )" } 

methodModifiers:
      mm=methodModifier { mm }
    | mms=methodModifiers mm=methodModifier { mms^" "^mm }

methodModifier:
      PUBLIC { "public" }
    | PROTECTED { "protected" }
    | PRIVATE { "private" }
    | ABSTRACT { "abstract" }
    | STATIC { "static" }
    | FINAL { "final" }
    | SYNCHRONIZED { "synchronized" } 
    | NATIVE { "native" } 
    | STRICTFP { "strictfp" }

(* To sort *)
floatingPointType:
    FLOAT { "float" } 

identifier:
    id=IDENT { id }

integralType:
    INT { "int" } 
    
methodBody:
    SEMICOLON { ";" }

numericType:
      it=integralType { it } 
    | fpt=floatingPointType { fpt } 

result:
    ut=unannType { ut }

unannPrimitiveType:
    nt=numericType { nt }

unannType:
    upt=unannPrimitiveType { upt }

variableDeclarator:
    vdi=variableDeclaratorId { vdi }

variableDeclaratorId:
    id=identifier { id }

variableDeclaratorList:
    vd=variableDeclarator { vd }
    | vd=variableDeclarator COMMA vdl=variableDeclaratorList { vd^", "^vdl }
%%
