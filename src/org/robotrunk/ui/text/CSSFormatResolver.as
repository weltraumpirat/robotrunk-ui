package org.robotrunk.ui.text {
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;

	import flashx.textLayout.elements.DivElement;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.FlowGroupElement;
	import flashx.textLayout.elements.IFormatResolver;
	import flashx.textLayout.elements.InlineGraphicElement;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.SubParagraphGroupElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.ITextLayoutFormat;
	import flashx.textLayout.formats.TextLayoutFormat;

	import org.robotools.data.propertyCount;
	import org.robotrunk.common.error.ConfigurationException;
	import org.robotrunk.ui.core.Style;
	import org.robotrunk.ui.core.StyleMap;

	public class CSSFormatResolver implements IFormatResolver {
		private var _styleFormatCache:Dictionary;

		private var _styleMap:StyleMap;

		public function CSSFormatResolver( styleSheet:StyleSheet ):void {
			_styleMap = new StyleMap();
			_styleMap.styleSheet = styleSheet;
			_styleFormatCache = new Dictionary( true );
		}

		public function getResolverForNewFlow( oldFlow:TextFlow, newFlow:TextFlow ):IFormatResolver {
			return this;
		}

		public function invalidate( target:Object ):void {
			delete _styleFormatCache[target];

			var blockElem:FlowGroupElement = target as FlowGroupElement;
			if( blockElem ) {
				var i:int = blockElem.numChildren;
				while( --i>=0 ) {
					invalidate( blockElem.getChildAt( i ) );
				}
			}
		}

		public function invalidateAll( tf:TextFlow ):void {
			_styleFormatCache = null;
			_styleFormatCache = new Dictionary( true );
		}

		public function resolveFormat( elem:Object ):ITextLayoutFormat {
			var flow:FlowElement = elem as FlowElement;
			return flow ? resolveFormatWithoutUserStyle( flow ) : undefined;
		}

		private function resolveFormatWithoutUserStyle( flow:FlowElement ):ITextLayoutFormat {
			if( !_styleFormatCache[flow] ) {
				_styleFormatCache[flow] = formatWithoutUserStyle( flow );
			}
			return _styleFormatCache[flow];
		}

		private function formatWithoutUserStyle( flow:FlowElement ):TextLayoutFormat {
			var style:Style = styleWithoutUserStyle( flow );
			return applyToTextLayoutFormat( style );
		}

		private function styleWithoutUserStyle( flow:FlowElement ):Style {
			var type:String = getElementName( flow );
			var clazz:String = flow.styleName ? flow.styleName : null;
			var id:String = flow.id ? flow.id : null;

			return _styleMap.getStyleCascaded( type, clazz, id );
		}

		protected function applyToTextLayoutFormat( style:Style ):TextLayoutFormat {
			return (style && propertyCount( style )>0) ? style.toTLF() : undefined;
		}

		public function resolveUserFormat( elem:Object, userStyle:String ):* {
			var flowElem:FlowElement = elem as FlowElement;
			if( flowElem is LinkElement ) {
				resolveLinkFormats( flowElem, userStyle );
			}
			return flowElem ? resolveFormatWithUserStyle( userStyle, flowElem ) : undefined;
		}

		private function resolveLinkFormats( flowElem:FlowElement, userStyle:String ):void {
			flowElem.linkActiveFormat = getLinkFormat( flowElem, userStyle, "active" );
			flowElem.linkHoverFormat = getLinkFormat( flowElem, userStyle, "hover" );
			flowElem.linkNormalFormat = getLinkFormat( flowElem, userStyle, "link" );
		}

		private function getLinkFormat( flowElem:FlowElement, userStyle:String, pseudo:String ):* {
			var type:String = getElementName( flowElem )+":"+pseudo;
			var clazz:String = userStyle != null ? userStyle+":"+pseudo : null;
			var id:String = flowElem.id != null ? flowElem.id+":"+pseudo : null;
			return applyToTextLayoutFormat( _styleMap.getComponentStyleCascaded( type, clazz, id ) );
		}

		private function resolveFormatWithUserStyle( userStyle:String, flowElem:FlowElement ):* {
			var style:String = styleWithUserStyle( flowElem, userStyle );
			return formatWithUserStyle( flowElem, style );
		}

		private function styleWithUserStyle( flowElem:FlowElement, style:String ):String {
			return flowElem.styleName;
		}

		private function formatWithUserStyle( flow:FlowElement, userStyle:String ):TextLayoutFormat {
			var type:String = getElementName( flow );
			var clazz:String = userStyle ? userStyle : null;
			var id:String = flow.id ? flow.id : null;

			var style:Style = _styleMap.getStyleCascaded( type, clazz, id );
			return applyToTextLayoutFormat( style );
		}

		private function getElementName( elem:* ):String {
			if( elem is SubParagraphGroupElement ) {
				return null;
			}
			if( elem is SpanElement ) {
				return "span";
			}
			if( elem is ParagraphElement ) {
				return "p";
			}
			if( elem is DivElement ) {
				return "div";
			}
			if( elem is LinkElement ) {
				return "a";
			}
			if( elem is InlineGraphicElement ) {
				return "img";
			}
			if( elem is TextFlow ) {
				return "body";
			}
			throw new ConfigurationException( "unknown element encountered:"+elem.id+":"+elem.styleName+":"+elem.toString() );
		}
	}
}
