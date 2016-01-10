class MethodInvocation {

	void foo() {
	
		method1();
		method2(a, b);
		super.superMethod1();
		super.superMethod1(a, qsd8);

		ClassName2.super.parentMethod();
		ClassName2.super.parentMethod2(a, b, c);
		
		ClassName1.class.method();
		ClassName1.class.method(a, "str");

		void.class.method();
		void.class.method(zae, "str", new ClassName());

		this.method();
		this.method(a, b, 3);

		ClassName1.this.method();
		ClassName1.this.method(a, b);

		(new ClassName()).test();
		(new ClassName()).test(a, b);

		new ClassName().test();
		new ClassName().test(a, b);


		ClassName2.method();
		ClassName2.method(a, b);

		method().called().in().chain();
		method(a, 2).called().in(4).chain(4, a);

		ClassArray[2].method();
		ClassArray[4].method(a, "str");

	}


}
