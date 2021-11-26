;-----------------------------------------------------------------------------------------------------
; AutoHotKey in Davinci Resolve for color grading
; Date created: 2021. 03. 15
; Date of last edit: 2021. 03. 15
; Version: 1.3
; Log: 
;		1.Improving code efficiency using "switch" instead of "else if".
;
;                                                            ----by Peter Xu
;-----------------------------------------------------------------------------------------------------



#IfWinActive ahk_class Qt5QWindowIcon
toggle := 1							;1-LGG, 2-Log, 3-HDR
knob_toggle1LGG := 0				;the number of textbars in LGG mode
knob_toggle1Log := 0				;the number of textbars in Log mode
knob_toggle1HDR := 0				;the number of textbars in HDR mode


;recognizing current state
Loop												;check current mode every 200ms(LGG/Log/HDR)
{
	ImageSearch, , , 600, 720, 695, 760, %A_WorkingDir%\..\Image\LGG.png
	if (ErrorLevel = 0){
		toggle = 1
		;MsgBox %toggle%
	}
	else{
		ImageSearch, , , 600, 720, 695, 760, %A_WorkingDir%\..\Image\LogWheel.png
		if (ErrorLevel = 0){
			toggle = 2
			;MsgBox %toggle%
		}
		else{
			ImageSearch, , , 0, 725, 151, 762, %A_WorkingDir%\..\Image\HDRWheel.png
			if (ErrorLevel = 0){
				toggle = 3
				;MsgBox %toggle%
			}
			else 
				toggle = 0
		}
	}
	Sleep 200
}

;Reset Value
!+F3::
MouseMove, -40, 0, 0, R				;move the mouse left for 40 pixels and double click
MouseClick, left,,, 2
MouseMove, 40, 0, 0, R
MouseClick, left,,, 2
return



;Reset Wheel
;�ж����ĸ�ɫ�������ڣ����������Ӧ��������ü�


!+F4::									;check which wheel area the mouse is in,
MouseGetPos, xpos, ypos					;then double click the reset switch in the corresbonding area
if (xpos > 10) and (xpos < 186) and (ypos > 796) and (ypos < 1001){
	MouseMove, 165, 812, 0
	Sleep 500
	MouseClick, left
	return
}
else if (xpos > 191) and (xpos < 366) and (ypos > 803) and (ypos < 997){
	MouseMove, 343, 812, 0
	Sleep 500
	MouseClick, left
	return
	}
else if (xpos > 369) and (xpos < 544) and (ypos > 798) and (ypos < 997){
	MouseMove, 521, 812, 0
	Sleep 500
	MouseClick, left
	return
	}
else if (xpos > 548) and (xpos < 722) and (ypos > 802) and (ypos < 999){
	MouseMove, 699, 813, 0
	Sleep 500
	MouseClick, left
	return
	}
return






;Knob Turning_Default State
;first knob, Lift
F12::
MouseClickDrag, L, 99, 982, 97, 982, 0
return
F14::
MouseClickDrag, L, 99, 982, 101, 982, 0
return
;second knob, Gamma, toggle between HDR wheels when in HDR mode
F15::
if (toggle = 3){
	MouseClick, left, 293, 775,, 0	;click the arrow above the HDR wheel
	;MsgBox yes
	return
}
else{
	MouseClickDrag, L, 277, 982, 275, 982, 0
	return
}
return
F17::
if (toggle = 3){
	MouseClick, left, 443, 775,, 0
	;MsgBox yes
	return
}
else{
	MouseClickDrag, L, 277, 982, 279, 982, 0
	return
}
return
;third knob, Gain
F18::
MouseClickDrag, L, 455, 982, 453, 982, 0
return
F20::
MouseClickDrag, L, 455, 982, 457, 982, 0
return
;fourth knob, Offset
F21::
MouseClickDrag, L, 633, 982, 631, 982, 0
return
F23::
MouseClickDrag, L, 633, 982, 635, 982, 0
return


;Knob Turning State(hold down ctrl)

