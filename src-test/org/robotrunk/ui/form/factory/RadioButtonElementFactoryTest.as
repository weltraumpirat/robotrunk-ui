package org.robotrunk.ui.form.factory {
	import mockolate.mock;

	import org.robotrunk.ui.button.factory.SwitchButtonFactoryTest;
	import org.robotrunk.ui.core.impl.content.TextImageContent;
	import org.robotrunk.ui.form.impl.RadioButtonElementImpl;

	public class RadioButtonElementFactoryTest extends SwitchButtonFactoryTest {
		[Before]
		override public function setUp():void {
			factory = new RadioButtonElementFactory();
		}

		override protected function mockInjections():void {
			super.mockInjections();
			mock( injector ).method( "getInstance" ).args( TextImageContent ).returns( new TextImageContent() );
		}

		[Test]
		override public function createsButton():void {
			testCreatesButton( RadioButtonElementImpl );
		}
	}
}
