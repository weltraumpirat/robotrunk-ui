package org.robotrunk.ui.text {
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotrunk.common.logging.api.Logger;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.impl.UIViewImpl;
	import org.robotrunk.ui.core.impl.content.EmptyContent;
	import org.robotrunk.ui.text.impl.LabelImpl;

	public class LabelTest {
		private var component:LabelImpl;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var log:Logger;

		[Mock]
		public var position:Position;

		private var statesDict:Dictionary;

		[Before(ui)]
		public function setUp():void {
			component = new LabelImpl();

			statesDict = new Dictionary();
			statesDict.one = mockView( "one" );
			statesDict.two = mockView( "two" );
			component.states = statesDict;
			var container:UIComponent = new UIComponent();
			container.addChild( component );
			UIImpersonator.addChild( container );
		}

		private function mockView( name:String ):UIViewImpl {
			var view:UIViewImpl = new UIViewImpl();
			view.style = new Style();
			view.position = new Position();
			view.position.padding = new Padding();
			view.content = new EmptyContent();
			view.state = name;
			return view;
		}

		[Test]
		public function canSwitchStates():void {
			assertFalse( DisplayObjectContainer( component ).contains( statesDict.one ) );
			assertFalse( DisplayObjectContainer( component ).contains( statesDict.two ) );

			component.currentState = "one";
			assertTrue( DisplayObjectContainer( component ).contains( statesDict.one ) );
			statesDict.one.dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
			assertTrue( statesDict.one.visible );
			assertFalse( DisplayObjectContainer( component ).contains( statesDict.two ) );

			component.currentState = "two";
			assertTrue( DisplayObjectContainer( component ).contains( statesDict.two ) );
			statesDict.two.dispatchEvent( new ViewEvent( ViewEvent.RENDER_COMPLETE ) );
			assertFalse( statesDict.one.visible );
			assertTrue( statesDict.two.visible );
		}

		[Test]
		public function logsWarningIfStateDoesNotExist():void {
			mock( log ).method( "warn" ).anyArgs();
			component["log"] = log;
			component.currentState = "somethingelse";
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			component = null;
		}
	}
}
