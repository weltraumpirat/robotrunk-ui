/*
 * Harry - gefangen in der Zeit.
 *
 * Content: Copyright (c) 2013 Deutsche Welle.
 *
 * Design: Copyright (c) 2013 Freiwerk B and Tobias Goeschel.
 *
 * Application source code: Copyright (c) 2013 Tobias Goeschel.
 *
 * All rights reserved.
 */

package org.robotrunk.ui.text.textfield.classic {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;

	public class HtmlTextFormatter {
		private var _content:Array;
		private var _format:String;
		private var _styleSheet:StyleSheet;
		private var _textField:TextField;
		private var _textToHtmlConverter:TextToHtmlConverter;
		private var _htmlToTextParser:HtmlToTextParser;

		public function get htmlText():String {
			return _textToHtmlConverter.convert( _content );
		}

		public function set htmlText( htmlText:String ):void {
			resetContent();
			parseHtmlText( htmlText );
			applyStylesAsTextFormat();
			updateTextField( textField.text.length, textField.text.length );
		}

		private function resetContent():void {
			_content = null;
			_content = [];
			textField.text = "";
		}

		private function parseHtmlText( htmlText:String ):void {
			_content = _htmlToTextParser.parse( htmlText );
		}

		private function updateTextField( selectionStartIndex:int, selectionEndIndex:int ):void {
			textField.setSelection( selectionStartIndex, selectionEndIndex );
			textField.dispatchEvent( new Event( Event.CHANGE, true ) );
		}

		public function add( str:String ):void {
			if( textShouldBeAppendedToLastExistingTextEntry() ) {
				appendToLastExistingTextEntry( str );
			} else {
				pushNewTextEntry( str );
			}

			applyStylesAsTextFormat();
		}

		private function textShouldBeAppendedToLastExistingTextEntry():Boolean {
			return _content.length>0 && _content[_content.length-1].clazz == "."+format;
		}

		private function appendToLastExistingTextEntry( str:String ):void {
			_content[_content.length-1].text += str;
		}

		private function pushNewTextEntry( str:String ):void {
			_content[_content.length] = new TextChunk( str, "."+format );
		}

		private function applyStylesAsTextFormat():void {
			textField.text = "";

			var index:int = 0;
			for each ( var chunk:TextChunk in _content ) {
				appendStyledText( chunk, index );
				index += chunk.text.length;
			}
		}

		private function appendStyledText( chunk:TextChunk, index:int ):void {
			textField.appendText( chunk.text );
			var textFormat:TextFormat = getTextFormatForChunk( chunk );
			if( chunkHasText( chunk ) ) {
				applyTextFormatToChunkText( textFormat, index, chunk );
			} else {
				applyTextFormatToTextField( textFormat );
			}
		}

		private function getTextFormatForChunk( chunk:TextChunk ):TextFormat {
			var tf:TextFormat = styleSheet.transform( getStyleForChunk( chunk ) );
			tf.bold = tf.bold == true;
			tf.underline = tf.underline == true;
			tf.italic = tf.italic == true;
			return tf;
		}

		private function getStyleForChunk( chunk:TextChunk ):Object {
			return styleSheet.getStyle( chunk && chunk.clazz ? chunk.clazz : "multiple" );
		}

		private function chunkHasText( chunk:TextChunk ):Boolean {
			return chunk.text.length>0;
		}

		private function applyTextFormatToChunkText( tf:TextFormat, index:int, chunk:TextChunk ):void {
			textField.setTextFormat( tf, index, index+chunk.text.length );
		}

		private function applyTextFormatToTextField( textFormat:TextFormat ):void {
			textField.setTextFormat( textFormat );
			textField.defaultTextFormat = textFormat;
		}

		private function applyStyleToSelection( className:String ):void {
			if( className != null ) {
				insertIntoSelection( textField.selectedText,
									 textField.selectionBeginIndex,
									 textField.selectionEndIndex,
									 className );
			}
		}

		public function deleteSelection( start:int, stop:int ):void {
			textField.setSelection( start, stop );
			insertIntoSelection( "", start, stop );
		}

		public function insert( str:String ):void {
			insertIntoSelection( str, textField.selectionBeginIndex, textField.selectionEndIndex );
		}

		public function insertIntoSelection( insertText:String, selectionStart:int, selectionEnd:int, style:String = null ):void {
			var textInserter:TextInserter = new TextInserter( _content );
			var newContent:Array = textInserter.insert( insertText, selectionStart, selectionEnd, style );
			var reducer:ContentReducer = new ContentReducer();
			_content = reducer.reduce( newContent );

			applyStylesAsTextFormat();

			updateTextField( textInserter.endIndex, textInserter.endIndex );
			textInserter.clear();
			reducer.clear();
		}

		private function onKeyDown( ev:KeyboardEvent ):void {
			switch( ev.keyCode ) {
				case Keyboard.BACKSPACE:
					ev.preventDefault();
					executeBackspace();
					break;
				case Keyboard.DELETE:
					ev.preventDefault();
					executeDelete();
					break;
				case 67:
					// c
					if( ev.ctrlKey ) {
						ev.preventDefault();
						executeCopy();
					}
					break;
			}
		}

		private function executeBackspace():void {
			if( textField.selectionEndIndex>0 ) {
				if( textField.selectionBeginIndex == textField.selectionEndIndex ) {
					textField.setSelection( textField.selectionBeginIndex-1, textField.selectionBeginIndex );
				}
				setTimeout( deleteSelection, 1, textField.selectionBeginIndex, textField.selectionEndIndex );
			}
		}

		private function executeDelete():void {
			if( textField.selectionBeginIndex != textField.text.length ) {
				if( textField.selectionBeginIndex == textField.selectionEndIndex ) {
					textField.setSelection( textField.selectionBeginIndex, textField.selectionBeginIndex+1 );
				}
				setTimeout( deleteSelection, 1, textField.selectionBeginIndex, textField.selectionEndIndex );
			}
		}

		private function executeCopy():void {
			if( textField.selectionBeginIndex != textField.selectionEndIndex ) {
				var copyText:String = textField.text.substring( textField.selectionBeginIndex,
																textField.selectionEndIndex );
				System.setClipboard( copyText );
			}
		}

		private function onTextInput( ev:TextEvent ):void {
			ev.preventDefault();
			var ins:String = ev.text;
			insert( ins );
		}

		public function HtmlTextFormatter( textField:TextField ) {
			_textToHtmlConverter = new TextToHtmlConverter();
			_htmlToTextParser = new HtmlToTextParser();
			this.textField = textField;
			textField.type = TextFieldType.INPUT;
			textField.autoSize = TextFieldAutoSize.NONE;
			textField.multiline = textField.wordWrap = textField.alwaysShowSelection = true;

			textField.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			textField.addEventListener( TextEvent.TEXT_INPUT, onTextInput );

			_content = [];
		}

		public function get textField():TextField {
			return _textField;
		}

		public function set textField( value:TextField ):void {
			_textField = value;
		}

		public function get styleSheet():StyleSheet {
			return _styleSheet;
		}

		public function set styleSheet( styleSheet:StyleSheet ):void {
			_styleSheet = styleSheet;
		}

		public function get content():Array {
			return _content;
		}

		public function set content( content:Array ):void {
			_content = content;
		}

		public function get format():String {
			return _format;
		}

		public function set format( f:String ):void {
			_format = f;
			if( textField.selectionBeginIndex<textField.text.length && textField.selectionEndIndex != textField.selectionBeginIndex ) {
				applyStyleToSelection( f );
			}
		}
	}
}




