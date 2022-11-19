
-- Crouch
local foreskin = false
local timelimit = 0
local isHolding = false
local isFlying = false
incrouch = true
Controlkey = {["movementCrouch"] = {73,"X"}} 

function crouchMovement()
    RequestAnimSet("move_ped_crouched")
    while not HasAnimSetLoaded("move_ped_crouched") do
        Citizen.Wait(0)
    end

    SetPedMovementClipset(PlayerPedId(), "move_ped_crouched",1.0)    
    SetPedWeaponMovementClipset(PlayerPedId(), "move_ped_crouched",1.0)
    SetPedStrafeClipset(PlayerPedId(), "move_ped_crouched_strafing",1.0)

end

Citizen.CreateThread(function()

    local Triggered1 = false
    local Triggered2 = false
    
    while true do

        if ctrlStage == 3 then

            if IsControlJustPressed(2,23) then
                firstPersonActive = false
                ctrlStage = 0
                TriggerEvent("AnimSet:Set")
                jumpDisabled = false
                SetPedStealthMovement(PlayerPedId(),0,0)       
            else
                if not Triggered3 then
                    ClearPedTasks(PlayerPedId())
                    Triggered1 = false  
                    Triggered2 = false
                    Triggered3 = true
                    crouchMovement()

                else
                    if IsControlJustReleased(1,Controlkey["movementCrouch"][1]) and not exports['ragdoll']:GetDeathStatus() then -- X
                        SetPedStealthMovement(PlayerPedId(),true,"")
                        firstPersonActive = false
                        ctrlStage = 0

                        TriggerEvent("AnimSet:Set")

                        Citizen.Wait(100)  
                        ClearPedTasks(PlayerPedId())

                        jumpDisabled = false
                        
                        Citizen.Wait(500)
                        SetPedStealthMovement(PlayerPedId(),false,"")
                        Triggered3 = false

                    else
                        if GetEntitySpeed(PlayerPedId()) > 1.0 and not incrouch then
                            incrouch = true
                            SetPedWeaponMovementClipset(PlayerPedId(), "move_ped_crouched",1.0)
                            SetPedStrafeClipset(PlayerPedId(), "move_ped_crouched_strafing",1.0)
                        elseif incrouch and GetEntitySpeed(PlayerPedId()) < 1.0 and (GetFollowPedCamViewMode() == 4 or GetFollowVehicleCamViewMode() == 4) then
        
                            incrouch = false
                            ResetPedWeaponMovementClipset(PlayerPedId())
                            ResetPedStrafeClipset(PlayerPedId())
                        end     
                    end         
                end
            end
        end




        if timelimit > 0 then
            timelimit = timelimit - 1
        end



        if IsControlJustPressed(0, 142) or IsDisabledControlJustPressed(0, 142) then
            if ctrlStage == 2 then
                ctrlStage = 3
            end
        end

        if IsControlJustReleased(1,Controlkey["movementCrouch"][1]) and not isFlying and not isHolding and not ( IsPedSittingInAnyVehicle( GetPlayerPed( -1 ) ) ) and not (handCuffed or handCuffedWalking or imdead == 1) then

            ctrlStage = 3
            if GetPedStealthMovement(PlayerPedId()) then
                SetPedStealthMovement(PlayerPedId(),0,0)
            end             
            firstPersonActive = false
        end

        if IsPedJacking(PlayerPedId()) or IsPedInMeleeCombat(PlayerPedId()) or IsControlJustReleased(1,22) or IsPedRagdoll(PlayerPedId()) or handCuffed or handCuffedWalking or imdead == 1 or ( IsPedSittingInAnyVehicle( GetPlayerPed( -1 ) ) ) then

            if ctrlStage ~= 0 then
                ClearPedTasks(PlayerPedId())
                firstPersonActive = false
                ctrlStage = 0
                TriggerEvent("AnimSet:Set")
                jumpDisabled = false
                SetPedStealthMovement(PlayerPedId(),0,0)
                Triggered1 = false  
                Triggered2 = false
                Triggered3 = false
            end

        end
        Citizen.Wait(7)

        if IsPedSittingInAnyVehicle( GetPlayerPed( -1 ) ) then
            Citizen.Wait(1000)
        end

    end
end)