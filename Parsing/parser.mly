%{

let string_of_option o =
    match o with
    | None -> ""
    | Some(o) -> o

let print_error str =
    print_string str;
    str


%}


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
%token PLUS MINUS MULT DIV MOD INCR DECR TILDE EXCL LSHIFT RSHIFT USHIFT INF SUP INFEQUAL SUPEQUAL 
TRUEEQUAL NOTEQUAL AND EXCLUSIVEOR INCLUSIVEOR CONDITIONALAND CONDITIONALOR CONDITIONAL

(* assignment operators *)
%token EQUAL MULTEQUAL DIVEQUAL MODEQUAL PLUSEQUAL MINUSEQUAL LSHIFTEQUAL RSHIFTEQUAL USHIFTEQUAL BITANDEQUAL BITXOREQUAL BITOREQUAL

(* delimitors *)
%token COMMA SEMICOLON COLON LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK PERIOD

(* keyword *)
%token ABSTRACT CLASS SHORT BYTE INT LONG FLOAT DOUBLE VOID FINAL NATIVE PRIVATE PROTECTED PUBLIC STATIC STRICTFP 
SYNCHRONIZED NEW SUPER THIS INSTANCEOF

(* statemeknts *)
%token IF ELSE ASSERT SWITCH CASE DEFAULT WHILE DO FOR BREAK CONTINUE RETURN THROW 
TRY CATCH FINALLY

(* special *)
%token EOF 
%token <string> IDENT
%token <char> NOTZERO
%token ZERO
%token TRUE FALSE NULL

%start <string> compilationUnit

%%

(* 3.8 identifiers *)
identifier:
    id=IDENT { id }
    
(* 3.10 Literals *)
literal:
	  il=integerLiteral { il }
	| fpl=floatingPointLiteral { fpl }
	| bl=booleanLiteral { bl }
	| cl=characterLiteral { cl }
	| sl=stringLiteral { sl }
	| nl=nullLiteral { nl }

(* A compléter ! *)
integerLiteral:
	dil=decimalIntegerLiteral { dil }

decimalIntegerLiteral:
	dn=decimalNumeral { dn }
	
decimalNumeral:
	  ZERO { "0" }
	| nz=NOTZERO { (String.make 1 nz) }
	| nz=NOTZERO ds=digits  { (String.make 1 nz)^ds } 

digits:
	  d=digit { d }
	| ds=digits d=digit { ds^d }

digit:
	  ZERO { "0" }
	| nz=NOTZERO { (String.make 1 nz) }

(* A compléter ! *)
floatingPointLiteral:
    dfpl=decimalFloatingPointLiteral { dfpl }

decimalFloatingPointLiteral:
	  ds=digits PERIOD { ds^"." }
	| ds1=digits PERIOD ds2=digits { ds1^"."^ds2 }
	| PERIOD ds=digits { "."^ds }

booleanLiteral:
      TRUE { "true" }
    | FALSE { "false" }

stringLiteral:
    i=IDENT { i }

characterLiteral:
    TODO { "" }

nullLiteral:
    NULL { "null" }

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
    (*| rt=referenceType { rt }*)

(* 4.3 Reference Types and Values *)
referenceType:
	  coit=classOrInterfaceType { coit }
	| tv=typeVariable { tv }
	| at=arrayType { at }

classOrInterfaceType:
	  ct=classType { ct }
	| it=interfaceType { it }

classType:
	  tds=typeDeclSpecifier { tds }
	| tds=typeDeclSpecifier tas=typeArguments { tds^" "^tas }

interfaceType:
	  tds=typeDeclSpecifier { tds }
	| tds=typeDeclSpecifier tas=typeArguments { tds^" "^tas }

typeDeclSpecifier:
	  tn=typeName { tn }
	| coit=classOrInterfaceType PERIOD id=identifier { coit^"."^id }

typeName:
	  id=identifier { id }
	| tn=typeName PERIOD id=identifier { tn^"."^id }

typeVariable:
	id=identifier { id }

