;
; Alternate Reality: The City is not in the Elder Scrolls universe. Therefore, we need to remove some basic civil rights a player would normally have.
; This script removes all spells, items, and shouts from the player. Resets their level to 1. And gives them a random amount of gold to start.
; It prevents spells from being equiped or cast.
; It prevents health from regererating automatically. Health is only regained by sleeping at an inn or drinking potions.
; 
; Add this script to the Character.Quest.aaTheCityMaintenanceQuest.aaPlayerAlias
;
;
Scriptname aaAbortSpells extends ReferenceAlias

Actor property PlayerRef Auto ; auto-fill
Bool Property IsPlayerStripped = False Auto ; only want to strip the player the first time they portal to the City
MiscObject Property GoldAmount Auto ; point this to Items.MiscItem.Gold001 (The default currency in The City is copper, not gold)
Weapon Property DaggerForPlayTesting Auto ;for play testing only!
Armor Property CheapGrayBreechcloth Auto ;fill this in from the quest alias tab and point to aaCheapGrayBreechcloth
Armor Property SimpleGrayCloak Auto ;fill this in from the quest alias tab and point to aaSimpleGrayCloak

aaTheCityMaintenance QuestScript

Event OnPlayerLoadGame()
	IsPlayerStripped = false ; this is for debugging only, make sure to remove this for actual play! We'd only set it to false once when the play first entered The City
	
	QuestScript = GetOwningQuest() as aaTheCityMaintenance
	QuestScript.Maintenance()
	
	OnInit()
EndEvent	   

Event OnInit()
	Debug.Notification(PlayerRef.GetBaseObject().GetName() + " is now joined!")

	if IsPlayerStripped == false
		StripPlayer(PlayerRef)
		AddNewPlayerItems(PlayerRef)
		IsPlayerStripped = True		
	else
		;always strip spells in case they've acquired them somehow
		StripAllSpells(PlayerRef)
		StripAllShouts(PlayerRef)	
	endif
EndEvent

;When a new player first enters the city, they will be set to level one and stripped of all items, spells, and shouts.
;The City is not in the Elder Scrolls universe, so we are taking over everything here.
function StripPlayer(Actor akPlayer)
	StripItemsAndDispel(akPlayer)
	StripAllSpells(akPlayer)
	StripAllShouts(akPlayer)
	
	Game.SetPlayerLevel(1)
	
	;akPlayer.SetActorValue("health", 10.0) ;Health will be determined another way, but for now leave it as it already is on the player.
	
	;we don't ever want any health regen. Sleeping and Potions are the only way to restore health.
	akPlayer.SetActorValue("HealRate", 0.0)
	akPlayer.SetActorValue("HealRateMult", 0.0)
	akPlayer.SetActorValue("CombatHealthRegenMultMod", 0.0)
	
 endFunction
 
 ;A player begins his life in The City as a humble pauper.
 function StripItemsAndDispel(Actor akPlayer)
 	akPlayer.DispelAllSpells()
	akPlayer.UnEquipAll()
	akPlayer.RemoveAllItems(abRemoveQuestItems = true)
 endFunction
 
 function AddNewPlayerItems(Actor akPlayer)	
 	;aaDaggerPlayer for testing
	akPlayer.AddItem(DaggerForPlayTesting, 1, false)
	
 	;aaCheapGrayBreechcloth
	akPlayer.AddItem(CheapGrayBreechcloth, 1, true) 
 	
	;aaSimpleGrayCloak
	akPlayer.AddItem(SimpleGrayCloak, 1, true)
	
	;get random gold between 100 and 200
	akPlayer.AddItem(GoldAmount, Utility.RandomInt(100, 200), true) 
endFunction

 function StripAllSpells(Actor akPlayer)
	int SpellsAddedNum = akPlayer.GetSpellCount()
	Spell spellToRemove
	While (SpellsAddedNum > -1)
		SpellsAddedNum = SpellsAddedNum - 1
		spellToRemove = akPlayer.GetNthSpell(SpellsAddedNum)
		akPlayer.RemoveSpell(spellToRemove)
	endWhile
	
	akPlayer.RemoveSpell(Game.GetForm(0x000E8282) as Spell)
	akPlayer.RemoveSpell(Game.GetForm(0x000E8281) as Spell)
	akPlayer.RemoveSpell(Game.GetForm(0x0010BF09) as Spell)
	akPlayer.RemoveSpell(Game.GetForm(0x001031D3) as Spell)
	
 endFunction
 
;Spells are rare! Do not allow spell casting right now, but this will change in the future. 
Event OnSpellCast(Form akSpell)
	;string spellName = akSpell.GetName()
	PlayerRef.InterruptCast()	
	Debug.Notification("Something is not quite right")	
endEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference) 
	if akBaseObject as Spell
		Debug.Notification("Something is not quite right")	
		UnequipSpell(0)
		UnequipSpell(1)
		UnequipSpell(2)
	endIf
endEvent

function UnequipSpell(int slot)
	Spell akSpell = PlayerRef.GetEquippedSpell(slot)
	PlayerRef.UnequipSpell(akSpell, slot)
