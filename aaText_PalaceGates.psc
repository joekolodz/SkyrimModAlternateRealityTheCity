Scriptname aaText_PalaceGates extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 12)
			Debug.Notification("You are at the Palace Gates")
			aaLastLocationText.SetValue(12)
		EndIf
	EndIf
EndEvent