arrayType:
	jt=jType LBRACK RBRACK { "["^jt^"]" }

(* 6.5 Meaning of a name *)

(* Not called by other rules
packageName:
    TODO { "" }
*)

methodName:
    id=identifier { id }
    | an=ambiguousName PERIOD id=identifier { an^"."^id }

(* Not called by other rules
 * packageOrTypeName:
    TODO { "" }
*)

expressionName:
    id=identifier { id }
    | an=ambiguousName PERIOD id=identifier { an^"."^id }

ambiguousName:
    id=identifier { id }
    | an=ambiguousName PERIOD id=identifier { an^"."^id }
 
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
    | ii=instanceInitializer {ii}
    | si=staticInitializer {si}
    | cd=constructorDeclaration { cd }

classMemberDeclaration:
      fd=fieldDeclaration { fd }
    | md=methodDeclaration { md }
    | SEMICOLON { ";" } 
    
(* 8.3 Field Declarations *)
fieldDeclaration:
    jt=jType vdl=variableDeclarators SEMICOLON { jt^" "^vdl^";"}

variableDeclarators:
      vd=variableDeclarator { vd }
    | vds=variableDeclarators COMMA vd=variableDeclarator { vds^", "^vd }

variableDeclarator:
    vdi=variableDeclaratorId { vdi }
    | vdi=variableDeclaratorId EQUAL vi=variableInitializer { vdi^" = "^vi }

variableDeclaratorId:
      id=identifier { id }
    | vdi=variableDeclaratorId LBRACK RBRACK { vdi^"[ ]" }

variableInitializer:
      e=expression { e } 
    | ai=arrayInitializer { ai } 

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

methodBody:
	SEMICOLON { ";" }
	| b=block { b }

(* 8.4.1 Formal Parameters *)
formalParameterList:
	lfp = lastFormalParameter {lfp}
	| fp=formalParameters COMMA lfp = lastFormalParameter {fp^", "^lfp} 

formalParameters:
	fp=formalParameter {fp}
	|fps=formalParameters COMMA fp=formalParameter {fps^" , "^fps}

formalParameter:
	  jt=jType vdi=variableDeclaratorId {jt^" "^vdi}
	| vm = variableModifiers jt=jType vdi=variableDeclaratorId {vm^" "^jt^" "^vdi}

variableModifiers:
	vm=variableModifier {vm}
	| vms=variableModifiers vm=variableModifier {vms^" "^vm}

variableModifier:
	| FINAL { "final" }

lastFormalParameter:
	|vms=variableModifiers vdi=variableDeclaratorId {vms^" "^vdi}
	|fp = formalParameter {fp}

(* 8.6 Instance Initializers *)
instanceInitializer:
	b=block {b}

(* 8.7 Static Initializers *)
staticInitializer:
	STATIC b=block {"static "^b}

(* 8.8 Constructor Declarations *)
constructorDeclaration:
	|cd=constructorDeclarator cb=constructorBody {cd^" "^cb}
	|cm=constructorModifiers cd=constructorDeclarator cb=constructorBody {cm^" "^cd^" "^cb}

constructorDeclarator:
	|stn=simpleTypeName LPAREN RPAREN {stn^" ( )"}
	|stn=simpleTypeName LPAREN fpl=formalParameterList RPAREN {stn^" ("^fpl^")"}

(* todo : simpleTypeName has to be the name of the class that contains the identifier *)
simpleTypeName:
	i=identifier {i}

constructorBody:
	LBRACE RBRACE { " {} "}
	| LBRACE bs=blockStatements RBRACE { " {\n"^bs^"\n}" }

constructorModifiers:
	cm=constructorModifier {cm}
	| cms=constructorModifiers cm=constructorModifier {cms^" "^cm}

constructorModifier:
	| PUBLIC {"public"}
	| PROTECTED {"protected"}
	| PRIVATE {"private"}
	
nonWildTypeArguments:
    INF rtl=referenceTypeList SUP { "< "^rtl^" >" }

