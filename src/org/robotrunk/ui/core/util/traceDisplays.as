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

package org.robotrunk.ui.core.util {
	import flash.display.Stage;

	public function traceDisplays( obj:* ):void {
		var clip:* = obj;
		while( clip != null && !(clip is Stage) ) {
			trace( clip.name+":"+clip+":"+clip.visible+":"+clip.alpha+":("+clip.x+","+clip.y+"):("+clip.width+","+clip.height+")" );
			clip = clip.parent;
		}
	}
}
