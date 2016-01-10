public class ForStatement {
	void foo() {
		for (;;)
			;
		for (i=0;;)
			;
		for (int i =0;;)
			;
		for (i = 0, j = 0;;)
			;
		for (; i == 0;)
			;
		for (;;i=0)
			;
		for (;; i = 0, j = 0)
			;
		for (i=0;i==0;)
			;
		for (int i = 0;i==0;)
			;
		for (i = 0, j = 0;i==0;)
			;
		for (i=0;;i=0)
			;
		for (int i = 0;;i=0)
			;
		for (i=0, j=0;;i=0)
			;
		for (i=0;;i = 0, j = 0)
			;
		for (int i = 0;;i = 0, j = 0)
			;
		for (i=0, j=0;;i = 0, j = 0)
			;
		for (;i==0;i=0)
			;
		for (;i==0; i = 0, j = 0)
			;
		for (int i = 0;i==0;i = 0)
			;
		for (i = 0;i==0;i = 0)
			;
		for (i = 0, j = 0;i==0;i = 0)
			;
		for (int i = 0;i==0;i = 0, j = 0)
			;
		for (i = 0;i==0;i = 0, j = 0)
			;
		for (i = 0, j = 0;i==0;i = 0, j = 0)
			;
	}
}
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