;first knob, swich between textbar
;move to certain textbar and double click, loop between 0-knob_toggleXXX
^F12::                                  ;first knob left
switch toggle
{
	Case 1:                         ;in LGG mode, 11 textbars
		knob_toggle1LGG--
		Switch knob_toggle1LGG
		{
			Case 1:
				MouseClick, left, 183, 776, 2, 0
				knob_toggle1LGG := 12
				return
			Case 2:
				MouseClick, left, 308, 776, 2, 0
				return
			Case 3:
				MouseClick, left, 429, 776, 2, 0
				return
			Case 4:
				MouseClick, left, 555, 776, 2, 0
				return
			Case 5:
				MouseClick, left, 679, 776, 2, 0
				return
			Case 6:
				MouseClick, left, 101, 1019, 2, 0
				return
			Case 7:
				MouseClick, left, 218, 1019, 2, 0
				return
			Case 8:
				MouseClick, left, 332, 1019, 2, 0
				return
			Case 9:
				MouseClick, left, 447, 1019, 2, 0
				return
			Case 10:
				MouseClick, left, 562, 1019, 2, 0
				return
			Case 11:
				MouseClick, left, 680, 1019, 2, 0
				return
			default:
				knob_toggle1LGG := 0
				return
		}
		return
	Case 2:                        ;in Log mode, 12 text bars
		knob_toggle1Log--
		switch knob_toggle1Log
		{
			Case 1:
				MouseClick, left, 160, 776, 2, 0
				knob_toggle1Log := 13
			return
			Case 2:
				MouseClick, left, 267, 776, 2, 0
				return
			Case 3:
				MouseClick, left, 369, 776, 2, 0
				return
			Case 4:
				MouseClick, left, 473, 776, 2, 0
				return
			Case 5:
				MouseClick, left, 577, 776, 2, 0
				return
			Case 6:
				MouseClick, left, 680, 776, 2, 0
				return
			Case 7:
				MouseClick, left, 97, 1019, 2, 0
				return
			Case 8:
				MouseClick, left, 218, 1019, 2, 0
				return
			Case 9:
				MouseClick, left, 331, 1019, 2, 0
				return
			Case 10:
				MouseClick, left, 447, 1019, 2, 0
				return
			Case 11:
				MouseClick, left, 562, 1019, 2, 0
				return
			Case 12:
				MouseClick, left, 680, 1019, 2, 0
				return
			Default:
				knob_toggle1Log := 0
				return
		}
		return
	Case 3:                     ;in HDR mode, 7 textbars
		knob_toggle1HDR--
		switch knob_toggle1HDR
		{
			Case 1:
				MouseClick, left, 76, 1020, 2, 0
				knob_toggle1HDR := 8
				return
			Case 2:
				MouseClick, left, 177, 1020, 2, 0
				return
			Case 3:
				MouseClick, left, 279, 1020, 2, 0
				return
			Case 4:
				MouseClick, left, 380, 1020, 2, 0
				return
			Case 5:
				MouseClick, left, 480, 1020, 2, 0
				return
			Case 6:
				MouseClick, left, 580, 1020, 2, 0
				return
			Case 7:
				MouseClick, left, 682, 1020, 2, 0
				return
			Default:
				knob_toggle1HDR := 0
				return
		}
		return
	Default:
		return
}
return

