Scriptname aaTriggerSound extends ObjectReference  

Actor Property PlayerREF Auto
Sound Property shoutDescriptor Auto
 
Event OnTriggerEnter(ObjectReference akActionRef)
	shoutDescriptor.Play(self)
EndEvent