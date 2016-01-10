class ComplexAssignment {

	void foo() {
	
		a = b = 3;
		a = a ? b : c;
		a = b %= c;
	}

}
