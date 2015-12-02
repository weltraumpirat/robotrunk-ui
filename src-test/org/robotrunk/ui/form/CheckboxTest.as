package org.robotrunk.ui.form {
	import org.robotrunk.ui.button.impl.SwitchButtonImpl;
	import org.robotrunk.ui.form.impl.CheckboxImpl;

	public class CheckboxTest extends AbstractSelectableFormElementTest {
		override protected function getElementInstance():SwitchButtonImpl {
			return new CheckboxImpl();
		}
	}
}
