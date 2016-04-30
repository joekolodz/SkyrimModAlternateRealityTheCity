Scriptname aaText_BestArmorers extends ObjectReference  

Actor Property PlayerREF Auto
GlobalVariable property aaLastLocationText Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	If (akActionRef == PlayerREF)
		int last = aaLastLocationText.GetValue() as int
		If(last != 6)
			Debug.Notification("You are at the Best Armorers")
			aaLastLocationText.SetValue(6)
		EndIf
	EndIf
EndEvent