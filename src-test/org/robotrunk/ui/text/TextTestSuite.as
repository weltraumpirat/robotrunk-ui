package
org.robotrunk.ui.text {
	import org.robotrunk.ui.text.factory.LabelFactoryTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TextTestSuite {
		public var cSSFormatResolverTest:CSSFormatResolverTest;

		public var labelFactoryTest:LabelFactoryTest;

		public var labelTest:LabelTest;

		//For completeness: This is a user-clickable ui test, to be run occasionally, but not automated!
		//public var smartTextFieldTest : SmartTextFieldTest; 
	}
}
