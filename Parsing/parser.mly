(*This token is a placeholder to unimplemented symbol rules or unfinished production rules
 *  Use them as followed
 *      * You implemented a set of rules for a chapter, but need other rules not yet implemented.
 *          add the missing symbol with the token TODO as only production rule
 *              ex. 
 *                  formalParameter:
     *                  TODO { "" }
     *
 *      * You only want to partially implement production rules for a symbol: add a production rule
 *          only containing TODO, so we know it's not finished yet
 *                  formalParameters:
     *                  fp=formalParameter { fp }
     *                  | TODO
 *
 *
 * *)
%token TODO

(* operators *)
(* assignment operators *)
%token EQUAL MULTEQUAL DIVEQUAL MODEQUAL PLUSEQUAL MINUSEQUAL LSHIFTEQUAL RSHIFTEQUAL USHIFTEQUAL BITANDEQUAL BITXOREQUAL BITOREQUAL

(* delimitors *)
%token COMMA SEMICOLON COLON LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK PERIOD

(* keyword *)
%token ABSTRACT CLASS SHORT BYTE INT LONG FLOAT DOUBLE BOOLEAN VOID FINAL NATIVE PRIVATE PROTECTED PUBLIC STATIC STRICTFP 
SYNCHRONIZED NEW SUPER

(* statements *)
%token IF THEN ELSE ASSERT SWITCH CASE DEFAULT WHILE DO FOR BREAK CONTINUE RETURN THROW 
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
    | ii=instanceInitializer {ii}

classBodyDeclaration:
      cmd=classMemberDeclaration { cmd }

classMemberDeclaration:
      (*fd=fieldDeclaration { fd } *)
    | md=methodDeclaration { md }
    | SEMICOLON { ";" } 
    
(* 8.3 Field Declarations *)
fieldDeclaration:
    jt=jType vdl=variableDeclarators SEMICOLON { jt^" "^vdl^";"}

(* 8.4 Method Declarations *)
methodDeclaration:
      mh=methodHeader mb=methodBody { mh^" "^mb }

methodHeader:
    r=resultType md=methodDeclarator { r^" "^md } 
    | mms=methodModifiers r=resultType md=methodDeclarator { mms^" "^r^" "^md } 


methodDeclarator:
    id=identifier LPAREN RPAREN { id^" ( )" } 
    | id=identifier LPAREN fpl=formalParameterList RPAREN { id^" ("^fpl^")" }
    

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
    | an=annotation {an}

methodBody:
	SEMICOLON { ";" }
	| b=block { b }

formalParameterList:
	lfp = lastFormalParameter {lfp}
	| fp=formalParameters COMMA lfp = lastFormalParameter {fp^", "^lfp} 

formalParameters:
	fp=formalParameter {fp}
	|fps=formalParameters COMMA fp=formalParameter {fps^" , "^fps}

formalParameter:
	vm = variableModifiers jt=jType vdi=variableDeclaratorId {vm^" "^jt^" "^vdi}

variableModifiers:
	vm=variableModifier {vm}
	| vms=variableModifiers vm=variableModifier {vms^" "^vm}

variableModifier:
	| FINAL { "final" }
	| a=annotation { a }

lastFormalParameter:
	|vms=variableModifiers vdi=variableDeclaratorId {vms^" "^vdi}
	|fp = formalParameter {fp}

(* 8.6 Instance Initializers *)
instanceInitializer:
	b=block {b}


(* To sort *)

identifier:
    id=IDENT { id }

annotation:
    TODO { "" }

(* 4.2 Primitive Types *)
numericType:
      it=integralType { it } 
    | fpt=floatingPointType { fpt } 

integralType:
    | BYTE { "byte" } 
    | SHORT { "short" } 
    | INT { "int" } 
    | LONG { "long" } 

floatingPointType:
    FLOAT { "float" } 
    | DOUBLE { "double" }
resultType:
    jt=jType { jt }
    | VOID { "void" }

primitiveType:
    nt=numericType { nt }

jType:
    upt= primitiveType { upt }

variableDeclarator:
    vdi=variableDeclaratorId { vdi }

variableDeclaratorId:
    id=identifier { id }
    | vdi=variableDeclaratorId LBRACK RBRACK { vdi^"[ ]" }

variableDeclarators:
    vd=variableDeclarator { vd }
    | vd=variableDeclarator COMMA vdl=variableDeclarators { vd^", "^vdl }


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
	vm=variableModifiers jt=jType vds=variableDeclarators { vm^" "^jt^" "^vds }

(* 14.5 Statements *)
statement:
	  swts=statementWithoutTrailingSubstatement { swts }
	| ls=labeledStatement { ls }
	| its=ifThenStatement { its }
	| ites=ifThenElseStatement { ites }
	| ws=whileStatement { ws }
	| fs=forStatement { fs }
	
statementWithoutTrailingSubstatement:
	  b=block { b }
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
	| wsnsi=whileStatementNoShortIf { wsnsi }
	| fsnsi=forStatementNoShortIf { fsnsi }

