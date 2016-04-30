Scriptname aaTheCityMaintenance extends Quest  ; attached to Character.Quest.aaTheCityMaintenanceQuest.Scripts

GlobalVariable property aaFatigueLevel auto
GlobalVariable property aaHungerLevel auto
GlobalVariable property aaThirstLevel auto
GlobalVariable property aaDigestionLevel auto
GlobalVariable property aaInebriationLevel auto
GlobalVariable property aaWarmthLevel auto

;penalty flags
GlobalVariable property aaIsBloated auto
GlobalVariable property aaIsStarving auto
GlobalVariable property aaIsDehydrated auto
GlobalVariable property aaIsExhausted auto
GlobalVariable property aaIsInebriated auto

GlobalVariable property aaInnPriceAdjusted auto
Quest property aaTheCityMaintenanceQuest Auto
GlobalVariable Property GameHour  auto

Function Maintenance()
	RegisterForSingleUpdate(5)
EndFunction

Event OnUpdate()
	RegisterForSingleUpdate(60)
	Debug.Notification("15 minutes have passed")
	HandleMetabolism()
	
	if(aaTheCityMaintenanceQuest.IsRunning())
		debug.notification("quest is running")
	else
		debug.notification("quest is not running. starting...")
		bool isStarted = aaTheCityMaintenanceQuest.Start()
		if(isStarted == true)
			debug.notification("quest did not start")
		else
			debug.notification("quest started!")
		endif
	endif		
EndEvent

Function HandleMetabolism()
	HandleFatigue()
	HandleHunger()
	HandleThirst()
	HandleDigestion()
	HandleInebriation()
EndFunction

Function HandleFatigue()
	float fatigue = aaFatigueLevel.GetValue()
	int isExhausted = aaIsExhausted.GetValue() as int
	fatigue = fatigue + 0.5 + 20.0
	aaFatigueLevel.SetValue(fatigue)
	;Debug.Notification("Fatige level:" + fatigue)

	;0 - 40 no effects
	if fatigue >= 41 && fatigue <=72
		;41 - 72 weary (20 hours)
		Debug.Notification("Weary")
	elseif fatigue >= 73 && fatigue <=96
		;73 - 96 Tired (36 hours)
		Debug.Notification("Tired")
	elseif fatigue >= 97
		;97 - 255 Very Tired (48 hours) Probability of 50% to increase by 1 a random primary stat penalty every 15 minutes
		Debug.Notification("Very Tired!")
		
		;apply penalty
		int chance = Utility.RandomInt(1,100)
		if chance <= 50		
			Debug.Notification("Very Tired! - penalty applied!")	
		EndIf
		
		if isExhausted == 0
			isExhausted = 1
			aaIsExhausted.SetValue(isExhausted)
		EndIf		
	elseif fatigue > 255
		aaFatigueLevel.SetValue(255)
	EndIf
	
	if fatigue < 97
		if isExhausted == 1
			isExhausted = 0
			aaIsExhausted.SetValue(isExhausted)
		EndIf		
	EndIf
	
EndFunction

Function HandleHunger()
	float hunger = aaHungerLevel.GetValue()
	hunger = hunger + 0.5
	aaHungerLevel.SetValue(hunger)
	;Debug.Notification("Hunger level:" + hunger)

	;aaHungerLevel: 
	;0 - 16 no effects
	;17 - 48 Hungry (8 hours)
	;49 - 96 Famished (24 hours)
	;97 - 255 Starving (48 hours) Probability of 50% to increase by 1 a random primary stat penalty every 15 minutes
EndFunction

Function HandleThirst()
	float thirst = aaThirstLevel.GetValue()
	thirst = thirst + 0.5
	aaThirstLevel.SetValue(thirst)
	;Debug.Notification("Thirst level:" + thirst)

	;aaThirstLevel: 
	;0 - 16 no effects
	;17 - 32 Thirsty (8 hours)
	;33 - 56 Very Thirsty (24 hours)
	;57 - 255 Parched (48 hours) Probability of 50% to increase by 1 a random primary stat penalty every 15 minutes
EndFunction

Function HandleDigestion()
	float digestion = aaDigestionLevel.GetValue()
	int isBloated = aaIsBloated.GetValue() as int

	digestion = digestion - 3
	if digestion < 0
		digestion = 0
	EndIf

	if digestion >= 128
		if(isBloated == 0)
			isBloated = 1
			aaIsBloated.SetValue(isBloated)
			;apply movement penalty
			Debug.Notification("Bloated")
		endif
	elseif digestion < 128
		if(isBloated == 1)
			isBloated = 0			
			aaIsBloated.SetValue(isBloated)
			;remove movement penalty
		endif	
	endif
EndFunction

Function HandleInebriation()
	float inebriation = aaInebriationLevel.GetValue()
	
EndFunction