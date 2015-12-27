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

%start <string> compilationUnitList

%%

classBody:
    LBRACE cbd=classBodyDeclaration RBRACE { " {"^cbd^" }" }

classBodyDeclaration:
    cmd=classMemberDeclaration { cmd }

classDeclaration:
    ncd=normalClassDeclaration { ncd }

classMemberDeclaration:
      (*fd=fieldDeclaration { fd } *)
    | md=methodDeclaration { md }
    | SEMICOLON { ";" } 
    
classModifier:
      PUBLIC { "public" }
    | PROTECTED { "protected" }
    | PRIVATE { "private" }
    | ABSTRACT { "abstract" }
    | STATIC { "static" }
    | FINAL { "final" }
    | STRICTFP { "strictfp" }

compilationUnitList: 
      tp=typeDeclaration EOF { tp } 
    | tp=typeDeclaration cul=compilationUnitList EOF { tp^"\n"^cul }

fieldDeclaration:
    ut=unannType vdl=variableDeclaratorList SEMICOLON { ut^" "^vdl^";"}

floatingPointType:
    FLOAT { "float" } 

identifier:
    id=IDENT { id }

integralType:
    INT { "int" } 
    
methodBody:
    SEMICOLON { ";" }

methodDeclaration:
      mh=methodHeader mb=methodBody { mh^" "^mb }
    | mm=methodModifier mh=methodHeader mb=methodBody { mm^" "^mh^" "^mb }

methodDeclarator:
    id=identifier LPAREN RPAREN { id^" ( )" } 

methodHeader:
    r=result md=methodDeclarator { r^" "^md } 

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

normalClassDeclaration:
      CLASS id=identifier cb=classBody { "class "^id^cb } 
    | cm=classModifier CLASS id=identifier cb=classBody { cm^" class "^id^cb}

numericType:
      it=integralType { it } 
    | fpt=floatingPointType { fpt } 

result:
    ut=unannType { ut }

typeDeclaration:
    cd=classDeclaration { cd }

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
