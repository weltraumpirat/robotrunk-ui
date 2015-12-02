package org.robotrunk.ui.form {
	import org.robotrunk.ui.form.factory.CheckboxFactoryTest;
	import org.robotrunk.ui.form.factory.DropDownListElementFactoryTest;
	import org.robotrunk.ui.form.factory.InputFieldFactoryTest;
	import org.robotrunk.ui.form.factory.RadioButtonElementFactoryTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FormTestSuite {
		public var checkboxFactoryTest:CheckboxFactoryTest;

		public var checkboxTest:CheckboxTest;

		public var dropDownListTest:DropDownListTest;

		public var dropDownListElementTest:DropDownListElementTest;

		public var dropDownListElementFactoryTest:DropDownListElementFactoryTest;

		public var inputFieldFactoryTest:InputFieldFactoryTest;

		public var radioButtonTest:RadioButtonTest;

		public var radioButtonElementTest:RadioButtonElementTest;

		public var radioButtonElementFactoryTest:RadioButtonElementFactoryTest;
	}
}
