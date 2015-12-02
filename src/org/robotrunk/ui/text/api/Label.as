package org.robotrunk.ui.text.api {
	import org.robotrunk.ui.core.api.UIComponent;

	include "../../../../../../includes/htmlTextImport.as";

	public interface Label extends UIComponent {
		include "../../../../../../includes/htmlTextInterface.as";
		function get fieldWidth():Number;

		function set fieldWidth( width:Number ):void;

		function get fieldHeight():Number;

		function set fieldHeight( height:Number ):void;
	}
}