^F14::									;first knob right
if (toggle = 1){						;in LGG mode, 11 textbars
	knob_toggle1LGG++
	if (knob_toggle1LGG = 1){
		MouseClick, left, 183, 776, 2, 0
	}
	else if (knob_toggle1LGG = 2){
		MouseClick, left, 308, 776, 2, 0
	}
	else if (knob_toggle1LGG = 3){
		MouseClick, left, 429, 776, 2, 0
	}
	else if (knob_toggle1LGG = 4){
		MouseClick, left, 555, 776, 2, 0
	}
	else if (knob_toggle1LGG = 5){
		MouseClick, left, 679, 776, 2, 0
	}
	else if (knob_toggle1LGG = 6){
		MouseClick, left, 101, 1019, 2, 0
	}
	else if (knob_toggle1LGG = 7){
		MouseClick, left, 218, 1019, 2, 0
	}
	else if (knob_toggle1LGG = 8){
		MouseClick, left, 332, 1019, 2, 0
	}
	else if (knob_toggle1LGG = 9){
		MouseClick, left, 447, 1019, 2, 0
	}
	else if (knob_toggle1LGG = 10){
		MouseClick, left, 562, 1019, 2, 0
	}
	else if (knob_toggle1LGG = 11){
		MouseClick, left, 680, 1019, 2, 0
		knob_toggle1LGG := 0
	}
	else 
		knob_toggle1LGG := 0
}
else if (toggle = 2){						;in Log mode, 12 text bars
	knob_toggle1Log++
	if (knob_toggle1Log = 1){
		MouseClick, left, 160, 776, 2, 0
	}
	else if (knob_toggle1Log = 2){
		MouseClick, left, 267, 776, 2, 0
	}
	else if (knob_toggle1Log = 3){
		MouseClick, left, 369, 776, 2, 0
	}
	else if (knob_toggle1Log = 4){
		MouseClick, left, 473, 776, 2, 0
	}
	else if (knob_toggle1Log = 5){
		MouseClick, left, 577, 776, 2, 0
	}
	else if (knob_toggle1Log = 6){
		MouseClick, left, 680, 776, 2, 0
	}
	else if (knob_toggle1Log = 7){
		MouseClick, left, 97, 1019, 2, 0
	}
	else if (knob_toggle1Log = 8){
		MouseClick, left, 218, 1019, 2, 0
	}
	else if (knob_toggle1Log = 9){
		MouseClick, left, 331, 1019, 2, 0
	}
	else if (knob_toggle1Log = 10){
		MouseClick, left, 447, 1019, 2, 0
	}
	else if (knob_toggle1Log = 11){
		MouseClick, left, 562, 1019, 2, 0
	}
	else if (knob_toggle1Log = 12){
		MouseClick, left, 680, 1019, 2, 0
		knob_toggle1Log := 0
	}
	else 
		knob_toggle1Log := 0
}
else if (toggle = 3){						;in HDR mode, 7 textbars
	knob_toggle1HDR++
	if (knob_toggle1HDR = 1){
		MouseClick, left, 76, 1020, 2, 0
	}
	else if (knob_toggle1HDR = 2){
		MouseClick, left, 177, 1020, 2, 0
	}
	else if (knob_toggle1HDR = 3){
		MouseClick, left, 279, 1020, 2, 0
	}
	else if (knob_toggle1HDR = 4){
		MouseClick, left, 380, 1020, 2, 0
	}
	else if (knob_toggle1HDR = 5){
		MouseClick, left, 480, 1020, 2, 0
	}
	else if (knob_toggle1HDR = 6){
		MouseClick, left, 580, 1020, 2, 0
	}
	else if (knob_toggle1HDR = 7){
		MouseClick, left, 682, 1020, 2, 0
	knob_toggle1HDR := 0
	}
	else 
		knob_toggle1HDR := 0
}
else return
return



;second knob, move the cursor left and right
^F15::								;second knob left
if (toggle = 3){
	Send {Left}						
}
else return
return

^F17::								;second knob right
if (toggle = 3){
	Send {Right}					
}
else return
return

;third knob,toggle between 8 textbars in HDR mode(Exp,Sat)
^F18::									;third knob left
if (toggle = 3){
	knob_toggle3HDR--
	if (knob_toggle3HDR = 1){
		MouseClick, left, 77, 945, 2, 0
		knob_toggle3HDR := 9
	}
	else if (knob_toggle3HDR = 2){
		MouseClick, left, 162, 945, 2, 0
	}
	else if (knob_toggle3HDR = 3){
		MouseClick, left, 256, 945, 2, 0
	}
	else if (knob_toggle3HDR = 4){
		MouseClick, left, 340, 945, 2, 0
	}
	else if (knob_toggle3HDR = 5){
		MouseClick, left, 434, 945, 2, 0
	}
	else if (knob_toggle3HDR = 6){
		MouseClick, left, 515, 945, 2, 0
	}
	else if (knob_toggle3HDR = 7){
		MouseClick, left, 612, 945, 2, 0
	}
	else if (knob_toggle3HDR = 8){
		MouseClick, left, 696, 945, 2, 0
	}
	else 
		knob_toggle3HDR := 0
}
else return
return

