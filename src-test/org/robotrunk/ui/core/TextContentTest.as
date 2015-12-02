package org.robotrunk.ui.core {
	import flash.events.Event;
	import flash.text.StyleSheet;

	import mockolate.runner.MockolateRule;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.core.impl.content.TextContent;
	import org.robotrunk.ui.text.textfield.tlf.UIComponentTLFTextField;

	public class TextContentTest {
		private var content:TextContent;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var position:Position;

		private var textField:UIComponentTLFTextField;

		private var text:String = "<text><p><span class=\"multiple\">It is a text.</span></p></text>";

		private var style:Style;

		[Before]
		public function setUp():void {
			content = new TextContent();
			var styleSheet:StyleSheet = new StyleSheet();
			styleSheet.parseCSS( ".test{font-family:Arial; font-size:12px; font-weight:normal; color:#000000;}" );
			textField = new UIComponentTLFTextField( styleSheet );
			content.textField = textField;

		}

		[Test(async)]
		public function renders():void {
			style = new Style();
			style.clazz = "test";
			style.autoSize = "left";
			style.iconPosition = "left";
			style.verticalAlign = "middle";
			style.offset = 5;
			content.style = style;

			content.htmlText = text;
			Async.proceedOnEvent( this, content, ViewEvent.RENDER_COMPLETE );

			content.addEventListener( Event.ADDED,
									  Async.asyncHandler( this, assertLeftMiddleAligned, 500 ) );
			content.render();
		}

		private function assertLeftMiddleAligned( ev:Event, data:* = null ):void {
			assertEquals( text, content.htmlText );
			assertTrue( content.contains( textField ) );
			assertEquals( 0, textField.y );
			assertEquals( 0, textField.x );
		}

		[After]
		public function tearDown():void {
			content = null;
			style = null;
			position = null;
		}
	}
}
