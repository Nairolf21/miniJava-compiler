public class ExpressionStatements {
	void foo() {
		int i;
		i = 0;
		i++;
		++i;
		--i;
		i--;
		i = foo1(i);
		Toto t = new Toto(i);
	}
}