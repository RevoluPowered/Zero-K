function widget:GetInfo() return {
	name	= "Morph Finished notification",
	desc	= "Evolution complete",
	author	= "sprung",
	license	= "pd",
	layer	= 0,
	enabled	= true,
} end

local morphCompleteMsg
local function languageChanged ()
	morphCompleteMsg = WG.Translate ("common", "morph_complete")
end

function widget:Initialize()
	WG.InitializeTranslation (languageChanged, GetInfo().name)
end

function widget:Shutdown()
	WG.ShutdownTranslation(GetInfo().name)
end

function widget:UnitDestroyed(unitID, unitDefID, unitTeam)
	if (unitTeam ~= Spring.GetMyTeamID()) then return end
	
	local newUnit = Spring.GetUnitRulesParam(unitID, "wasMorphedTo")
	if not newUnit then return end

	local newUnitDefID = Spring.GetUnitDefID(newUnit)
	Spring.Echo("game_message: " .. morphCompleteMsg .. ": " .. (Spring.GetUnitRulesParam(unitID, "comm_name") or UnitDefs[newUnitDefID].humanName))
end