(* 14.6 Empty Statement *)
emptyStatement:
	SEMICOLON { ";" }
    | TODO { "" }

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


preIncrementExpression:
    TODO { "" }

preDecrementExpression:
    TODO { "" }

postDecrementExpression:
    TODO { "" }

postIncrementExpression:
    TODO { "" }

classInstanceCreationExpression:
    TODO { "" }

methodInvocation:
    TODO { "" }
(* 14.9 The if Statement *)
ifThenStatement:
	IF LPAREN e=expression RPAREN s=statement { "if ("^e^")\n"^s }

ifThenElseStatement:
	IF LPAREN e=expression RPAREN snsi=statementNoShortIf ELSE s=statement { "if ("^e^")\n"^snsi^"\nelse\n"^s }

ifThenElseStatementNoShortIf:
	IF LPAREN e=expression RPAREN snsi1=statementNoShortIf ELSE snsi2=statementNoShortIf { "if ("^e^")\n"^snsi1^"\nelse\n"^snsi2 }

(*15.27 Expression*)
expression:
    ae=assignmentExpression { ae }

(*15.26 Assignment Operators *)
assignmentExpression:
    ce=conditionalExpression { ce } 
    | a=assignment { a }

assignment:
    lhs=leftHandSide ao=assignmentOperator ae=assignmentExpression { lhs^" "^ao^" "^ae }

leftHandSide:
    en=expressionName { en }
    | fa=fieldAccess { fa }
    | aa=arrayAccess { aa }

assignmentOperator:
    EQUAL { "=" }
    | MULTEQUAL { "*=" }
    | DIVEQUAL { "/=" }
    | MODEQUAL { "%=" }
    | PLUSEQUAL { "+=" }
    | MINUSEQUAL { "-=" }
    | LSHIFTEQUAL { "<<=" }
    | RSHIFTEQUAL { ">>=" }
    | USHIFTEQUAL { ">>>=" }
    | BITANDEQUAL { "&=" }
    | BITXOREQUAL { "^=" }
    | BITOREQUAL { "|=" }

conditionalExpression:
    TODO { "" }

arrayAccess:
    TODO { "" }

(* 6.5 Meaning of a name *)
packageName:
    TODO { "" }

typeName:
    TODO { "" }

methodName:
    TODO { "" }

packageOrTypeName:
    TODO { "" }

expressionName:
    id=identifier { id }
    | an=ambiguousName PERIOD id=identifier { an^"."^id }

ambiguousName:
    id=identifier { id }
    | an=ambiguousName PERIOD id=identifier { an^"."^id }
    

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
	id=identifier { id }
	
constantExpression:
    TODO { "" }
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
	  bfs=basicForStatement { bfs }
	| efs=enhancedForStatement { efs }
	
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
	  FOR LPAREN jt=jType id=identifier COLON e=expression RPAREN s=statement { "for ("^jt^" "^id^" : "^e^")\n"^s }
	| FOR LPAREN vm=variableModifiers jt=jType id=identifier COLON e=expression RPAREN s=statement { "for ("^vm^" "^jt^" "^id^" : "^e^")\n"^s }

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
    | TODO { "" }
	
literal:
	  il=integerLiteral { il }

	| fpl=floatingPointLiteral { fpl }
	| bl=booleanLiteral { bl }
	| cl=characterLiteral { cl }
	| sl=stringLiteral { sl }
	| nl=nullLiteral { nl }


integerLiteral:
    TODO { "" }

floatingPointLiteral:
    TODO { "" }

booleanLiteral:
    TODO { "" }

stringLiteral:
    TODO { "" }

characterLiteral:
    TODO { "" }

nullLiteral:
    TODO { "" }

(* 15.9 TODO *)

(* 15.10 Array Creation Expressions *)
arrayCreationExpression:
	  NEW pt=primitiveType des=dimExprs { pt^des }
	| NEW pt=primitiveType des=dimExprs ds=dims { pt^des^ds }
	| NEW coit=classOrInterfaceType des=dimExprs { coit^des }
	| NEW coit=classOrInterfaceType des=dimExprs ds=dims { coit^des^ds }
	| NEW pt=primitiveType ds=dims ai=arrayInitializer { pt^ds^" "^ai }
	| NEW coit=classOrInterfaceType ds=dims ai=arrayInitializer { coit^ds^" "^ai }

dimExprs:
	  de=dimExpr { de }
	| des=dimExprs de=dimExpr { des^de }

dimExpr:
	LBRACK e=expression RBRACK { "["^e^"]" }

dims:
	  LBRACK RBRACK { "[]" }
	| d=dims LBRACK RBRACK { d^"[]" }

classOrInterfaceType:
    TODO { "" }
(* 15.11 Field Access Expressions *)
fieldAccess:
    p=primary PERIOD id=identifier { p^"."^id }
    | SUPER PERIOD id=identifier { "super."^id }
    | cn=className PERIOD SUPER PERIOD id=identifier { cn^".super."^id }

className:
    TODO { "" }

arrayInitializer:
    TODO { "" }
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
*)







%%

