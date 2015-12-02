package org.robotrunk.ui.form.impl {
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	import org.robotrunk.ui.buttonbar.impl.RelayButtonBarImpl;
	import org.robotrunk.ui.core.impl.CreationParameters;
	import org.robotrunk.ui.form.api.RadioButton;
	import org.robotrunk.ui.form.api.RadioButtonElement;
	import org.robotrunk.ui.form.factory.RadioButtonElementFactory;

	public class RadioButtonImpl extends RelayButtonBarImpl implements RadioButton {
		private var _value:String = "";
		private var _dataProvider:Array;
		private var _params:CreationParameters;
		private var _elementFactory:RadioButtonElementFactory;

		public function get value():String {
			return selectedButtonValue;
		}

		private function get selectedButtonValue():String {
			for each( var btn:RadioButtonElement in buttons ) {
				if( btn.active ) {
					return btn.value;
				}
			}
			return "";
		}

		public function get assignedValue():String {
			return _value;
		}

		public function set assignedValue( value:String ):void {
			_value = value;
			selectButtonAccordingToValue();
		}

		private function selectButtonAccordingToValue():void {
			for each( var btn:RadioButtonElement in buttons ) {
				btn.active = btn.assignedValue == _value;
			}
		}

		override public function set buttons( buttons:Vector.<DisplayObject> ):void {
			super.buttons = buttons;
			(buttons[0] as RadioButtonElement).active = true;
		}

		public function get dataProvider():Array {
			return _dataProvider;
		}

		public function set dataProvider( dataProvider:Array ):void {
			_dataProvider = dataProvider;
			if( dataProvider ) {
				buttons = createButtonElementsFromDataProvider();
			}
		}

		private function createButtonElementsFromDataProvider():Vector.<DisplayObject> {
			var elms:Vector.<DisplayObject> = new <DisplayObject>[];
			for each( var entry:String in dataProvider ) {
				elms[elms.length] = createElement( entry, params.asDictionary() ) as DisplayObject;
			}
			return elms;
		}

		private function createElement( entry:String, dict:Dictionary ):RadioButtonElement {
			var element:RadioButtonElement = elementFactory.create( params.injector, dict ) as RadioButtonElement;
			element.position = null;
			element.assignedValue = entry;
			return element;
		}

		public function get params():CreationParameters {
			return _params;
		}

		public function set params( value:CreationParameters ):void {
			_params = value;
		}

		public function get elementFactory():RadioButtonElementFactory {
			return _elementFactory;
		}

		public function set elementFactory( value:RadioButtonElementFactory ):void {
			_elementFactory = value;
		}
	}
}