Scriptname aaText_BestBargainStore extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 9)
			Debug.Notification("You are at the Best Bargain Store")
			aaLastLocationText.SetValue(9)
		EndIf
	EndIf
EndEvent