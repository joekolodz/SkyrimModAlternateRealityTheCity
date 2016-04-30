Scriptname aaText_EnclosedArea extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 14)
			Debug.Notification("You are in an Enclosed Area")
			aaLastLocationText.SetValue(14)
		EndIf
	EndIf
EndEvent