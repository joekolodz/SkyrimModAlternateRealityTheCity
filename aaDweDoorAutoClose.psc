;
; Automatically close our doors
;
Scriptname aaDweDoorAutoClose extends ObjectReference  

Event OnUpdate()
	SetOpen(False)
EndEvent
 
Event OnActivate(ObjectReference akActionRef)
	If !IsLocked()
		SetOpen(True)
		RegisterForSingleUpdate(10)
	Endif
EndEvent