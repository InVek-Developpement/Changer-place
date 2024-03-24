-- DESACTIVER LE CHANGEMENT DE PLACE AUTO
local disableShuffle = true--Status du shuffle
Citizen.CreateThread(function()
	while true do
		local timer = 500
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			timer = 0
			local plyVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			CarSpeed = GetEntitySpeed(plyVehicle) * 3.6 -- On définit la vitesse du véhicule en km/h
			if CarSpeed <= 50.0 then -- On ne peux pas changer de place si la vitesse du véhicule est au dessus ou égale à 50 km/h
				if IsControlJustReleased(0, 157) then -- conducteur
					SetPedIntoVehicle(PlayerPedId(), plyVehicle, -1)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 158) then -- avant droit
					SetPedIntoVehicle(PlayerPedId(), plyVehicle, 0)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 160) then -- arriere gauche
					SetPedIntoVehicle(PlayerPedId(), plyVehicle, 1)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 164) then -- arriere gauche
					SetPedIntoVehicle(PlayerPedId(), plyVehicle, 2)
					Citizen.Wait(10)
				end
			end

			if disableShuffle then
				if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId() then
					if GetIsTaskActive(PlayerPedId(), 165) then
						SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
					end
				end
			end
		end

		Citizen.Wait(timer)
	end
end)