package org.robotrunk.ui.core.util {
	import org.robotools.data.enumerateKeys;

	public function traceStyle( cssStyle:* ):void {
		var props:Array = enumerateKeys( cssStyle );
		var result:String = "";
		for each( var key:String in props ) {
			result += key+":"+cssStyle[key]
					  +"\n";
		}
		trace( result );
	}
}
