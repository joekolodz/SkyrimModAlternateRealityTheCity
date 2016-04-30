Scriptname aaText_TravellersInn extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 5)
			Debug.Notification("You are at the Traveller's Inn")
			aaLastLocationText.SetValue(5)
		EndIf
	EndIf
EndEvent