referenceTypeList:
    rt=referenceType { rt }
    | rtl=referenceTypeList COMMA rt=referenceType { rtl^", "^rt }

(* 10.6 Array Initializers *)
arrayInitializer:
	  LBRACE RBRACE { "{}" }
	| LBRACE vis=variableInitializers  RBRACE { "{"^vis^"}" }
	| LBRACE COMMA RBRACE { "{,}" }
	| LBRACE vis=variableInitializers COMMA RBRACE { "{"^vis^",}" }

variableInitializers:
	  vi=variableInitializer { vi }
	| vis=variableInitializers COMMA vi=variableInitializer { vis^" , "^vi }

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
	| jt=jType vds=variableDeclarators { jt^" "^vds }

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
	id=identifier { id }

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
	| jt=jType PERIOD CLASS { jt^".class" }
	| VOID PERIOD CLASS { "void.class" }
	| THIS { "this" }
	| cn=className PERIOD THIS { cn^".this" }
	| LPAREN e=expression RPAREN { "("^e^")" }
	| cice=classInstanceCreationExpression { cice }
	| fa=fieldAccess { fa }
	| mi=methodInvocation { mi }
	| aa=arrayAccess { aa }

(* 15.9 Class Instance Creation Expressions *)
classInstanceCreationExpression:
	  NEW tas=typeArguments coit=classOrInterfaceType LPAREN RPAREN { "new "^tas^" "^coit^"()" }
	| NEW coit=classOrInterfaceType LPAREN al=argumentList RPAREN { "new "^coit^"("^al^")" }
	| NEW coit=classOrInterfaceType LPAREN RPAREN cb=classBody { "new "^coit^"() "^cb }
	| NEW tas=typeArguments coit=classOrInterfaceType LPAREN al=argumentList RPAREN { "new "^tas^" "^coit^"("^al^")" }
	| NEW tas=typeArguments coit=classOrInterfaceType LPAREN RPAREN cb=classBody { "new "^tas^" "^coit^"() "^cb }
	| NEW coit=classOrInterfaceType LPAREN al=argumentList RPAREN cb=classBody { "new "^coit^"("^al^") "^cb }
	| NEW tas=typeArguments coit=classOrInterfaceType LPAREN al=argumentList RPAREN cb=classBody { "new "^tas^" "^coit^"("^al^") "^cb }	
	| p=primary PERIOD NEW id=identifier LPAREN RPAREN { p^". new "^id^" ()" }
	| p=primary PERIOD NEW ta1=typeArguments id=identifier LPAREN RPAREN { p^". new "^ta1^" "^id^" ()" }
	| p=primary PERIOD NEW id=identifier ta2=typeArguments LPAREN RPAREN { p^". new "^id^" "^ta2^" ()" }
	| p=primary PERIOD NEW id=identifier LPAREN al=argumentList RPAREN { p^". new "^id^" ("^al^")" }
	| p=primary PERIOD NEW id=identifier LPAREN RPAREN cb=classBody { p^". new "^id^" () "^cb }
	| p=primary PERIOD NEW ta1=typeArguments id=identifier ta2=typeArguments LPAREN RPAREN { p^". new "^ta1^" "^id^" "^ta2^" ()" }
	| p=primary PERIOD NEW ta1=typeArguments id=identifier LPAREN al=argumentList RPAREN { p^". new "^ta1^" "^id^" ("^al^")" }
	| p=primary PERIOD NEW ta1=typeArguments id=identifier LPAREN RPAREN cb=classBody { p^". new "^ta1^" "^id^" () "^cb }
	| p=primary PERIOD NEW id=identifier ta2=typeArguments LPAREN al=argumentList RPAREN { p^". new "^id^" "^ta2^" ("^al^")" }
	| p=primary PERIOD NEW id=identifier ta2=typeArguments LPAREN RPAREN cb=classBody { p^". new "^id^" "^ta2^" () "^cb }
	| p=primary PERIOD NEW id=identifier LPAREN al=argumentList RPAREN cb=classBody { p^". new "^id^" ("^al^") "^cb }
	| p=primary PERIOD NEW ta1=typeArguments id=identifier ta2=typeArguments LPAREN al=argumentList RPAREN { p^". new "^ta1^" "^id^" "^ta2^" ("^al^")" }
	| p=primary PERIOD NEW ta1=typeArguments id=identifier ta2=typeArguments LPAREN RPAREN cb=classBody { p^". new "^ta1^" "^id^" "^ta2^" () "^cb }
	| p=primary PERIOD NEW ta1=typeArguments id=identifier LPAREN al=argumentList RPAREN cb=classBody { p^". new "^ta1^" "^id^" ("^al^") "^cb }
	| p=primary PERIOD NEW id=identifier ta2=typeArguments LPAREN al=argumentList RPAREN cb=classBody { p^". new "^id^" "^ta2^" ("^al^") "^cb }
	| p=primary PERIOD NEW ta1=typeArguments id=identifier ta2=typeArguments LPAREN al=argumentList RPAREN cb=classBody { p^". new "^ta1^" "^id^" "^ta2^" ("^al^") "^cb }
	
