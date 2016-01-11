public class TryStatement {
	void foo() {
		try {}
		catch (int i) {}
			
		try {}
		catch (int i) {}
		catch (float f) {}
			
		try {}
		finally {}
			
		try {}
		catch (float f) {}
		finally {}
			
		try {}
		catch (int i) {}
		catch (float f) {}
		finally {}
	}
}