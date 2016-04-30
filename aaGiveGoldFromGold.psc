;
; 1 Copper = 1 Copper
; 1 Silver = 10 Copper
; 1 Gold   = 100 Copper
;
; Since we only have one currency type to work with, we have to divide everything down to coppers.
; If we find 2 gold pieces, then we have to give the player 200 coppers.
;
; Add this script to the Actor.Player form
;
Scriptname aaGiveGoldFromGold extends ObjectReference  

Actor property PlayerRef Auto ; auto-fill this
MiscObject Property GoldAmount Auto ; Point this to Items.MiscItem.Gold001
bool property IsAddingGold = false auto ; do not fill this

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)	
	if(IsAddingGold == false)	
		if(akBaseItem.GetFormID() == 0x0200E764) ;aaCopper001
			IsAddingGold = true
			PlayerRef.RemoveItem(akBaseItem, aiItemCount, true)
			PlayerRef.AddItem(GoldAmount, aiItemCount, true)
		endIf
		
		if(akBaseItem.GetFormID() == 0x0200E766) ;aaSilver001
			IsAddingGold = true
			PlayerRef.RemoveItem(akBaseItem, aiItemCount, true)
			PlayerRef.AddItem(GoldAmount, 10 * aiItemCount, true)
		endIf
		
		if(akBaseItem.GetFormID() == 0x0200E768) ;aaGold001
			IsAddingGold = true
			PlayerRef.RemoveItem(akBaseItem, aiItemCount, true)
			PlayerRef.AddItem(GoldAmount, 100 * aiItemCount, true)
		endIf
		IsAddingGold = false
	endIf
endEvent