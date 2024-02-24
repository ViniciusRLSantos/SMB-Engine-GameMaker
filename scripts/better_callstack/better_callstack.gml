///@function better_callstack()
function better_callstack() {

	var _debug_stack = debug_get_callstack();

	var _better_stack = [];

	for (var _s = 1; _s < array_length_1d(_debug_stack); _s++) {
	
		if (_debug_stack[_s] == 0) { continue; }
	
		var _colon_pos = string_pos(":",_debug_stack[_s]);
		var _call_place = string_copy(_debug_stack[_s],0,_colon_pos-1);
		var _call_line = string_copy(_debug_stack[_s],_colon_pos+1,5);

		if (string_pos("Object",_call_place) != 0) {
		
			_call_place = string_replace(_call_place,"gml_Object_","object: '");
	
			//Rename Events

			//Keys
			if (string_pos("Key",_call_place) != 0) {
				var _keycode = 0;
	
				var _kdown_pos = string_pos("Keyboard",_call_place);
				var _kpress_pos = string_pos("KeyPress",_call_place);
				var _krelease_pos = string_pos("KeyRelease",_call_place);
	
				if (_kdown_pos != 0) { //Key Down
					_keycode = string_copy(_call_place,_kdown_pos+9,3);
					_call_place = string_copy(_call_place,0,_kdown_pos-2);
					_call_place += "' -> Key Down: '";
				}
				else if (_kpress_pos != 0) { //Key Pressed
					_keycode = string_copy(_call_place,_kpress_pos+9,3);
					_call_place = string_copy(_call_place,0,_kpress_pos-2);
					_call_place += "' -> Key Pressed: '";
				}
				else { //Key Release
					_keycode = string_copy(_call_place,_krelease_pos+11,3);
					_call_place = string_copy(_call_place,0,_krelease_pos-2);
					_call_place += "' -> Key Up: '";
				}
	
				_call_place += key_to_string(real(_keycode)) + "'";
	
			}
			//Alarms
			else if (string_pos("Alarm",_call_place) != 0) {
				var _alarmpos = string_pos("Alarm",_call_place);
				var _alarmnum = string_copy(_call_place,_alarmpos+6,2);
		
				_call_place = string_copy(_call_place,0,_alarmpos-2);
				_call_place += "' -> Alarm " + _alarmnum;
			}
			//Mouse
			else if (string_pos("Mouse",_call_place) != 0) {
				_call_place = string_replace(_call_place,"_Mouse_0","' -> Mouse Left Down");
				_call_place = string_replace(_call_place,"_Mouse_1","' -> Mouse Right Down");
				_call_place = string_replace(_call_place,"_Mouse_2","' -> Mouse Middle Down");
				_call_place = string_replace(_call_place,"_Mouse_3","' -> No Mouse Input");
				_call_place = string_replace(_call_place,"_Mouse_4","' -> Mouse Left Pressed");
				_call_place = string_replace(_call_place,"_Mouse_5","' -> Mouse Right Pressed");
				_call_place = string_replace(_call_place,"_Mouse_6","' -> Mouse Middle Pressed");
				_call_place = string_replace(_call_place,"_Mouse_7","' -> Mouse Left Released");
				_call_place = string_replace(_call_place,"_Mouse_8","' -> Mouse Right Released");
				_call_place = string_replace(_call_place,"_Mouse_9","' -> Mouse Middle Released");
				_call_place = string_replace(_call_place,"_Mouse_10","' -> Mouse Enter");
				_call_place = string_replace(_call_place,"_Mouse_11","' -> Mouse Leave");
				_call_place = string_replace(_call_place,"_Mouse_60","' -> Mouse Wheel Up");
				_call_place = string_replace(_call_place,"_Mouse_61","' -> Mouse Wheel Down");
			
				_call_place = string_replace(_call_place,"_Mouse_50","' -> Global Mouse Left Down");
				_call_place = string_replace(_call_place,"_Mouse_51","' -> Global Mouse Right Down");
				_call_place = string_replace(_call_place,"_Mouse_52","' -> Global Mouse Middle Down");
				_call_place = string_replace(_call_place,"_Mouse_53","' -> Global Mouse Left Pressed");
				_call_place = string_replace(_call_place,"_Mouse_54","' -> Global Mouse Right Pressed");
				_call_place = string_replace(_call_place,"_Mouse_55","' -> Global Mouse Middle Pressed");
				_call_place = string_replace(_call_place,"_Mouse_56","' -> Global Mouse Left Released");
				_call_place = string_replace(_call_place,"_Mouse_57","' -> Global Mouse Right Released");
				_call_place = string_replace(_call_place,"_Mouse_58","' -> Global Mouse Middle Released");
			}
			//Other / User Events / Async
			else if (string_pos("Other",_call_place) != 0) {
				_call_place = string_replace(_call_place,"_Other_0","' -> Outside Room");
				_call_place = string_replace(_call_place,"_Other_1","' -> Intersect Boundary");
			
				_call_place = string_replace(_call_place,"_Other_2","' -> Game Start");
				_call_place = string_replace(_call_place,"_Other_3","' -> Game End");
			
				_call_place = string_replace(_call_place,"_Other_4","' -> Room Start");
				_call_place = string_replace(_call_place,"_Other_5","' -> Room End");
			
				_call_place = string_replace(_call_place,"_Other_7","' -> Animation End");
				_call_place = string_replace(_call_place,"_Other_58","' -> Animation Update");
				_call_place = string_replace(_call_place,"_Other_59","' -> Animation Event");
			
				_call_place = string_replace(_call_place,"_Other_8","' -> Path Ended");
			
				_call_place = string_replace(_call_place,"_Other_10","' -> User Event 0");
				_call_place = string_replace(_call_place,"_Other_11","' -> User Event 1");
				_call_place = string_replace(_call_place,"_Other_12","' -> User Event 2");
				_call_place = string_replace(_call_place,"_Other_13","' -> User Event 3");
				_call_place = string_replace(_call_place,"_Other_14","' -> User Event 4");
				_call_place = string_replace(_call_place,"_Other_15","' -> User Event 5");
				_call_place = string_replace(_call_place,"_Other_16","' -> User Event 6");
				_call_place = string_replace(_call_place,"_Other_17","' -> User Event 7");
				_call_place = string_replace(_call_place,"_Other_18","' -> User Event 8");
				_call_place = string_replace(_call_place,"_Other_19","' -> User Event 9");
				_call_place = string_replace(_call_place,"_Other_20","' -> User Event 10");
				_call_place = string_replace(_call_place,"_Other_21","' -> User Event 11");
				_call_place = string_replace(_call_place,"_Other_22","' -> User Event 12");
				_call_place = string_replace(_call_place,"_Other_23","' -> User Event 13");
				_call_place = string_replace(_call_place,"_Other_24","' -> User Event 14");
				_call_place = string_replace(_call_place,"_Other_25","' -> User Event 15");
			
				_call_place = string_replace(_call_place,"_Other_40","' -> Outside View 0");
				_call_place = string_replace(_call_place,"_Other_41","' -> Outside View 1");
				_call_place = string_replace(_call_place,"_Other_42","' -> Outside View 2");
				_call_place = string_replace(_call_place,"_Other_43","' -> Outside View 3");
				_call_place = string_replace(_call_place,"_Other_44","' -> Outside View 4");
				_call_place = string_replace(_call_place,"_Other_45","' -> Outside View 5");
				_call_place = string_replace(_call_place,"_Other_46","' -> Outside View 6");
				_call_place = string_replace(_call_place,"_Other_47","' -> Outside View 7");
			
				_call_place = string_replace(_call_place,"_Other_50","' -> Intersect View 0 Boundary");
				_call_place = string_replace(_call_place,"_Other_51","' -> Intersect View 1 Boundary");
				_call_place = string_replace(_call_place,"_Other_52","' -> Intersect View 2 Boundary");
				_call_place = string_replace(_call_place,"_Other_53","' -> Intersect View 3 Boundary");
				_call_place = string_replace(_call_place,"_Other_54","' -> Intersect View 4 Boundary");
				_call_place = string_replace(_call_place,"_Other_55","' -> Intersect View 5 Boundary");
				_call_place = string_replace(_call_place,"_Other_56","' -> Intersect View 6 Boundary");
				_call_place = string_replace(_call_place,"_Other_57","' -> Intersect View 7 Boundary");
			
				_call_place = string_replace(_call_place,"_Other_74","' -> Async Audio Playback");
				_call_place = string_replace(_call_place,"_Other_73","' -> Async Audio Recording");
				_call_place = string_replace(_call_place,"_Other_67","' -> Async Cloud");
				_call_place = string_replace(_call_place,"_Other_63","' -> Async Dialog");
				_call_place = string_replace(_call_place,"_Other_62","' -> Async HTTP");
				_call_place = string_replace(_call_place,"_Other_66","' -> Async In-App Purchase");
				_call_place = string_replace(_call_place,"_Other_60","' -> Async Image Loaded");
				_call_place = string_replace(_call_place,"_Other_68","' -> Async Networking");
				_call_place = string_replace(_call_place,"_Other_71","' -> Async Push Notification");
				_call_place = string_replace(_call_place,"_Other_72","' -> Async Save/Load");
				_call_place = string_replace(_call_place,"_Other_70","' -> Async Social");
				_call_place = string_replace(_call_place,"_Other_69","' -> Async Steam");
				_call_place = string_replace(_call_place,"_Other_75","' -> Async System");
			}
			//Gestures
			else if (string_pos("Gesture",_call_place) != 0) {
				_call_place = string_replace(_call_place,"_Gesture_0","' -> Tap");
				_call_place = string_replace(_call_place,"_Gesture_1","' -> Double Tap");
				_call_place = string_replace(_call_place,"_Gesture_2","' -> Drag Start");
				_call_place = string_replace(_call_place,"_Gesture_3","' -> Dragging");
				_call_place = string_replace(_call_place,"_Gesture_4","' -> Drag End");
				_call_place = string_replace(_call_place,"_Gesture_5","' -> Flick");
				_call_place = string_replace(_call_place,"_Gesture_6","' -> Pinch Start");
				_call_place = string_replace(_call_place,"_Gesture_7","' -> Pinch In");
				_call_place = string_replace(_call_place,"_Gesture_8","' -> Pinch Out");
				_call_place = string_replace(_call_place,"_Gesture_9","' -> Pinch End");
				_call_place = string_replace(_call_place,"_Gesture_10","' -> Rotate Start");
				_call_place = string_replace(_call_place,"_Gesture_11","' -> Rotating");
				_call_place = string_replace(_call_place,"_Gesture_12","' -> Rotate End");
			
				_call_place = string_replace(_call_place,"_Gesture_64","' -> Global Tap");
				_call_place = string_replace(_call_place,"_Gesture_65","' -> Global Double Tap");
				_call_place = string_replace(_call_place,"_Gesture_66","' -> Global Drag Start");
				_call_place = string_replace(_call_place,"_Gesture_67","' -> Global Dragging");
				_call_place = string_replace(_call_place,"_Gesture_68","' -> Global Drag End");
				_call_place = string_replace(_call_place,"_Gesture_69","' -> Global Flick");
				_call_place = string_replace(_call_place,"_Gesture_70","' -> Global Pinch Start");
				_call_place = string_replace(_call_place,"_Gesture_71","' -> Global Pinch In");
				_call_place = string_replace(_call_place,"_Gesture_72","' -> Global Pinch Out");
				_call_place = string_replace(_call_place,"_Gesture_73","' -> Global Pinch End");
				_call_place = string_replace(_call_place,"_Gesture_74","' -> Global Rotate Start");
				_call_place = string_replace(_call_place,"_Gesture_75","' -> Global Rotating");
				_call_place = string_replace(_call_place,"_Gesture_76","' -> Global Rotate End");
			}
			//Draw
			else if (string_pos("Draw",_call_place) != 0) {
				_call_place = string_replace(_call_place,"_Draw_0","' -> Draw");
				_call_place = string_replace(_call_place,"_Draw_72","' -> Draw Begin");
				_call_place = string_replace(_call_place,"_Draw_73","' -> Draw End");
			
				_call_place = string_replace(_call_place,"_Draw_64","' -> Draw GUI");
				_call_place = string_replace(_call_place,"_Draw_74","' -> Draw GUI Begin");
				_call_place = string_replace(_call_place,"_Draw_75","' -> Draw GUI End");
			
				_call_place = string_replace(_call_place,"_Draw_76","' -> Pre-Draw");
				_call_place = string_replace(_call_place,"_Draw_77","' -> Post-Draw");
			
				_call_place = string_replace(_call_place,"_Draw_65","' -> Window Resize");
			}
			//Rest of events
			else {
				_call_place = string_replace(_call_place,"_Create_0","' -> Create");
				_call_place = string_replace(_call_place,"_CleanUp_0","' -> Clean Up");
				_call_place = string_replace(_call_place,"_Destroy_0","' -> Destroy");
				_call_place = string_replace(_call_place,"_Collision_","' -> Collision:");
			
				_call_place = string_replace(_call_place,"_Step_0","' -> Step");
				_call_place = string_replace(_call_place,"_Step_1","' -> Step Begin");
				_call_place = string_replace(_call_place,"_Step_2","' -> Step End");
			}
		}
		else {
			_call_place = string_replace(_call_place,"gml_Script_","script: '") + "'";
		}
	
		_better_stack[_s-1] = _call_place + ", line: " + _call_line;
	}

	return _better_stack;


}
