;/++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ This script can time ObjectReferences so the occur at certain hours of
+ the day or at a certain day. Override the ObjectActive and 
+ ObjectInactive functions into order modify the ObjectReference when
+ the time period occurs.
+ 
+ Version: 1.0d
+ Author: L4NG3RZ
+ Email: jdoe090910@gmail.com
+ Last Modified: 20/06/2015
+ 
+   Hours Conversion:
+		9.0 for 9:00
+		11.5 for 11:30
+		10.25 for 10:15
+		23.0 for 23:00
+
+	Days of Week conversion:
+		0 - Sundas (Sunday)
+		1 - Morndas
+		2 - Tirdas
+		3 - Middas
+		4 - Turdas
+		5 - Fredas
+		6 - Loredas (Saturday)
+
+ TODO - Times that are reversed ex 9pm-11pm (2 hours), 11pm-9pm (22 Hours) does not work.
+
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/;

ScriptName aaTimedObjRef2 extends ObjectReference

import Utility

Bool Property bUseDay Auto; Use Day Of Week?
Int Property fDayOfWeek Auto ; Desired day day/1 Morndas.
Float Property fHourToActive Auto ; Desired enable time/10.0 for example's sake
Float Property fHourToInactive Auto ; Desired disable time/11.0 for example's sake
GlobalVariable Property GameHour Auto ; The Games Hour leave default.

; Object gets Toggled.
Function ObjectToggle()
EndFunction

; Override Function - Object becomes Active due to time.
Function ObjectActive()
	Debug.Notification("TimedObjRef(state:Active,func:ObjectActive)")
EndFunction

; Override Function - Object becomes Inactive due to time. 
Function ObjectInactive()
	Debug.Notification("TimedObjRef(state:Inactive,func:ObjectInactive)")
EndFunction 

State Active 
	Event OnBeginState()
        Debug.Notification("TimedObjRef(state:Active,func:OnBeginState)")
        If(Self.isDisabled() || (bUseDay && !IsDayOfWeek()))
            Debug.Notification("TimedObjRef(state:Active,func:OnBeginState,msg:NOT DAY OF WEEK!)")
            ObjectToggle()
            return
        EndIf

		ObjectActive()
		ObjectToggle()
	EndEvent
	
	Function ObjectToggle()
		Debug.Notification("TimedObjRef(state:Active,func:ObjectToggle)")

		Float fTime = GameHour.GetValue()
		float waitTime
		if (fTime <= fHourToInactive)
			waitTime = (fHourToInactive-fTime)
            Debug.Notification("TimedObjRef(state:Active,waitTime,(fHourToInactive:"+fHourToInactive+"-fTime:"+fTime+"))")
		else
			waitTime = 24-(fTime-fHourToInactive)
            Debug.Notification("TimedObjRef(state:Active,waitTime,(24-fTime:"+fTime+"-fHourToInactive:"+fHourToInactive+"))")
		endif
		if (waitTime)
			Debug.Notification("TimedObjRef(state:Active,func:ObjectToggle,ftime:"+fTime+",waitTime:"+waitTime+")")
			WaitGameTime(waitTime+0.017) ; Add 1 second to avoid border value bouncing.
			GoToState("Inactive")
		endif
	EndFunction	
EndState

Auto State Inactive
	Event OnBeginState()
        Debug.Notification("TimedObjRef(state:Inactive,func:OnBeginState)")

		ObjectInactive()
		ObjectToggle()
	EndEvent

	Function ObjectToggle()
		Debug.Notification("TimedObjRef(state:Inactive,func:ObjectToggle)")

		Float fTime = GameHour.GetValue()
		float waitTime
		if (fTime <= fHourToActive)
			waitTime = (fHourToActive-fTime)
            Debug.Notification("TimedObjRef(state:Inactive,waitTime,(fHourToActive:"+fHourToActive+"-fTime:"+fTime+"))")
		else
			waitTime = 24-(fTime-fHourToActive)
            Debug.Notification("TimedObjRef(state:Inactive,waitTime,(24-fTime:"+fTime+"-fHourToActive:"+fHourToActive+"))")
		endif
		if (waitTime)
			Debug.Notification("TimedObjRef(state:Inactive,func:ObjectToggle,ftime:"+fTime+",waitTime:"+waitTime+")")
			WaitGameTime(waitTime+0.017) ; Add 1 second to avoid border value bouncing.
			GoToState("Active")
		endif
	EndFunction
EndState

Event OnInit()
	Debug.Notification("TimedObjRef(func:OnInit)")

    ; TODO - Reversing the values does not work currently
    Float fTime = GameHour.GetValue()

    Debug.Notification("TimedObjRef(func:OnInit,Var:fHourToActive="+fHourToActive+",fHourToInactive="+fHourToInactive+",fTime="+fTime+")")
    If (fTime > fHourToActive && fTime < fHourToInactive)
        Debug.Notification("TimedObjRef(func:OnInit,State:Active!)")
        GoToState("Active")
    ElseIf ((fHourToInactive < fHourToActive) && ((fTime > fHourToActive) && (fTime < 24)) || ((0 > fTime) && (fTime < fHourToInactive)))
        Debug.Notification("TimedObjRef(func:OnInit,State:Active(2)!)")
        GoToState("Active")
    Else
        Debug.Notification("TimedObjRef(func:OnInit,State:Inactive)")
        GoToState("Inactive")
    EndIf

	ObjectToggle()
EndEvent

; Get the day of the week.
Int Function GetDayOfWeek()
	return ((Utility.GetCurrentGameTime() as Int) % 7) as Int	
EndFunction

; Is the day of the week.
; return true when day of week, false if not.
Bool Function IsDayOfWeek()
    Debug.Notification("TimedObjRef(func:IsDayOfWeek,var:fDayOfWeek="+fDayOfWeek+",GetDayOfWeek()="+GetDayOfWeek()+")")
    If (fDayOfWeek >= 0 && fDayOfWeek != GetDayOfWeek())
        ;waitGameTime(fDayOfWeek - GetDayOfWeek()  * 24)
		return false
	EndIf
    return true
EndFunction