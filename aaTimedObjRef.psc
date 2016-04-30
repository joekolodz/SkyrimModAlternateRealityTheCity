Scriptname aaTimedObjRef extends ObjectReference  
;/++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ This script can time ObjectReferences so the occur at certain hours of
+ the day or at a certain day. Override the ObjectActive and 
+ ObjectInactive functions into order modify the ObjectReference when
+ the time period occurs.
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
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++/;
 
;Int Property fDayOfWeek Auto ; Desired day day/1.0 Morndas for example.
Float Property fHourToActive Auto ; Desired enable time/10.0 for example's sake
Float Property fHourToInactive Auto ; Desired disable time/11.0 for example's sake
Float Property fUpdateInterval Auto ; Desired Update check time/5.0 for example's sake
GlobalVariable Property GameHour Auto ; The Games Hour leave default.
 
; Object gets Toggled.
Function ObjectToggle()
EndFunction
 
; Override Function - Object becomes Active due to time.
Function ObjectActive()
EndFunction
 
; Override Function - Object becomes Inactive due to time. 
Function ObjectInactive()
EndFunction
 
 
State Active 
	Event OnBeginState()
		Debug.Notification("State=Active")
		ObjectActive()
	EndEvent
	
	Function ObjectToggle()
		Debug.Notification("Toggle Door Lock Active")
		If (Self.isDisabled())
			return
		EndIf
 
		Float fTime = GameHour.GetValue()
		If (fHourToInactive < fHourToActive)
			; Fix to take into account times over the 24-hour period.
			If (fTime > fHourToInactive && fTime < fHourToActive) 
				Debug.Notification("ObjectToggle - going to Inactive")
				GoToState("Inactive")
			EndIf
		Else
			If (fTime < fHourToActive || fTime > fHourToInactive)
				Debug.Notification("ObjectToggle - going to Inactive")
				GoToState("Inactive")
			EndIf
		EndIf
	EndFunction	
EndState
 
Auto State Inactive
	Event OnBeginState()
		Debug.Notification("State=Inactive")
		ObjectInactive()
	EndEvent
 
	Function ObjectToggle()
		Debug.Notification("Toggle Door Lock Inactive")
		If (Self.isDisabled())
			return
		EndIf
 
		;If (fDayOfWeek && fDayOfWeek != GetDayOfWeek())
		;	return
		;EndIf
 
		Float fTime = GameHour.GetValue()
		If (fHourToInactive < fHourToActive)
			; Fix to take into account times over the 24-hour period.
			If (fTime <= fHourToInactive || fTime >= fHourToActive) 
				Debug.Notification("ObjectToggle - going to Active")
				GoToState("Active")
			EndIf
		Else
			If (fTime >= fHourToActive && fTime <= fHourToInactive)
				Debug.Notification("ObjectToggle - going to Active")
				GoToState("Active")
			EndIf
		EndIf
	EndFunction
EndState
 
Event OnUpdate()
	;Debug.Notification("TimedObjRef.OnUpdate")
	;RegisterForSingleUpdate(fUpdateInterval)
	;ObjectToggle()
EndEvent
 
Event OnInit()
	;Debug.Notification("TimedObjRef.OnInit")
	;GoToState("Inactive")
	;RegisterForSingleLOSGain(Game.GetPlayer(), Self)
	;ObjectToggle()
EndEvent
 
Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
	;Debug.Notification("OnGainLOS")
	;RegisterForSingleLOSLost(Game.GetPlayer(), Self)
	;RegisterForSingleUpdate(fUpdateInterval)
	;ObjectToggle()
EndEvent
 
Event OnLostLOS(Actor akViewer, ObjectReference akTarget)
	;Debug.Notification("OnLostLOS")
	;RegisterForSingleLOSGain(Game.GetPlayer(), Self)
	;UnregisterForUpdate() ; Stop polling
EndEvent
 
; Get the day of the week.
Int Function GetDayOfWeek()
	return ((Utility.GetCurrentGameTime() as Int) % 7) as Int	
EndFunction