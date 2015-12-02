package
org.robotrunk.ui.button {
	import org.robotrunk.ui.button.factory.AbstractButtonFactoryTest;
	import org.robotrunk.ui.button.factory.SimpleButtonFactoryTest;
	import org.robotrunk.ui.button.factory.SwitchButtonFactoryTest;
	import org.robotrunk.ui.button.factory.TextButtonFactoryTest;
	import org.robotrunk.ui.button.factory.TextSwitchButtonFactoryTest;
	import org.robotrunk.ui.button.factory.TextToggleButtonFactoryTest;
	import org.robotrunk.ui.button.factory.ToggleButtonFactoryTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ButtonTestSuite {
		public var abstractButtonFactoryTest:AbstractButtonFactoryTest;

		public var simpleButtonFactoryTest:SimpleButtonFactoryTest;

		public var simpleButtonTest:SimpleButtonTest;

		public var switchButtonFactoryTest:SwitchButtonFactoryTest;

		public var textButtonFactoryTest:TextButtonFactoryTest;

		public var textSwitchButtonFactoryTest:TextSwitchButtonFactoryTest;

		public var textToggleButtonFactoryTest:TextToggleButtonFactoryTest;

		public var toggleButtonFactoryTest:ToggleButtonFactoryTest;

		public var toggleButtonTest:ToggleButtonTest;
	}
}
