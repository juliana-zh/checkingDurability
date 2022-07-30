local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("CHAT_MSG_PARTY")
EventFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER")

local inventorySlotConstants = {
	INVSLOT_HEAD,
	INVSLOT_SHOULDER,
	INVSLOT_CHEST,
	INVSLOT_WAIST,
	INVSLOT_LEGS,
	INVSLOT_FEET,
	INVSLOT_WRIST,
	INVSLOT_HAND,
	INVSLOT_MAINHAND,
	INVSLOT_OFFHAND
}

EventFrame:SetScript("OnEvent", function(self, event, ...)
	if(event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER") then    
		local text = ...

		if(text == "Durability Check!") then
			local curTotal = 0
			local maxTotal = 0

			for key, value in pairs(inventorySlotConstants) do                
				local current, maximum = GetInventoryItemDurability(value)
                if (not (current == nil) and not (maximum == nil)) then
                    curTotal = curTotal + current
                    maxTotal = maxTotal + maximum                    
                end
			end

			local message = math.floor(curTotal / maxTotal * 100) .. " %"
			SendChatMessage(message, "party")        
		end
	end
end)