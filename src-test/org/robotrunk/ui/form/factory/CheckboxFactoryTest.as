package org.robotrunk.ui.form.factory {
	import org.robotrunk.ui.button.factory.SwitchButtonFactoryTest;
	import org.robotrunk.ui.form.impl.CheckboxImpl;

	public class CheckboxFactoryTest extends SwitchButtonFactoryTest {
		[Before]
		override public function setUp():void {
			factory = new CheckboxFactory();
		}

		[Test]
		override public function createsButton():void {
			testCreatesButton( CheckboxImpl );
		}
	}
}