endFunction
  
 function StripShoutByFormId(Actor akPlayer, int aiFormID)
	Shout s = Game.GetForm(aiFormID) as Shout
	akPlayer.RemoveShout(s)
 endFunction

 function StripAllShouts(Actor akPlayer)
	StripShoutByFormId(akPlayer, 0x00013E07)
	StripShoutByFormId(akPlayer, 0x00016C40)
	StripShoutByFormId(akPlayer, 0x00016CF0)
	StripShoutByFormId(akPlayer, 0x0002395A)
	StripShoutByFormId(akPlayer, 0x000252C0)
	StripShoutByFormId(akPlayer, 0x0002F2DF)
	StripShoutByFormId(akPlayer, 0x0002F7BA)
	StripShoutByFormId(akPlayer, 0x00032920)
	StripShoutByFormId(akPlayer, 0x00032921)
	StripShoutByFormId(akPlayer, 0x0003CD34)
	StripShoutByFormId(akPlayer, 0x0003F9EA)
	StripShoutByFormId(akPlayer, 0x00044250)
	StripShoutByFormId(akPlayer, 0x00046B8C)
	StripShoutByFormId(akPlayer, 0x00048AC9)
	StripShoutByFormId(akPlayer, 0x0004C40B)
	StripShoutByFormId(akPlayer, 0x0004DBA5)
	StripShoutByFormId(akPlayer, 0x0005196A)
	StripShoutByFormId(akPlayer, 0x000549B1)
	StripShoutByFormId(akPlayer, 0x000549B2)
	StripShoutByFormId(akPlayer, 0x00059327)
	StripShoutByFormId(akPlayer, 0x0005D16B)
	StripShoutByFormId(akPlayer, 0x0005FC77)
	StripShoutByFormId(akPlayer, 0x0007097B)
	StripShoutByFormId(akPlayer, 0x0007097C)
	StripShoutByFormId(akPlayer, 0x0007097D)
	StripShoutByFormId(akPlayer, 0x0007097E)
	StripShoutByFormId(akPlayer, 0x0007097F)
	StripShoutByFormId(akPlayer, 0x00070980)
	StripShoutByFormId(akPlayer, 0x00070981)
	StripShoutByFormId(akPlayer, 0x0007A4C8)
	StripShoutByFormId(akPlayer, 0x0009DE93)
	StripShoutByFormId(akPlayer, 0x000A82BC)
	StripShoutByFormId(akPlayer, 0x000B2387)
	StripShoutByFormId(akPlayer, 0x000CE218)
	StripShoutByFormId(akPlayer, 0x000CF790)
	StripShoutByFormId(akPlayer, 0x000CF79B)
	StripShoutByFormId(akPlayer, 0x000DD607)
	StripShoutByFormId(akPlayer, 0x000E40C4)
	StripShoutByFormId(akPlayer, 0x000E40CB)
	StripShoutByFormId(akPlayer, 0x000E40D1)
	StripShoutByFormId(akPlayer, 0x000E4908)
	StripShoutByFormId(akPlayer, 0x000E5F68)
	StripShoutByFormId(akPlayer, 0x000F80F7)
	StripShoutByFormId(akPlayer, 0x000F80F8)
	StripShoutByFormId(akPlayer, 0x000F80F9)
	StripShoutByFormId(akPlayer, 0x000F80FB)
	StripShoutByFormId(akPlayer, 0x000F8100)
	StripShoutByFormId(akPlayer, 0x000F8101)
	StripShoutByFormId(akPlayer, 0x000F8108)
	StripShoutByFormId(akPlayer, 0x000F8109)
	StripShoutByFormId(akPlayer, 0x000F810A)
	StripShoutByFormId(akPlayer, 0x000F810B)
	StripShoutByFormId(akPlayer, 0x000FAE9D)
	StripShoutByFormId(akPlayer, 0x000FAEA0)
	StripShoutByFormId(akPlayer, 0x00101CEC)
	StripShoutByFormId(akPlayer, 0x00107580)
	StripShoutByFormId(akPlayer, 0x0010C4DF)
	StripShoutByFormId(akPlayer, 0x0010C4E0)
	StripShoutByFormId(akPlayer, 0x0010C4E1)
	StripShoutByFormId(akPlayer, 0x0010C4E2)
	StripShoutByFormId(akPlayer, 0x0010E755)
	StripShoutByFormId(akPlayer, 0x0010F72D)
	StripShoutByFormId(akPlayer, 0x0010F72E)
	StripShoutByFormId(akPlayer, 0x0010F72F)
	StripShoutByFormId(akPlayer, 0x0010F730)
	StripShoutByFormId(akPlayer, 0x0010F731)
	StripShoutByFormId(akPlayer, 0x0010F732)
	StripShoutByFormId(akPlayer, 0x0010F733)
	StripShoutByFormId(akPlayer, 0x0010F734)
	StripShoutByFormId(akPlayer, 0x0010FE1B)
	StripShoutByFormId(akPlayer, 0x0010FE21)
	StripShoutByFormId(akPlayer, 0x0010FE22)
	StripShoutByFormId(akPlayer, 0x0010FE23)
	StripShoutByFormId(akPlayer, 0x0010FE24)
 endFunction
 
 ;function UnequipUsingDummyWeapon(Actor akActor)
	;EquipSlot slotRight = Game.GetForm(0x00013F42) As EquipSlot
	;EquipSlot slotLeft = Game.GetForm(0x00013F43) As EquipSlot

	;akActor.AddItem(myDummyWeapon1, abSilent = true)
	;akActor.AddItem(myDummyWeapon2, abSilent = true)

	;myDummyWeapon1.SetEquipType(slotRight)		
	;myDummyWeapon2.SetEquipType(slotLeft)

	;akActor.EquipItem(myDummyWeapon1, abSilent = true)
	;akActor.EquipItem(myDummyWeapon2, abSilent = true)

	;akActor.UnEquipItem(myDummyWeapon1, abSilent = true)
	;akActor.UnEquipItem(myDummyWeapon2, abSilent = true)

	;akActor.RemoveItem(myDummyWeapon1, abSilent = true)
	;akActor.RemoveItem(myDummyWeapon2, abSilent = true)
;endFunction