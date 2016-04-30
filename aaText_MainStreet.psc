Scriptname aaText_MainStreet extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 4)
			Debug.Notification("You are on a Main Street")
			aaLastLocationText.SetValue(4)
		EndIf
	EndIf
EndEvent