(* operators *)

(* delimitors *)
%token COMMA SEMICOLON COLON LPAREN RPAREN LBRACE RBRACE

(* keyword *)
%token ABSTRACT CLASS INT FINAL FLOAT NATIVE PRIVATE PROTECTED PUBLIC STATIC STRICTFP 
SYNCHRONIZED

(* statements *)
%token IF THEN ELSE ASSERT SWITCH  CASE DEFAULT WHILE DO FOR BREAK CONTINUE RETURN THROW 
TRY CATCH FINALLY

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


(* 14.2 Blocks *)    
block:
	  LBRACE bss=blockStatements RBRACE { " {\n"^bss^"\n}" }
	| LBRACE RBRACE { " {} "}

blockStatements:
	  bs=blockStatement { bs }
	| bss=blockStatements bs=blockStatement { bss^"\n"^bs }

blockStatement:
	  lvds=localVariableDeclarationStatement { lvds }
	| cd=classDeclaration { cd }
	| s=statement { s }

(* 14.4 Local Variable Declaration Statements *)
localVariableDeclarationStatement:
	lvd=localVariableDeclaration SEMICOLON { lvd^";" }

localVariableDeclaration:
	(* variableModifiers & variableDeclarators in 8.3 & 8.4 *)
	vm=variableModifiers ut=unannType vds=variableDeclarators { vm^" "^ut^" "^vds }

(* 14.5 Statements *)
statement:
	  swts=statementWithoutTrailingSubstatement { swts }
	| ls=labeledStatement { ls }
	| its=ifThenStatement { its }
	| ites=ifThenElseStatement { ites }
	| ws=whileStatement { ws }
	| fs=forStatement { fs }
	
statementWithoutTrailingSubstatement:
	  b=bloc { b }
	| es=emptyStatement { es }
	| es=expressionStatement { es }
	| ass=assertStatement { ass }
	| ss=switchStatement { ss }
	| ds=doStatement { ds }
	| bs=breakStatement { bs }
	| cs=continueStatement { cs }
	| rs=returnStatement { rs }
	| ss=synchronizedStatement { ss }
	| ts=throwStatement { ts }
	| ts=tryStatement { ts }
	
statementNoShortIf:
	  swts=statementWithoutTrailingSubstatement { swts }
	| lsnsi=labeledStatementNoShortIf { lsnsi }
	| itesnsi=ifThenElseStatementNoShortIf { itesnsi }
	| wsnsi=WhileStatementNoShortIf { wsnsi }
	| fsnsi=ForStatementNoShortIf { fsnsi }

(* 14.6 Empty Statement *)
emptyStatement:
	(* ?? *)
	SEMICOLON { ";" }

(* 14.7 Labeled Statement *)
labeledStatement:
	i=identifier COLON s=statement { i^" : "^s }

labeledStatementNoShortIf:
	i=identifier COLON snsi=statementNoShortIf { i^" : "^snsi }
	
(* 14.8 Expression Statement *)
expressionStatement:
	se=statementExpression SEMICOLON { se^" ;" }
	
statementExpression:
	  a=assignment { a }
	| pie=preIncrementExpression { pie }
	| pde=preDecrementExpression { pde }
	| pie=postIncrementExpression { pie }
	| pde=postDecrementExpression { pde }
	| mi=methodInvocation { mi }
	| cce=classInstanceCreationExpression { cce }

(* 14.9 The if Statement *)
ifThenStatement:
	IF LPAREN e=expression RPAREN s=statement { "if ("^e^")\n"^s }

ifThenElseStatement:
	IF LPAREN e=expression RPAREN snsi=statementNoShortIf ELSE s=statement { "if ("^e^")\n"^snsi^"\nelse\n"^s }

ifThenElseStatementNoShortIf:
	IF LPAREN e=expression RPAREN snsi1=statementNoShortIf ELSE snsi2=statementNoShortIf { "if ("^e^")\n"^snsi1^"\nelse\n"^snsi2 }

