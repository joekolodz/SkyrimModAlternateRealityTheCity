Scriptname aaText_ArenaEntrance extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 13)
			Debug.Notification("You are at the Arena Entrance")
			aaLastLocationText.SetValue(13)
		EndIf
	EndIf
EndEvent