^F20::									;third knob right
if (toggle = 3){
	knob_toggle3HDR++
	if (knob_toggle3HDR = 1){
		MouseClick, left, 77, 945, 2, 0
	}
	else if (knob_toggle3HDR = 2){
		MouseClick, left, 162, 945, 2, 0
	}
	else if (knob_toggle3HDR = 3){
		MouseClick, left, 256, 945, 2, 0
	}
	else if (knob_toggle3HDR = 4){
		MouseClick, left, 340, 945, 2, 0
	}
	else if (knob_toggle3HDR = 5){
		MouseClick, left, 434, 945, 2, 0
	}
	else if (knob_toggle3HDR = 6){
		MouseClick, left, 515, 945, 2, 0
	}
	else if (knob_toggle3HDR = 7){
		MouseClick, left, 612, 945, 2, 0
	}
	else if (knob_toggle3HDR = 8){
		MouseClick, left, 696, 945, 2, 0
		knob_toggle3HDR := 0
	}
	else 
		knob_toggle3HDR := 0
}
return


;fourth knob, adjust the value up/down
^F21::
Send {Down}
return

^F23::
Send {Up}
return




;Knob Pressed
F13::								;first knob, temp, in LGG/Log/HDR modes
if (toggle = 1){
	MouseClick, left, 183, 776, 2, 0
	Send {Left}
	Send {Left}
	return
}
else if (toggle = 2){
	MouseClick, left, 160, 776, 2, 0
	Send {Left}
	Send {Left}
	return
}
else if (toggle = 3){
	MouseClick, left, 76, 1020, 2, 0
	Send {Left}
	Send {Left}
	return
}
else return
return


F16::								;second knob, tint, in LGG/Log/HDR modes
if (toggle = 1){
	MouseClick, left, 308, 776, 2, 0
	return
}
else if (toggle = 2){
	MouseClick, left, 267, 776, 2, 0
	return
}
else if (toggle = 3){
	MouseClick, left, 177, 1020, 2, 0
	return
}
else return
return


F19::								;third knob, contrast, LGG/Log/HDR modes
if (toggle = 1){
	MouseClick, left, 429, 776, 2, 0
	Send {Left}
	return
}
else if (toggle = 2){
	MouseClick, left, 369, 776, 2, 0
	Send {Left}
	return
}
else if (toggle = 3){
	MouseClick, left, 380, 1020, 2, 0
	Send {Left}
	return
}
else return
return


F22::								;fourth knob, pivot, in LGG/Log/HDR modes
if (toggle = 1){
	MouseClick, left, 555, 776, 2, 0
	Send {Left}
	return
}
else if (toggle = 2){
	MouseClick, left, 473, 776, 2, 0
	Send {Left}
	return
}
else if (toggle = 3){
	MouseClick, left, 480, 1020, 2, 0
	Send {Left}
	return
}
else return
return



;Knob Pressed with shift			;first knob, Mid/Detail in LGG mode
+F13::
if (toggle = 1){
	MouseClick, left, 679, 776, 2, 0
	return
}
else return
+F16::								;second knob, Hue in LGG mode
if (toggle = 1){
	MouseClick, left, 562, 1019, 2, 0
	return
}
else return
+F19::								;third knob, Col Boost in LGG mode
if (toggle = 1){
	MouseClick, left, 101, 1019, 2, 0
	return
}
else return
+F22::								;fourth knob, Sat in LGG mode
if (toggle = 1){
	MouseClick, left, 447, 1019, 2, 0
	return
}
else return
return






;swtich between LGG/Log/HDR, loop between three states

;switch to next state
!+F5::
toggle++
if (toggle = 1){
	MouseClick, left, 156, 714,, 0
	MouseClick, left, 325, 745,, 0
	return
	
}
else if (toggle = 2) {
	MouseClick, left, 363, 745,, 0
	return
}
else if (toggle = 3) {
	MouseClick, left, 213, 714,, 0
	return
}
else {
	MouseClick, left, 156, 714,, 0
	MouseClick, left, 325, 745,, 0
	return
}
return











































