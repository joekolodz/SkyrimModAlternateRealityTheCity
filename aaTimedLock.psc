;/++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ This script enables an ObjectReference like a door locked and unlocked
+ at specified times.
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

ScriptName aaTimedLock extends aaActivatedObjectReference

Int Property fDayOfWeek Auto ; Desired day day/1.0 Morndas for example.
Float Property fHourOpen Auto ; Desired open time/10.0 for example's sake
Float Property fHourClosed Auto ; Desired closed time/11.0 for example's sake
GlobalVariable Property GameHour Auto ; The Games Hour leave default.
;String Property sDoorOpen Auto ; Message when open.
;String Property sDoorClosed Auto ; Message when closed.


; Overrided Function.
Bool Function IsObjectActive()
		If (fDayOfWeek && fDayOfWeek != GetDayOfWeek())
			return false
		EndIf

		Float fTime = GameHour.GetValue()
		
		If (fHourClosed < fHourOpen)
			; Fix to take into account times over the 24-hour period.
			
			If (fTime <= fHourClosed || fTime >= fHourOpen) 
				return true
			EndIf
		Else
			
			If (fTime >= fHourOpen && fTime <= fHourClosed)
				return true
			EndIf
		EndIf
		return false
EndFunction

; Overrided Function.
Bool Function IsObjectInActive()
		Float fTime = GameHour.GetValue()
		If (fHourClosed < fHourOpen)
			; Fix to take into account times over the 24-hour period.
			If (fTime > fHourClosed && fTime < fHourOpen) 
				return true
			EndIf
		Else
			If (fTime < fHourOpen || fTime > fHourClosed)
				return true
			EndIf
		EndIf
		return false
EndFunction

; Overrided Function.
Function ObjectActive()
	Lock(false, true)
EndFunction

; Overrided Function.
Function ObjectInactive()
	SetLockLevel(100)
	Lock()
EndFunction

; Get the day of the week.
Int Function GetDayOfWeek()
	return ((Utility.GetCurrentGameTime() as Int) % 7) as Int	
EndFunction