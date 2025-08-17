local setPed = {}

CreateThread(function ()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        if PlayerIsInAllowedCoord(pos) then
            local allPlayers = GetActivePlayers()
            for _, v in ipairs(allPlayers) do
                local playerPed = GetPlayerPed(v)
                local pedPos = GetEntityCoords(playerPed)
                local distance = #(pos - pedPos)
                if distance <= 10 then
                    SetEntityNoCollisionEntity(playerPed, PlayerPedId(), true)
                    if v ~= PlayerPedId() then
                        if not setPed[playerPed] then
                            SetEntityAlpha(playerPed, 51*3, false)
                            setPed[playerPed] = true
                        end
                    end
                else
                    if setPed[playerPed] then
                        SetEntityAlpha(playerPed, 255, false)
                        setPed[playerPed] = false
                    end
                end
            end
        end
    end
end)

function PlayerIsInAllowedCoord(pos)
    for _, data in ipairs(Config.Locations) do
        local distance = #(pos - data.coord)
        if distance <= data.range then
            return true
        end
    end
    return false
end

-- Bug fixes command
RegisterCommand('resetmyalpha', function ()
    SetEntityAlpha(PlayerPedId(), 255, false)
end)