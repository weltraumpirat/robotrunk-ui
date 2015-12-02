import org.robotrunk.ui.core.api.UIView;

private var _htmlText:String;

public function get htmlText():String {
	return _htmlText;
}

public function set htmlText( text:String ):void {
	_htmlText = text;
	if( states ) {
		for each ( var view:UIView in states ) {
			var tx:String = _htmlText;
			var cls:String = view.state != "default" ? style.clazz+":"+view.state : style.clazz;
			try {
				view.content["htmlText"] = tx.replace( "class=\"multiple", "class=\""+cls );
			} catch( ignore:Error ) {
			}
		}
	}
}