argumentList:
	  e=expression { e }
	| al=argumentList COMMA e=expression { al^" , "^e }
	
typeArguments:
	TODO { "" }

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

(* 15.11 Field Access Expressions *)
fieldAccess:
    p=primary PERIOD id=identifier { p^"."^id }
    | SUPER PERIOD id=identifier { "super."^id }
    | cn=className PERIOD SUPER PERIOD id=identifier { cn^".super."^id }

className:
    TODO { "" }

(* 15.12 Method invocation *)
methodInvocation:
    mn=methodName LPAREN al=argumentList? RPAREN { mn^"("^(string_of_option al)^")"  }
   | p=primary PERIOD nwta=nonWildTypeArguments? id=identifier LPAREN al=argumentList? RPAREN { p^"."^(string_of_option nwta)^" "^id^"("^(string_of_option al)^")" }
   | SUPER PERIOD nwta=nonWildTypeArguments? id=identifier LPAREN al=argumentList? RPAREN { "super."^(string_of_option nwta)^" "^id^"("^(string_of_option al)^")" }
   | cn=className PERIOD SUPER PERIOD nwta=nonWildTypeArguments? id=identifier LBRACE al=argumentList? RPAREN { cn^".super."^(string_of_option nwta)^" "^id^"("^(string_of_option al)^")" }
   | tn=typeName PERIOD nwta=nonWildTypeArguments id=identifier LPAREN al=argumentList? RPAREN { tn^"."^nwta^" "^id^"("^(string_of_option al)^")" }
   (*| error { print_error "error in methodInvocation production" } *)

   
(* 15.13 Array Access Expressions *)
 arrayAccess:
	  en=expressionName LBRACK e=expression RBRACK { en^" ["^e^"]" }
	| pnna=primaryNoNewArray LBRACK e=expression RBRACK { pnna^" ["^e^"]" }
	
(* 15.14 Postfix Expressions *)
postfixExpression:
	  p=primary { p }
	| en=expressionName { en }
	| pie=postIncrementExpression { pie }
	| pde=postDecrementExpression { pde }
	
postIncrementExpression:
	pfe=postfixExpression INCR { pfe^" ++" }
	
postDecrementExpression:
	pfe=postfixExpression DECR { pfe^" --" }

(* 15.15 Unary operators *)

unaryExpression:
    pie=preIncrementExpression { pie }
    | pde=preDecrementExpression { pde }
    | PLUS ue=unaryExpression { "+"^ue }
    | MINUS ue=unaryExpression { "-"^ue }
    | uenpm=unaryExpressionNotPlusMinus { uenpm }

preIncrementExpression:
    INCR ue=unaryExpression { "++"^ue }

preDecrementExpression:
    DECR ue=unaryExpression { "--"^ue }

unaryExpressionNotPlusMinus:
    pe=postfixExpression { pe }
    | TILDE ue=unaryExpression { "~"^ue }
    | EXCL ue=unaryExpression { "!"^ue }
    | ce=castExpression { ce }
    (*| error { print_error "error: unaryExpressionNotPlusMinus" }*)

