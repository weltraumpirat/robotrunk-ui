package org.robotrunk.ui.form {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	import mockolate.mock;
	import mockolate.runner.MockolateRule;

	import mx.core.UIComponent;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.hamcrest.object.instanceOf;
	import org.robotrunk.ui.button.impl.SimpleButtonImpl;
	import org.robotrunk.ui.button.impl.TextButtonImpl;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.StyleMap;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.robotrunk.ui.form.factory.DropDownListElementFactory;
	import org.robotrunk.ui.form.impl.DropDownListElementImpl;
	import org.robotrunk.ui.form.impl.DropDownListImpl;
	import org.swiftsuspenders.Injector;

	public class DropDownListTest {
		private var list:DropDownListImpl;

		private var items:Array;

		[Rule]
		public var rule:MockolateRule = new MockolateRule();

		[Mock]
		public var factory:DropDownListElementFactory;

		public var params:CreationParameters;

		[Mock]
		public var injector:Injector;

		[Before(ui)]
		public function setUp():void {
			list = new DropDownListImpl();
			items = [createElement( "one" ), createElement( "two" ), createElement( "three" )];
			list.scrollDownButton = new SimpleButtonImpl();
			list.scrollUpButton = new SimpleButtonImpl();
			list.listButton = new TextButtonImpl();
			list.style = new Style();
			var container:UIComponent = new UIComponent();
			UIImpersonator.addChild( container );
			list.theStage = container.stage;
			container.addChild( list );
		}

		private function createElement( value:String ):DropDownListElementImpl {
			var element:DropDownListElementImpl = new DropDownListElementImpl( value );
			element.style = new Style();
			return element;
		}

		[Test]
		public function containsItemsInListContainer():void {
			list.items = items;
			assertTrue( list.theStage.contains( list.list ) );
			for each( var item:DisplayObject in items ) {
				assertTrue( list.list.contains( item ) );
			}
		}

		[Test]
		public function returnsValueOfSelectedItem():void {
			items[1].active = true;
			list.items = items;
			assertEquals( "two", list.value );
		}

		[Test]
		public function onlyOneItemCanBeSelected():void {
			list.items = items;
			items[1].active = true;
			assertEquals( items[1], list.selectedItem );
			items[2].active = true;
			assertEquals( items[2], list.selectedItem );
			assertFalse( items[1].active );
		}

		[Test(ui)]
		public function mouseClickActivatesItems():void {
			list.items = items;
			items[1].dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
			assertEquals( items[1], list.selectedItem );
			assertTrue( items[1].active );
		}

		[Test]
		public function itemActivationHidesList():void {
			list.items = items;
			list.list.visible = true;
			items[1].active = true;
			assertFalse( list.list.visible );
		}

		[Test]
		public function listButtonClickShowsList():void {
			list.items = items;
			assertFalse( list.list.visible );
			list.listButton.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
			assertTrue( list.list.visible );
		}

		[Test]
		public function cleansUpNicely():void {
			list.items = items;
			UIImpersonator.removeAllChildren();
			assertNull( list.items );
			assertNull( list.scrollDownButton );
			assertNull( list.scrollUpButton );
			assertNull( list.listButton );
			assertNull( list.assignedValue );
			assertEquals( 0, list.numChildren );
		}

		[Test]
		public function doesNotHoldStates():void {
			list.states = new Dictionary();
			assertNull( list.states );
		}

		[Test]
		public function createsElementsFromDataProvider():void {
			mock( injector ).method( "getInstance" ).args( StyleMap, "default" ).returns( new StyleMap() );
			list.params = new CreationParameters( injector, new Dictionary() );
			mock( factory ).method( "create" ).args( instanceOf( Injector ),
													 instanceOf( Dictionary ) ).returns( new DropDownListElementImpl(),
																						 new DropDownListElementImpl(),
																						 new DropDownListElementImpl() ).thrice();
			list.elementFactory = factory;
			list.dataProvider = ["one", "two", "three"];

			assertEquals( 3, list.items.length );
			var i:int = -1;
			while( ++i<list.items.length ) {
				assertEquals( list.dataProvider[i], list.items[i].assignedValue );
			}
		}

		[After(ui)]
		public function tearDown():void {
			UIImpersonator.removeAllChildren();
			items = null;
			list = null;
		}
	}
}
