package ;
import cx.KeyboardTools;
import inkora.com.core.TweenEngine;
import inkora.com.easing.Back;
import inkora.com.easing.Bounce;
import inkora.com.easing.Elastic;
import inkora.com.easing.Exponential;
import inkora.com.easing.Linear;
import inkora.com.tween.TweenCube;
import inkora.com.tween.TweenCubeTimeline;
import nme.display.Shape;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.Lib;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
		
		
		example();
		
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
	
	static public function example() {
		
		var tl = new TweenCubeTimeline();
		
		Lib.stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e) {
			var keyCode = KeyboardTools.getKeyCode(e);
			trace(keyCode);			
			switch(keyCode) {
				case 65: tl.pauseTimeline();
				case 83: tl.resumeTimeline();
				case 68: tl.restartTimeline();
				case 70: tl.gotoAndPlay(0);
				case 71: tl.gotoAndStop(1);
				case 72: tl.gotoAndPlay(4);
			}
		});
		
		var s:Sprite = new Sprite();
		s.graphics.beginFill(0xFF0000);
		s.graphics.drawRect(0, 0, 30, 30);		
		s.x = 0;
		s.y = 0;
		Lib.current.addChild(s);
		
		var s2:Sprite = new Sprite();
		s2.graphics.beginFill(0x0000FF);
		s2.graphics.drawRect(0, 0, 30, 30);
		s2.x = 200;
		s2.y = 0;		
		Lib.current.addChild(s2);			
		
		tl.addTween(0, TweenCube.to(s, 3, { x:200, y:0 }, { reverse:false,  ease:Exponential.easeInOut} ));
		tl.addTween(1, TweenCube.to(s2, 4, { x:0, y:0 }, { reverse:false, ease:Bounce.easeOut } ));
		tl.onComplete = function(params) {
			trace('timeline complete!');
			trace(params);
		}
		
		tl.play();		
	
		/*
		TweenCube.timedCall(1, function(p) { 
			trace('-- timed call after 1 sec'); 
			trace(p);
		} );
				
		TweenCube.timedCall(3, function(p) { 
			trace('-- timed call after 3 secs'); 
			trace(p);
		} );
		*/
		
		
		
	}			
	
	
}
