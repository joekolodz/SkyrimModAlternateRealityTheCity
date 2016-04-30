Scriptname aaText_RoyaleWalkway extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 10)
			Debug.Notification("You are at the Royale Walkway")
			aaLastLocationText.SetValue(10)
		EndIf
	EndIf
EndEvent