Scriptname aaText_GraniteBank extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 7)
			Debug.Notification("You are at the Granite Bank")
			aaLastLocationText.SetValue(7)
		EndIf
	EndIf
EndEvent