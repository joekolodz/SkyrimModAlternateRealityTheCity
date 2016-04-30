Scriptname aaText_Street extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 11)
			Debug.Notification("You are on a Street")
			aaLastLocationText.SetValue(11)
		EndIf
	EndIf
EndEvent