(* 14.10 The assert Statement *)
assertStatement:
	  ASSERT e=expression SEMICOLON { "assert "^e^" ;" }
	| ASSERT e1=expression COLON e2=expression SEMICOLON { "assert "^e1^" : "^e2^" ;" }
	
(* 14.11 The switch Statement *)
switchStatement:
	SWITCH LPAREN e=expression RPAREN sb=switchBlock { "switch ("^e^") "^sb }
	
switchBlock:
	  LBRACE RBRACE { "{}" }
	| LBRACE sbsgs=switchBlockStatementGroups RBRACE { "{ "^sbsgs^"}" }
	| LBRACE sls=switchLabels RBRACE { "{"^sls^"}" }
	| LBRACE sbsg=switchBlockStatementGroups sls=switchLabels RBRACE { "{"^sbsg^" "^sls^"}" }
	
switchBlockStatementGroups:
	  sbsg=switchBlockStatementGroup { sbsg }
	| sbsgs=switchBlockStatementGroups sbsg=switchBlockStatementGroup { sbsgs^"\n"^sbsg }
	
switchBlockStatementGroup:
	sls=switchLabels bss=blockStatements { sls^"\n"^bss }

switchLabels:
	  sl=switchLabel { sl }
	| sls=switchLabels sl=switchLabel { sls^"\n"^sl }

switchLabel:
	  CASE ce=constantExpression COLON { "case "^ce^" :" }
	| CASE ecn=enumConstantName COLON { "case "^ecn^" :" }
	| DEFAULT COLON { "default :" }
	
enumConstantName:
	id=Identifier { id }
	
(* 14.12 The while Statement *)
whileStatement:
	WHILE LPAREN e=expression RPAREN s=statement { "while ("^e^")\n"^s }
	
whileStatementNoShortIf:
	WHILE LPAREN e=expression RPAREN snsi=statementNoShortIf { "while ("^e^")\n"^snsi }
	
(* 14.13 The do Statement *)
doStatement:
	DO s=statement WHILE LPAREN e=expression RPAREN { "do\n"^s^"\nwhile ("^e^")" }
	
(* 14.14 The for Statement *)
forStatement:
	  bfs=BasicForStatement { bfs }
	| efs=EnhancedForStatement { efs }
	
basicForStatement:
	  FOR LPAREN SEMICOLON SEMICOLON RPAREN s=statement { "for (;;)\n"^s }
	| FOR LPAREN fi=forInit SEMICOLON SEMICOLON RPAREN s=statement { "for ("^fi^";;)\n"^s }
	| FOR LPAREN SEMICOLON e=expression SEMICOLON RPAREN s=statement { "for (;"^e^";)\n"^s }
	| FOR LPAREN SEMICOLON SEMICOLON fu=forUpdate RPAREN s=statement { "for (;;"^fu^")\n"^s }
	| FOR LPAREN fi=forInit SEMICOLON e=expression SEMICOLON RPAREN s=statement { "for ("^fi^";"^e^";)\n"^s }
	| FOR LPAREN fi=forInit SEMICOLON SEMICOLON fu=forUpdate RPAREN s=statement { "for ("^fi^";;"^fu^")\n"^s }
	| FOR LPAREN SEMICOLON e=expression SEMICOLON fu=forUpdate RPAREN s=statement { "for (;"^e^";"^fu^")\n"^s }
	| FOR LPAREN fi=forInit SEMICOLON e=expression SEMICOLON fu=forUpdate RPAREN s=statement { "for ("^fi^";"^e^";"^fu^")\n"^s }

