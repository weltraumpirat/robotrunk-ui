package org.robotrunk.ui.form {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.robotrunk.ui.core.Padding;
	import org.robotrunk.ui.core.Position;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.event.ViewEvent;
	import org.robotrunk.ui.form.impl.InputTextContent;

	public class InputTextContentTest {
		private var field:InputTextContent;

		[Before(ui)]
		public function setUp():void {
			field = new InputTextContent();
			var style:Style = mockStyle();
			field.textField = new UIComponentInputTLFTextField( style, new Padding() );
			field.style = style;
			field.position = new Position();
			field.position.padding = new Padding();
		}

		private function mockStyle():Style {
			var style:Style = new Style();
			style.width = 210;
			style.height = 25;
			style.autoSize = "none";
			style.multiline = style.wordWrap = false;
			style.verticalAlign = "top";
			style.paddingLeft = style.paddingRight = style.paddingTop = 5;
			style.paddingBottom = 3;
			return style;
		}

		[Test(ui, async)]
		public function renders():void {
			UIImpersonator.addChild( field );
			field.addEventListener( ViewEvent.RENDER_COMPLETE, Async.asyncHandler( this, onRenderComplete, 500 ) );
			field.render();
		}

		private function onRenderComplete( ev:ViewEvent, data:* ):void {
			assertNull( data );
			assertEquals( 200, field.width );
			assertEquals( 17, field.height );
			assertEquals( false, field.textField.multiline );
			assertEquals( false, field.textField.wordWrap );
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			field = null;
		}
	}
}
