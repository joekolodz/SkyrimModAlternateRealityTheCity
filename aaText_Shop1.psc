Scriptname aaText_Shop1 extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 3)
			Debug.Notification("You are at the Finest Clothiers")
			aaLastLocationText.SetValue(3)
		EndIf
	EndIf
EndEvent