forStatementNoShortIf:
	  FOR LPAREN SEMICOLON SEMICOLON RPAREN snsi=statementNoShortIf { "for (;;)\n"^snsi }
	| FOR LPAREN fi=forInit SEMICOLON SEMICOLON RPAREN snsi=statementNoShortIf { "for ("^fi^";;)\n"^snsi }
	| FOR LPAREN SEMICOLON e=expression SEMICOLON RPAREN snsi=statementNoShortIf { "for (;"^e^";)\n"^snsi }
	| FOR LPAREN SEMICOLON SEMICOLON fu=forUpdate RPAREN snsi=statementNoShortIf { "for (;;"^fu^")\n"^snsi }
	| FOR LPAREN fi=forInit SEMICOLON e=expression SEMICOLON RPAREN snsi=statementNoShortIf { "for ("^fi^";"^e^";)\n"^snsi }
	| FOR LPAREN fi=forInit SEMICOLON SEMICOLON fu=forUpdate RPAREN snsi=statementNoShortIf { "for ("^fi^";;"^fu^")\n"^snsi }
	| FOR LPAREN SEMICOLON e=expression SEMICOLON fu=forUpdate RPAREN snsi=statementNoShortIf { "for (;"^e^";"^fu^")\n"^snsi }
	| FOR LPAREN fi=forInit SEMICOLON e=expression SEMICOLON fu=forUpdate RPAREN snsi=statementNoShortIf { "for ("^fi^";"^e^";"^fu^")\n"^snsi }

forInit:
	  sel=statementExpressionList { sel }
	| lvd=localVariableDeclaration { lvd }

forUpdate:
	sel=statementExpressionList { sel }

statementExpressionList:
	  se=statementExpression { se }
	| sel=statementExpressionList COMMA se=statementExpression { sel^" , "^se }
	
enhancedForStatement:
	  FOR LPAREN ut=unannType id=identifier COLON e=expression RPAREN s=statement { "for ("^ut^" "^id^" : "^e^")\n"^s }
	| FOR LPAREN vm=variableModifiers ut=unannType id=identifier COLON e=expression RPAREN s=statement { "for ("^vm^" "^ut^" "^id^" : "^e^")\n"^s }

(* 14.15 The break Statement *)
breakStatement:
	  BREAK SEMICOLON { "break ;" }
	| BREAK id=identifier SEMICOLON { "break "^id^" ;" }
	
(* 14.16 The continue Statement *)
continueStatement:
	CONTINUE SEMICOLON { "continue ;" }
	| CONTINUE id=identifier SEMICOLON { "continue "^id^" ;" }
	
(* 14.17 The return statement *)
returnStatement:
	RETURN SEMICOLON { "return ;" }
	| RETURN e=expression SEMICOLON { "return "^e^" ;" }
	
(* 14.18 The throw Statement *)
throwStatement:
	THROW e=expression SEMICOLON { "throw "^e^" ;" }
	
(* 14.19 The synchronized Statement *)
synchronizedStatement:
	SYNCHRONIZED LPAREN e=expression RPAREN b=block { "synchronized ("^e^")\n"^b }

(* 14.20 The try Statement *)
tryStatement:
	  TRY b=block c=catches { "try \n"^b^"\n"^c }
	| TRY b=block f=finally { "try \n"^b^"\n"^f }
	| TRY b=block c=catches f=finally { "try \n"^b^"\n"^c^"\n"^f }

catches:
	  cc=catchClause { cc }
	| c=catches cc=catchClause { c^"\n"^cc }

catchClause:
	CATCH LPAREN fp=formalParameter RPAREN b=block { "catch ("^fp^")\n"^b }

finally:
	FINALLY b=block { "finally\n"^b }

(* 15.8 Primary Expressions *)
primary:
	  pnna=primaryNoNewArray { pnna }
	| ace=arrayCreationExpression { ace }

primaryNoNewArray:
	  l=literal { l }
	(* TODO ! *)
	
literal:
	  il=integerLiteral { il }
	| fpl=floatingPointLiteral { fpl }
	| bl=booleanLiteral { bl }
	| cl=characterLiteral { cl }
	| sl=stringLiteral { sl }
	| nl=nullLiteral { nl }



(*
// TODO
assignment
preIncrementExpression
preDecrementExpression
postIncrementExpression
postDecrementExpression
methodInvocation
classInstanceCreationExpression

// TODO
expression
constantExpression

// TODO
arrayCreationExpression
*)







%%