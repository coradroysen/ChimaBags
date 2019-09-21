local TimeSinceLastUpdate = 0

local function ChimaBags_UpdateValues(self, elapsed)
  TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed

  if TimeSinceLastUpdate > .1 then
    TimeSinceLastUpdate = 0

    local emptySlots = 0
    local numberOfFreeSlots = {}
    local bagType = {}

    for i = 0, 4 do
      numberOfFreeSlots[i], bagType[i] = GetContainerNumFreeSlots(i);
      if bagType[i] == 0 then emptySlots = emptySlots + numberOfFreeSlots[i] end
    end
    bagsTextBP:SetText(emptySlots)

    if emptySlots > 5 then
      bagsTextBP:SetTextColor(1, 1, 1, 1)
      bagsTextBP:SetFont("Fonts\\FRIZQT__.TTF", 10, "THICKOUTLINE")
    elseif emptySlots > 0 then
      bagsTextBP:SetTextColor(1, 0.75, 0.5, 1)
      bagsTextBP:SetFont("Fonts\\FRIZQT__.TTF", 14, "THICKOUTLINE")
    else
      bagsTextBP:SetTextColor(1, 0.5, 0.5, 1)
      bagsTextBP:SetFont("Fonts\\FRIZQT__.TTF", 18, "THICKOUTLINE")
    end
  end
end



function ChimaBags_OnLoad(self, event, ...)
  self:RegisterEvent("ADDON_LOADED")
end

function ChimaBags_OnEvent(self, event, ...)
   if event == "ADDON_LOADED" and ... == "ChimaBags" then
      self:UnregisterEvent("ADDON_LOADED")

  	  bagsFrame:SetScript("OnUpdate", ChimaBags_UpdateValues)

      MainMenuBarBackpackButton:CreateFontString("bagsTextBP", "ARTWORK", nil)
      bagsTextBP:SetPoint("CENTER")
      bagsTextBP:SetFont("Fonts\\FRIZQT__.TTF", 10, "THICKOUTLINE")
      bagsTextBP:SetText("")
      bagsTextBP:Show()
	end
end