(* 15.16 Cast expression *)
castExpression:
	  LPAREN pt=primitiveType RPAREN ue=unaryExpression { "("^pt^") "^ue }
	| LPAREN pt=primitiveType ds=dims RPAREN ue=unaryExpression { "("^pt^ds^") "^ue }
	| LPAREN rt=referenceType RPAREN uenpm=unaryExpressionNotPlusMinus { "("^rt^") "^uenpm }
	
(* 15.17 Multiplicative Operators *)
multiplicativeExpression:
	  ue=unaryExpression { ue }
	| me=multiplicativeExpression MULT ue=unaryExpression { me^" * "^ue }
	| me=multiplicativeExpression DIV ue=unaryExpression { me^" / "^ue }
	| me=multiplicativeExpression MOD ue=unaryExpression { me^" % "^ue }
	
(* 15.18 Additive Operators *)
additiveExpression:
	  me=multiplicativeExpression { me }
	| ae=additiveExpression PLUS me=multiplicativeExpression { ae^" + "^me }
	| ae=additiveExpression MINUS me=multiplicativeExpression { ae^" - "^me }
	
(* 15.19 Shift Operators *)
shiftExpression:
	  ae=additiveExpression { ae }
	| es=shiftExpression LSHIFT ae=additiveExpression { es^" << "^ae }
	| es=shiftExpression RSHIFT ae=additiveExpression { es^" >> "^ae }
	| es=shiftExpression USHIFT ae=additiveExpression  { es^" >>> "^ae }
	
(* 15.20 Relational Operators *)
relationalExpression:
	  se=shiftExpression { se }
	| re=relationalExpression INF se=shiftExpression { re^" < "^se }
	| re=relationalExpression SUP se=shiftExpression { re^" > "^se }
	| re=relationalExpression INFEQUAL se=shiftExpression { re^" <= "^se }
	| re=relationalExpression SUPEQUAL se=shiftExpression { re^" >= "^se }
	| re=relationalExpression INSTANCEOF rt=referenceType { re^" instanceof "^rt }
	
(* 15.21 Equality Operators *)
equalityExpression:
	  re=relationalExpression { re }
	| ee=equalityExpression TRUEEQUAL re=relationalExpression { ee^" == "^re }
	| ee=equalityExpression NOTEQUAL re=relationalExpression { ee^" != "^re }
	
(* 15.22 Bitwise and Logical Operators *)
andExpression:
	  ee=equalityExpression { ee }
	| ae=andExpression AND ee=equalityExpression { ae^" & "^ee }

exclusiveOrExpression:
	  ae=andExpression { ae }
	| eoe=exclusiveOrExpression EXCLUSIVEOR ae=andExpression { eoe^" ^ "^ae }

inclusiveOrExpression:
	  eoe=exclusiveOrExpression { eoe }
	| ioe=inclusiveOrExpression INCLUSIVEOR eoe=exclusiveOrExpression { ioe^" | "^eoe }
	
(* 15.23 Conditional-And Operator && *)
conditionalAndExpression:
	  ioe=inclusiveOrExpression { ioe }
	| cae=conditionalAndExpression CONDITIONALAND ioe=inclusiveOrExpression { cae^" && "^ioe }

(* 15.24 Conditional-Or Operator || *)
conditionalOrExpression:
	  cae=conditionalAndExpression { cae }
	| coe=conditionalOrExpression CONDITIONALOR cae=conditionalAndExpression { coe^" || "^cae }

(* 15.25 Conditional Operator ? *)
conditionalExpression:
	  coe=conditionalOrExpression { coe }
	| coe=conditionalOrExpression CONDITIONAL e=expression COLON ce=conditionalExpression { coe^" ? "^e^" : "^ce }

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

(*15.27 Expression*)
expression:
    ae=assignmentExpression { ae }

(* 15.28 Constant Expression *)
constantExpression:
	e=expression { e }

%%

