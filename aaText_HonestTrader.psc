Scriptname aaText_HonestTrader extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 8)
			Debug.Notification("You are at the Honest Trader")
			aaLastLocationText.SetValue(8)
		EndIf
	EndIf
EndEvent