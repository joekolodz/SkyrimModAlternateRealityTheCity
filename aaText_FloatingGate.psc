Scriptname aaText_FloatingGate extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 1)
			Debug.Notification("You are at the Floating Gate")
			aaLastLocationText.SetValue(1)
		EndIf
	EndIf
EndEvent