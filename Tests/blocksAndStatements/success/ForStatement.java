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
		for (int i : i==0)
			;
		for (final int i : j==0)
			;
	}
}