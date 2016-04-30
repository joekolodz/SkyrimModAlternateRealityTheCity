Scriptname aaInnOptionsMenu extends Quest

Quest property aaTheCityMaintenanceQuest Auto
Actor property PlayerRef Auto
MiscObject Property Gold001 Auto ; point this to Items.MiscItem.aaCopper001

Message property aaInnOptionsMsg Auto
Message property aaInnPriceMsg Auto

Message property aaInnSleepHoursMsg01 Auto
Message property aaInnSleepHoursMsg02 Auto

Message property aaInnRoomOptionsMsg01 Auto
Message property aaInnRoomOptionsMsg02 Auto
Message property aaInnRoomOptionsMsg03 Auto
Message property aaInnRoomOptionsMsg04 Auto

float property PriceFactor Auto
GlobalVariable property aaInnPriceAdjusted Auto
GlobalVariable property aaPlayerCopperAmount Auto
GlobalVariable Property GameHour  auto

ImageSpaceModifier property ScreenFadeForSleepEffectImod auto

int roomType
int stayTheNight
string roomTypeDescription
int roomBasePrice
int probabilityForRestfulSleep


;Event OnActivate(ObjectReference akActionRef)	
Function OpenMenu(ObjectReference akActionRef)
	Float Time = GameHour.GetValue() as float
	debug.notification("GameTime before:" + Time)

	stayTheNight = CounterOptionsMenu01()
	
	if stayTheNight == 0	
		roomType = RoomMenu01()
			
		if roomType > 0
			SetRoomTypeProperties(roomType)							
			float priceAdjusted = roomBasePrice * PriceFactor
			int totalCostInCoppers = priceAdjusted as int
			aaInnPriceAdjusted.SetValue(totalCostInCoppers)

			;Debug.notification("Room Type:" + roomTypeDescription)
			;Debug.notification("base price:" + roomBasePrice)
			;Debug.notification("price factor:" + PriceFactor)
			;Debug.notification("adjusted price:" + totalCostInCoppers)
		
			int hoursToSleep = HoursMenu01()
			
			int playerCopperAmount = PlayerRef.GetGoldAmount()
			aaPlayerCopperAmount.SetValue(playerCopperAmount)
			
			UpdateCurrentInstanceGlobal(aaInnPriceAdjusted)
			UpdateCurrentInstanceGlobal(aaPlayerCopperAmount)
			
			aaInnPriceMsg.Show()
			
			if hoursToSleep > 0			
				if(playerCopperAmount <= totalCostInCoppers)
					debug.notification("Get out you worm! You do not have enough money!")
				else
					PlayerRef.RemoveItem(Gold001, totalCostInCoppers)
					Sleeping(hoursToSleep)
				EndIf
			endif
		endif
	endif
EndFunction

Function Sleeping(int hoursToSleep)
	debug.notification("Sleeping....")
	
	;ScreenFadeForSleepEffectImod.Apply();
	
	AdvanceGameTime(hoursToSleep as float)
	
	debug.notification("Done Sleeping")
EndFunction


function AdvanceGameTime(Float TimePassed)
	Float Time = GameHour.GetValue() as float
	Int Std = math.Floor(Time)
	Time -= Std as Float
	Time += TimePassed
	Time += Std as Float
	Int Hours = math.Floor(TimePassed)
	Int Minutes = math.Floor((TimePassed - Hours as Float) * 100 as Float * 3 as Float / 5 as Float)
	GameHour.SetValue(Time)
	Time = GameHour.GetValue() as float
endFunction



int Function CounterOptionsMenu01(int aiButton = 0)
	return aaInnOptionsMsg.show()
EndFunction

int Function RoomMenu01(int aiButton = 0)
	aiButton = aaInnRoomOptionsMsg01.show()
	if aiButton == 4
		return RoomMenu02()		
	EndIf
	return aiButton
EndFunction

int Function RoomMenu02(int aiButton = 0)
	aiButton = aaInnRoomOptionsMsg02.show()
	if aiButton == 0
		return 0
	elseif aiButton == 3
		return RoomMenu01()
	elseif aiButton == 4
		return RoomMenu03()
	EndIf
	return aiButton + 3
EndFunction

int Function RoomMenu03(int aiButton = 0)
	aiButton = aaInnRoomOptionsMsg03.show()
	if aiButton == 0
		return 0
	elseif aiButton == 3
		return RoomMenu02()
	elseif aiButton == 4
		return RoomMenu04()
	EndIf
	return aiButton + 5
EndFunction

int Function RoomMenu04(int aiButton = 0)
	aiButton = aaInnRoomOptionsMsg04.show()
	if aiButton == 0
		return 0
	elseif aiButton == 4
		return RoomMenu03()
	EndIf
	return aiButton + 7
EndFunction

string function SetRoomTypeProperties(int aiRoomType)
	if aiRoomType == 1
		SetBaseProperties("the common area floor", 10, 35)
	elseif aiRoomType == 2 
		SetBaseProperties("a Bed with no bath", 20, 45)
	elseif aiRoomType == 3
		SetBaseProperties("a Bed with common Bath", 30, 60)
	elseif aiRoomType == 4 
		SetBaseProperties("a Room, with common Bath", 40, 85)
	elseif aiRoomType == 5 
		SetBaseProperties("a Room with Bath", 50, 100)
	elseif aiRoomType == 6 
		SetBaseProperties("a Premium Room", 100, 140)
	elseif aiRoomType == 7 
		SetBaseProperties("a Deluxe Room", 200, 170)
	elseif aiRoomType == 8 
		SetBaseProperties("a Small Suite", 400, 200)
	elseif aiRoomType == 9 
		SetBaseProperties("a Suite", 800, 240)
	elseif aiRoomType == 10
		SetBaseProperties("Our BEST Suite", 1600, 255)
	else
		SetBaseProperties("I don't know what room you want", 0, 0)
	endif
EndFunction

int Function SetBaseProperties(string description, int basePrice, int rest)
	roomTypeDescription = description
	roomBasePrice = basePrice
	probabilityForRestfulSleep = rest
EndFunction

int Function HoursMenu01(int aiButton = 0)
	aiButton = aaInnSleepHoursMsg01.show()
	
	if aiButton == 7
		return HoursMenu02()
	else
		return aiButton
	endif
EndFunction

int Function HoursMenu02(int aiButton = 0)
	aiButton = aaInnSleepHoursMsg02.show()

	if aiButton == 0
		return 0
	elseif aiButton == 7
		return HoursMenu01()
	else
		return aiButton + 6
	endif
EndFunction