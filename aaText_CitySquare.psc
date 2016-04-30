Scriptname aaText_CitySquare extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 2 && last != 5 && last != 6 && last != 7 && last != 8 && last != 9)
			Debug.Notification("You are at the City Square")
			aaLastLocationText.SetValue(2)
		EndIf
	EndIf
EndEvent