PED_COMPONENTS_IDS = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
playerApperance = nil
currentFadeStyle = {}
playerTattoos = {}

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}
local tatCategory = GetTatCategs()
local tattooHashList = CreateHashList()


playerHeadBlend = {
    ["shapeFirst"] = 0,
    ["shapeSecond"] = 0,
    ["shapeThirt"] = 0,
    ["skinFirst"] = 0,
    ["skinSecond"] = 0,
    ["shapeMix"] = 0,
    ["skinMix"] = 0,
    ["thirdMix"] = 0,
}

hairDecorDefault = {'mpbeach_overlays', "FM_hair_fuzz"} --if the haircut is not there, add some hair fuzz. It will not always match, but it's better than having the hair look "glued on".

hairDecor = {
    ['m'] = {
        [0] = {"",""}, --who doesn't like a shiny head from time to time?
        [1] = {"multiplayer_overlays", "FM_M_Hair_001_a"},
        [2] = {"multiplayer_overlays", "NG_M_Hair_002"},
        [3] = {"multiplayer_overlays", "FM_M_Hair_003_a"},
        [4] = {"multiplayer_overlays", "NG_M_Hair_004"},
        [5] = {"multiplayer_overlays", "FM_M_Hair_long_a"},
        [6] = {"multiplayer_overlays", "FM_M_Hair_006_a"},
        [8] = {"multiplayer_overlays", "FM_M_Hair_008_a"},
        [9] = {"multiplayer_overlays", "NG_M_Hair_009"},
        [10] = {"multiplayer_overlays", "NG_M_Hair_013"},
        [11] = {"multiplayer_overlays", "NG_M_Hair_002"},
        [12] = {"multiplayer_overlays", "NG_M_Hair_011"},
        [13] = {"multiplayer_overlays", "NG_M_Hair_012"},
        [14] = {"multiplayer_overlays", "NG_M_Hair_014"},
        [15] = {"multiplayer_overlays", "NG_M_Hair_015"},
        [16] = {"multiplayer_overlays", "NGBea_M_Hair_000"},
        [17] = {"multiplayer_overlays", "NGBea_M_Hair_001"},
        [18] = {"mpbusiness_overlays", "FM_Bus_M_Hair_000_a"},
        [19] = {"mpbusiness_overlays", "FM_Bus_M_Hair_001_a"},
        [20] = {"mphipster_overlays", "FM_Hip_M_Hair_000_a"},
        [21] = {"mphipster_overlays", "FM_Hip_M_Hair_001_a"},
        [22] = {"multiplayer_overlays", "NGInd_M_Hair_000"},
            --23
        [24] = {"mplowrider_overlays", "LR_M_Hair_000"},
        [25] = {"mplowrider_overlays", "LR_M_Hair_001"},
        [26] = {"mplowrider_overlays", "LR_M_Hair_002"},
        [27] = {"mplowrider_overlays", "LR_M_Hair_003"},
        [28] = {"mplowrider2_overlays", "LR_M_Hair_004"},
        [29] = {"mplowrider2_overlays", "LR_M_Hair_005"},
        [30] = {"mplowrider2_overlays", "LR_M_Hair_006"},
        [31] = {"mpbiker_overlays", "MP_Biker_Hair_000_M"},
        [32] = {"mpbiker_overlays", "MP_Biker_Hair_001_M"},
        [33] = {"mpbiker_overlays", "MP_Biker_Hair_002_M"},
        [34] = {"mpbiker_overlays", "MP_Biker_Hair_003_M"},
        [35] = {"mpbiker_overlays", "MP_Biker_Hair_004_M"},
        [36] = {"mpbiker_overlays", "MP_Biker_Hair_005_M"},

        [72] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_M_000_M"},
        [73] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_M_001_M"},
        [74] = {"mpvinewood_overlays", "MP_Vinewood_Hair_M_000_M"},
        [75] = {"mptuner_overlays", "MP_Tuner_Hair_001_M"},
        [76] = {"mpsecurity_overlays", "MP_Security_Hair_001_M"},
    },
    ['f'] = {
        [0] = {"",""}, --who doesn't like a shiny head from time to time?
        [1] = {"multiplayer_overlays", "NG_F_Hair_001"},
        [2] = {"multiplayer_overlays", "NG_F_Hair_002"},
        [3] = {"multiplayer_overlays", "FM_F_Hair_003_a"},
        [4] = {"multiplayer_overlays", "NG_F_Hair_004"},
        [5] = {"multiplayer_overlays", "FM_F_Hair_005_a"},
        [6] = {"multiplayer_overlays", "FM_F_Hair_006_a"},
        [7] = {"multiplayer_overlays", "NG_F_Hair_007"},
        [8] = {"multiplayer_overlays", "NG_F_Hair_008"},
        [9] = {"multiplayer_overlays", "NG_F_Hair_009"},
        [10] = {"multiplayer_overlays", "NG_F_Hair_010"},
        [11] = {"multiplayer_overlays", "NG_F_Hair_011"},
        [12] = {"multiplayer_overlays", "NG_F_Hair_012"},
        [13] = {"multiplayer_overlays", "FM_F_Hair_013_a"},
        [14] = {"multiplayer_overlays", "FM_F_Hair_014_a"},
        [15] = {"multiplayer_overlays", "NG_M_Hair_015"},
        [16] = {"multiplayer_overlays", "NGBea_F_Hair_000"},
        [17] = {"mpbusiness_overlays", "FM_Bus_F_Hair_a"},
        [18] = {"multiplayer_overlays", "NG_F_Hair_007"},
        [19] = {"multiplayer_overlays", "NGBus_F_Hair_000"},
        [20] = {"multiplayer_overlays", "NGBus_F_Hair_001"},
        [21] = {"multiplayer_overlays", "NGBea_F_Hair_001"},
        [22] = {"mphipster_overlays", "FM_Hip_F_Hair_000_a"},
        [23] = {"multiplayer_overlays", "NGInd_F_Hair_000"},
        --24
        [25] = {"mplowrider_overlays", "LR_F_Hair_000"},
        [26] = {"mplowrider_overlays", "LR_F_Hair_001"},
        [27] = {"mplowrider_overlays", "LR_F_Hair_002"},
        [29] = {"mplowrider2_overlays", "LR_F_Hair_003"},
        [30] = {"mplowrider2_overlays", "LR_F_Hair_004"},
        [31] = {"mplowrider2_overlays", "LR_F_Hair_006"},
        [32] = {"mpbiker_overlays", "MP_Biker_Hair_000_F"},
        [33] = {"mpbiker_overlays", "MP_Biker_Hair_001_F"},
        [34] = {"mpbiker_overlays", "MP_Biker_Hair_002_F"},
        [35] = {"mpbiker_overlays", "MP_Biker_Hair_003_F"},
        [38] = {"mpbiker_overlays", "MP_Biker_Hair_004_F"},
        [36] = {"mpbiker_overlays", "MP_Biker_Hair_005_F"},
        [37] = {"mpbiker_overlays", "MP_Biker_Hair_005_F"},

        [76] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_F_000_F"},
        [77] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_F_001_F"},
        [78] = {"mpvinewood_overlays", "MP_Vinewood_Hair_F_000_F"},
        [79] = {"mptuner_overlays", "MP_Tuner_Hair_000_F"},
        [80] = {"mpsecurity_overlays", "MP_Security_Hair_000_F"},
    },
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("ev-clothes:loadPlayerSkin", PlayerPedId())
end)

CreateThread(function() 
    Config.SetShops()
end)

function SendReactMessage(action, data)
    SendNUIMessage({
      action = action,
      data = data
    })
end

local current = {
    ["mask"] = {
        id = 1,
        item = 0,
        texture = 0
    },
    ["hat"] = {
        id = 0,
        item = 0,
        texture = 0
    },
    ["glasses"] = {
        id = 1,
        item = 0,
        texture = 0
    },
    ["tshirt"] = {
        id = {
            torso = 11,
            tshirt = 8,
            arms = 3
        },
        item = {
            torso = 0,
            tshirt = 0,
            arms = 0
        },
        texture = {
            torso = 0,
            tshirt = 0,
            arms = 0
        }
    },
    ["bag"] = {
        id = 5,
        item = 0,
        texture = 0
    },
    ["pants"] = {
        id = 4,
        item = 0,
        texture = 0
    },
    ["shoes"] = {
        id = 6,
        item = 0,
        texture = 0
    },
}

local currentPrice = 0

RegisterNUICallback("handlePrice", function(data)
    if data then
        currentPrice = currentPrice + 30
    else
        currentPrice = currentPrice - 30
    end

    SendReactMessage("updatePrice", currentPrice)

end)

RegisterNUICallback("handleClothe", function(data)
    local ped = PlayerPedId()
    if data == "mask" then
        if GetPedDrawableVariation(ped, current[data].id) ~= 0 then
            current[data].item = GetPedDrawableVariation(ped, current[data].id)
            current[data].texture = GetPedTextureVariation(ped, current[data].id)
            SetPedComponentVariation(ped, current[data].id, 0, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id, current[data].item, current[data].texture, 0)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "hat" then
        if GetPedPropIndex(ped, current[data].item) ~= -1 then
            current[data].item = GetPedPropIndex(ped, current[data].id)
            current[data].texture = GetPedPropTextureIndex(ped, current[data].id)
            ClearPedProp(ped, 0)
        else
            SetPedPropIndex(ped, current[data].id, current[data].item, current[data].texture, true)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "glasses" then
        if GetPedPropIndex(ped, current[data].item) ~= -1 then
            current[data].item = GetPedPropIndex(ped, current[data].id)
            current[data].texture = GetPedPropTextureIndex(ped, current[data].id)
            ClearPedProp(ped, 1)
        else
            SetPedPropIndex(ped, current[data].id, current[data].item, current[data].texture, true)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "tshirt" then
        if GetPedDrawableVariation(ped, current[data].id.tshirt) ~= 15 then
            current[data].item.tshirt = GetPedDrawableVariation(ped, current[data].id.tshirt)
            current[data].texture.tshirt = GetPedTextureVariation(ped, current[data].id.tshirt)
            current[data].item.torso = GetPedDrawableVariation(ped, current[data].id.torso)
            current[data].texture.torso = GetPedTextureVariation(ped, current[data].id.torso)
            current[data].item.arms = GetPedDrawableVariation(ped, current[data].id.arms)
            current[data].texture.arms = GetPedTextureVariation(ped, current[data].id.arms)
            SetPedComponentVariation(ped, 8, 15, 0, 0)
            SetPedComponentVariation(ped, 11, 15, 0, 0)
            SetPedComponentVariation(ped, 3, 15, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id.tshirt, current[data].item.tshirt, current[data].texture.tshirt, 0)
            SetPedComponentVariation(ped, current[data].id.torso, current[data].item.torso, current[data].texture.torso, 0)
            SetPedComponentVariation(ped, current[data].id.arms, current[data].item.arms, current[data].texture.arms, 0)
            current[data].item.tshirt = 0
            current[data].item.torso = 0
            current[data].item.arms = 0
            current[data].texture.thirst = 0
            current[data].texture.torso = 0
            current[data].texture.arms = 0
        end
    elseif data == "bag" then
        if GetPedDrawableVariation(ped, current[data].id) ~= 0 then
            current[data].item = GetPedDrawableVariation(ped, current[data].id)
            current[data].texture = GetPedTextureVariation(ped, current[data].id)
            SetPedComponentVariation(ped, current[data].id, 0, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id, current[data].item, current[data].texture, 0)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "pants" then
        if GetPedDrawableVariation(ped, current[data].id) ~= 143 then
            current[data].item = GetPedDrawableVariation(ped, current[data].id)
            current[data].texture = GetPedTextureVariation(ped, current[data].id)
            SetPedComponentVariation(ped, current[data].id, 143, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id, current[data].item, current[data].texture, 0)
            current[data].item = 0
            current[data].texture = 0
        end
    elseif data == "shoes" then
        if GetPedDrawableVariation(ped, current[data].id) ~= 34 then
            current[data].item = GetPedDrawableVariation(ped, current[data].id)
            SetPedComponentVariation(ped, current[data].id, 34, 0, 0)
        else
            SetPedComponentVariation(ped, current[data].id, current[data].item, 0, 0)
            current[data].item = 0
            current[data].texture = 0
        end
    end
end)

function GetCurrentPed()
    player = PlayerPedId()
    return {
        model = GetEntityModel(PlayerPedId()),
        hairColor = GetPedHair(),
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructure(),
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        eyeColor = GetPedEyeColor(player),
        fadeStyle = currentFadeStyle
    }
end

function GetSkin()
    for i = 1, #frm_skins do
        if (GetHashKey(frm_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_male", value=i}
        end
    end
    for i = 1, #fr_skins do
        if (GetHashKey(fr_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_female", value=i}
        end
    end
    return false
end

function GetDrawables()
    drawables = {}
    local model = GetEntityModel(PlayerPedId())
    local mpPed = false
    if (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(player, i) == -1 then
            SetPedComponentVariation(player, i, 15, 0, 2)
        end
        drawables[i] = {drawable_names[i+1], GetPedDrawableVariation(player, i)}
    end
    return drawables
end

function GetProps()
    props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(player, i)}
    end
    return props
end

function GetDrawTextures()
    textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(player, i)})
    end
    return textures
end

function GetPropTextures()
    textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(player, i)})
    end
    return textures
end

function GetDrawablesTotal()
    drawables = {}
    for i = 0, #drawable_names - 1 do
        drawables[i] = {drawable_names[i+1], GetNumberOfPedDrawableVariations(player, i)}
    end
    return drawables
end

function GetPropDrawablesTotal()
    props = {}
    for i = 0, #prop_names - 1 do
        props[i] = {prop_names[i+1], GetNumberOfPedPropDrawableVariations(player, i)}
    end
    return props
end

function GetTextureTotals()
    local values = {}
    local draw = GetDrawables()
    local props = GetProps()

    for idx = 0, #draw-1 do
        local name = draw[idx][1]
        local value = draw[idx][2]
        values[name] = GetNumberOfPedTextureVariations(player, idx, value)
    end

    for idx = 0, #props-1 do
        local name = props[idx][1]
        local value = props[idx][2]
        values[name] = GetNumberOfPedPropTextureVariations(player, idx, value)
    end
    return values
end

function GetPedHair()
    local hairColor = {}
    hairColor[1] = GetPedHairColor(player)
    hairColor[2] = GetPedHairHighlightColor(player)
    return hairColor
end

function GetHeadStructureData()
    local structure = {}
    for i = 1, #face_features do
        structure[face_features[i]] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function GetHeadStructure(data)
    local structure = {}
    for i = 1, #face_features do
        structure[i] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function GetHeadOverlayData()
    local headData = {}
    for i = 1, #head_overlays do
        local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, i-1)
        if retval then
            headData[i] = {}
            headData[i].name = head_overlays[i]
            headData[i].overlayValue = overlayValue
            headData[i].colourType = colourType
            headData[i].firstColour = firstColour
            headData[i].secondColour = secondColour
            headData[i].overlayOpacity = overlayOpacity
        end
    end
    return headData
end

function toggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('setDisplay', shouldShow) 
end

RegisterNUICallback("closeNui", function(data)
    print(data.buy, data.amount, data.type)
    toggleNuiFrame(false)
    exports["ev-clothes"]:closeCamera()
    FreezeEntityPosition(PlayerPedId(), false)
    if not data.buy and playerApperance then
        setPedAppearance(PlayerPedId(), playerApperance)
    end

    playerSkin = GetCurrentPed()

    if data.buy and data.amount then
        local canPurchase = RPC.execute("ev-clothes:purchaseClothes", data.type, data.amount) 
        print(canPurchase)
        if canPurchase then
            TriggerEvent("DoLongHudText","Successfully Purchased.", 1)

            TriggerServerEvent("ev-clothes:insert_character_current", playerSkin)
            TriggerServerEvent("ev-clothes:insert_character_face", playerSkin) 
            TriggerServerEvent("ev-clothes:insert_character_face_blend", getPedAppearance(PlayerPedId())) 
            TriggerServerEvent("ev-clothes:set_tats", getPedAppearance(PlayerPedId()))
            --TriggerServerEvent("raid_clothes:set_tats", currentTats)

           --TriggerServerEvent('ev-clothes:saveSkin', getPedAppearance(PlayerPedId()))
        elseif not canPurchase and playerApperance then
            TriggerEvent("DoLongHudText","Not enough bread.", 2)
            setPedAppearance(PlayerPedId(), playerApperance)
        end
    end
end)

-- RegisterCommand('testo', function()
--     QBCore.Functions.TriggerCallback('ev-clothes:getCosts', function(pass)
--         if pass then
--             print('geçti')
--         else
--             print('geçemedi')
--         end
--     end, "cash", 0)
-- end)

RegisterNUICallback("getClothesMenu", function(data, cb)
    local ped = PlayerPedId()
    local menus = {
        ["parent"] = {
            {
                name = Config.Translate[Config.Lang].Parents.father,
                id = "shapeFirst",
                skinId = "skinFirst",
                type = "parent",
                componentId  = 0,
                currentIndex = 0,
                currentTextureIndex = 0,
                slider = false,
                disableSelect= true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 46
                    },
                    texture = {
                        min = 0,
                        max = 46
                    }
                },
            },
            {
                name = Config.Translate[Config.Lang].Parents.mother,
                id = "shapeSecond",
                skinId = "skinSecond",
                type = "parent",
                componentId  = 0,
                currentIndex = 0,
                currentTextureIndex = 0,
                disableSelect= true,
                slider = false,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 46
                    },
                    texture = {
                        min = 0,
                        max = 46
                    }
                },
            },
            {
                name = Config.Translate[Config.Lang].Parents.faceBlend,
                id = "shapeMix",
                type = "parent",
                componentId  = 0,
                currentIndex = 0,
                slider = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 10
                    }
                },
            },
            {
                name = Config.Translate[Config.Lang].Parents.skinBlend,
                id = "skinMix",
                type = "parent",
                componentId  = 0,
                currentIndex = 0,
                slider = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 10
                    }
                },
            },
            
        },
        ["clothing"] = {
            {
                name = Config.Translate[Config.Lang].Clothing.hat,
                componentId  = 0,
                currentIndex = GetPedPropIndex(ped, 0),
                currentTextureIndex = GetNumberOfPedPropTextureVariations(ped, 0, GetPedPropIndex(ped, 0)),
                componentSettings = getPropSettings(ped, 0),
                menuItems = getItems(getPropSettings(ped, 0).texture.max),
                type = "prop"
            },
            {
                name = Config.Translate[Config.Lang].Clothing.hair,
                componentId  = 2,
                currentIndex = GetPedDrawableVariation(ped, 2),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 2, GetPedDrawableVariation(ped, 2)),
                componentSettings = getComponentSettings(ped, 2),
                menuItems = getItems(getComponentSettings(ped, 2).texture.max),
            },
            {
                name = Config.Translate[Config.Lang].Clothing.body,
                componentId  = 11,
                currentIndex = GetPedDrawableVariation(ped, 11),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 11, GetPedDrawableVariation(ped, 11)),
                componentSettings = getComponentSettings(ped, 11)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.gloves,
                componentId  = 3,
                currentIndex = GetPedDrawableVariation(ped, 3),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 3, GetPedDrawableVariation(ped, 3)),
                componentSettings = getComponentSettings(ped, 3)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.tshirt,
                componentId  = 8,
                currentIndex = GetPedDrawableVariation(ped, 8),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 8, GetPedDrawableVariation(ped, 8)),
                componentSettings = getComponentSettings(ped, 8)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.pants,
                componentId  = 4,
                currentIndex = GetPedDrawableVariation(ped, 4),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 4, GetPedDrawableVariation(ped, 4)),
                componentSettings = getComponentSettings(ped, 4)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.shoes,
                componentId  = 6,
                currentIndex = GetPedDrawableVariation(ped, 6),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 6, GetPedDrawableVariation(ped, 6)),
                componentSettings = getComponentSettings(ped, 6)
            },
            {
                name = Config.Translate[Config.Lang].Clothing.sticker,
                componentId  = 10,
                currentIndex = GetPedDrawableVariation(ped, 10),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 10, GetPedDrawableVariation(ped, 10)),
                componentSettings = getComponentSettings(ped, 10)
            },
        },
        ["berber"] = {
            {
                name = Config.Translate[Config.Lang].Barber.hair,
                type = "hair",
                componentId  = 2,
                currentIndex = GetPedDrawableVariation(ped, 2),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 2, GetPedDrawableVariation(ped, 2)),
                componentSettings = getComponentSettings(ped, 2),
            },
            {
                name = Config.Translate[Config.Lang].Barber.hairColor.hairColor,
                isColor = true,
                type = "hair",
                colorLabel = Config.Translate[Config.Lang].Barber.hairColor.primaryHairColor,
                colors = getHairColors()[1],
                secondaryColorLabel = Config.Translate[Config.Lang].Barber.hairColor.secondaryHairColor,
                highlight = getHairColors()[1]
            },
            {
                name = Config.Translate[Config.Lang].Barber.fade,
                type = "fade",
                disableSelect = true,
                currentIndex = 0,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 75
                    }
                },
            },
            {
                name = Config.Translate[Config.Lang].Barber.eyebrows,
                type = "eyebrows",
                componentId = 2,
                currentIndex = 0,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 2),
            },
            {
                name = Config.Translate[Config.Lang].Barber.eyebrowsColor.eyebrowsColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Barber.eyebrowsColor.primaryEyebrowsColor,
                type = "makeup",
                id = 2,
                colors = getHairColors()[1],
                secondaryColorLabel = Config.Translate[Config.Lang].Barber.eyebrowsColor.secondaryEyebrowsColor,
                highlight = getHairColors()[1],
            },
            {
                name = Config.Translate[Config.Lang].Barber.beardColor.beard,
                type = "skin",
                componentId = 1,
                currentIndex = 0,
                currentTextureIndex = 10,
                componentSettings = getPedOverlaySettings(ped, 1),
            },
            {
                name = Config.Translate[Config.Lang].Barber.beardColor.beardColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Barber.beardColor.primaryBeardColor,
                type = "makeup",
                id = 1,
                colors = getHairColors()[1],
                secondaryColorLabel = Config.Translate[Config.Lang].Barber.beardColor.secondaryBeardColor,
                highlight = getHairColors()[1],
            },
            {
                name = Config.Translate[Config.Lang].Barber.chestHairColor.chestHair,
                type = "skin",
                componentId = 10,
                currentIndex = 0,
                currentTextureIndex = 10,
                componentSettings = getPedOverlaySettings(ped, 10),
            },
            {
                name = Config.Translate[Config.Lang].Barber.chestHairColor.chestHairColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Barber.chestHairColor.primaryChestColor,
                type = "makeup",
                id = 10,
                colors = getHairColors()[1],
                secondaryColorLabel = Config.Translate[Config.Lang].Barber.chestHairColor.secondaryChestHairColor,
                highlight = getHairColors()[1],
            },
        },
        ["makeup"] = {
            {
                name = Config.Translate[Config.Lang].Makeup.makeup,
                type = "makeup",
                componentId  = 4,
                currentIndex = getHeadOverlaySettings(ped, 4).overlayValue,
                currentTextureIndex = getHeadOverlaySettings(ped, 4).overlayOpacity,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 81
                    },
                    texture = {
                        min = 0,
                        max = 10
                    },
                }
            },
            {
                name = Config.Translate[Config.Lang].Makeup.makeupColor.makeupColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Makeup.makeupColor.primaryMakeupColor,
                type = "makeup",
                id = 4,
                colors = getHairColors()[2],
                secondaryColorLabel = Config.Translate[Config.Lang].Makeup.makeupColor.secondaryMakeupColor,
                highlight = getHairColors()[2],
            },
            {
                name = Config.Translate[Config.Lang].Makeup.rednessColor.redness,
                type = "makeup",
                componentId = 5,
                currentIndex = 0,
                currentTextureIndex = 0,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 34,
                    },
                    textures = {
                        min = 0,
                        max = 10,
                    },
                },
            },
            {
                name = Config.Translate[Config.Lang].Makeup.rednessColor.rednessColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Makeup.rednessColor.primaryRednessColor,
                type = "makeup",
                id = 5,
                colors = getHairColors()[2],
                secondaryColorLabel = Config.Translate[Config.Lang].Makeup.rednessColor.secondaryRednessColor,
                highlight = getHairColors()[2],
            },
            {
                name = Config.Translate[Config.Lang].Makeup.lipstickColor.lipstick,
                type = "makeup",
                componentId = 8,
                currentIndex = 0,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = GetNumberOfPedDrawableVariations(ped, 8),
                    },
                    textures = {
                        min = 0,
                        max = 10,
                    },
                },
            },
            {
                name = Config.Translate[Config.Lang].Makeup.lipstickColor.lipstickColor,
                isColor = true,
                colorLabel = Config.Translate[Config.Lang].Makeup.lipstickColor.primaryLipstickColor,
                type = "makeup",
                id = 8,
                colors = getHairColors()[2],
                secondaryColorLabel = Config.Translate[Config.Lang].Makeup.lipstickColor.secondaryLipstickColor,
                highlight = getHairColors()[2],
            },
        },
        ["aksesuar"] = {
            {
                name = "Mask",
                componentId  = 1,
                currentIndex = GetPedDrawableVariation(ped, 1),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 1, GetPedDrawableVariation(ped, 1)),
                componentSettings = getComponentSettings(ped, 1)
            },
            {
                name = "Glasses",
                componentId  = 1,
                currentIndex = GetPedPropIndex(ped, 1),
                currentTextureIndex = GetNumberOfPedPropTextureVariations(ped, 1, GetPedPropIndex(ped, 1)),
                componentSettings = getPropSettings(ped, 1)
            },
            {
                name = "Earring",
                componentId  = 2,
                currentIndex = GetPedPropIndex(ped, 2),
                currentTextureIndex = GetNumberOfPedPropTextureVariations(ped, 2, GetPedPropIndex(ped, 2)),
                componentSettings = getPropSettings(ped, 2)
            },
            {
                name = "Bow / Tie",
                componentId  = 7,
                currentIndex = GetPedDrawableVariation(ped, 7),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 7, GetPedDrawableVariation(ped, 7)),
                componentSettings = getComponentSettings(ped, 7)
            },
            {
                name = "Time",
                componentId  = 5,
                currentIndex = GetPedPropIndex(ped, 5),
                currentTextureIndex = GetNumberOfPedPropTextureVariations(ped, 5, GetPedPropIndex(ped, 5)),
                componentSettings = getPropSettings(ped, 5)
            },
            {
                name = "Vest",
                componentId  = 9,
                currentIndex = GetPedDrawableVariation(ped, 9),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 9, GetPedDrawableVariation(ped, 9)),
                componentSettings = getComponentSettings(ped, 9)
            },
            {
                name = "Bag",
                componentId  = 5,
                currentIndex = GetPedDrawableVariation(ped, 5),
                currentTextureIndex = GetNumberOfPedTextureVariations(ped, 5, GetPedDrawableVariation(ped, 5)),
                componentSettings = getComponentSettings(ped, 5)
            },
        },
        ["peds"] = {
            {
                name = "Male Character",
                type = "ped",
                currentIndex = 0,
                variant = "man",
                componentSettings = {
                    drawable = {
                      min = 0,
                      max = #Config.ManPlayerModels,
                    },
                }
            },
            {
                name = "Female Character",
                type = "ped",
                currentIndex = 1,
                variant = "woman",
                componentSettings = {
                    drawable = {
                      min = 1,
                      max = #Config.WomanPlayerModels,
                    },
                }
            },

            {
                name = "Face Skins",
                type = "pedface",
                currentIndex = 1,
                componentSettings = {
                    drawable = {
                      min = 1,
                      max = 10,
                    },

                    texture = {
                        min = 1,
                        max = 10,
                    },
                }
            },
        },
        ["face"] = {
            {
                name = Config.Translate[Config.Lang].Face.noseSettings.noseHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.width,
                        componentSettings = {
                            face_id = 0,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.height,
                        componentSettings = {
                            face_id = 1,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.length,
                        componentSettings = {
                            face_id = 2,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.curved,
                        componentSettings = {
                            face_id = 3,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },
                    
                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.front,
                        componentSettings = {
                            face_id = 4,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.noseSettings.boneSkew,
                        componentSettings = {
                            face_id = 5,
                            min = 0,
                            max = 19,
                        },
                        type = "face",
                        
                    },
                }
            },

            {
                name = Config.Translate[Config.Lang].Face.eyebrowsSettings.eyebrowsHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.eyebrowsSettings.height,
                        width = "full",
                        componentSettings = {
                            face_id = 6,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.eyebrowsSettings.depth,
                        width = "full",
                        componentSettings = {
                            face_id = 7,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },
            {
                name = Config.Translate[Config.Lang].Face.cheekboneSettings.cheekboneHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.cheekboneSettings.height,
                        width = "full",
                        componentSettings = {
                            face_id = 8,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.cheekboneSettings.width,
                        width = "full",
                        componentSettings = {
                            face_id = 9,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.cheekboneSettings.shortness,
                        width = "full",
                        componentSettings = {
                            face_id = 10,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },

            {
                name = Config.Translate[Config.Lang].Face.jawboneSettings.jawboneHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.jawboneSettings.width,
                        width = "full",
                        componentSettings = {
                            face_id = 13,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.jawboneSettings.height,
                        width = "full",
                        componentSettings = {
                            face_id = 14,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },

            {
                name = Config.Translate[Config.Lang].Face.jawSettings.jawHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.jawSettings.height,
                        componentSettings = {
                            face_id = 15,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.jawSettings.length,
                        componentSettings = {
                            face_id = 16,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.jawSettings.width,
                        componentSettings = {
                            face_id = 17,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },

                    {
                        name = Config.Translate[Config.Lang].Face.jawSettings.split,
                        componentSettings = {
                            face_id = 18,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },

            {
                name = Config.Translate[Config.Lang].Face.variousFeatures.variousFeaturesHeader,
                type = "face",
                multi = {
                    {
                        name = Config.Translate[Config.Lang].Face.variousFeatures.lipThickness,
                        componentSettings = {
                            face_id = 12,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.variousFeatures.eyeAperture,
                        componentSettings = {
                            face_id = 11,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                    {
                        name = Config.Translate[Config.Lang].Face.variousFeatures.neckThickness,
                        componentSettings = {
                            face_id = 19,
                            min = 0,
                            max = 19,
                        },
                        type = "face", 
                    },
                }
            },

        },
        ["skin"] = {
            {
                name = Config.Translate[Config.Lang].Skin.freckles,
                componentId  = 0,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 0),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.wrinkle,
                componentId  = 3,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 3),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.skinColor,
                componentId  = 6,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 6),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.sunBurn,
                componentId  = 7,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 6),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.moles,
                componentId  = 9,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 9),
                type = "skin"
            },

            {
                name = Config.Translate[Config.Lang].Skin.bodySpots,
                componentId  = 11,
                currentIndex = 1,
                disableSelect = true,
                currentTextureIndex = 0,
                componentSettings = getPedOverlaySettings(ped, 11),
                type = "skin"
            },
        },
        ["tattoo"] = {
            {
                name = Config.Translate[Config.Lang].TattooShop.torso,
                tattooId = "ZONE_TORSO",
                componentId  = 1,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 117
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.head,
                tattooId = "ZONE_HEAD", 
                componentId  = 2,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 22
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.leftArm,
                tattooId = "ZONE_LEFT_ARM", 
                componentId  = 3,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 44
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.rightArm,
                tattooId = "ZONE_RIGHT_ARM", 
                componentId  = 4,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 44
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.leftLeg,
                tattooId = "ZONE_LEFT_LEG", 
                componentId  = 5,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 21
                    },
                },
                type = "tattoo"
            },
            {
                name = Config.Translate[Config.Lang].TattooShop.rightLeg,
                tattooId = "ZONE_RIGHT_LEG", 
                componentId  = 6,
                currentIndex = 0,
                disableSelect = true,
                componentSettings = {
                    drawable = {
                        min = 0,
                        max = 16
                    },
                },
                type = "tattoo"
            },
        },
    }


    cb(menus[data])
end)


function OpenShops(type)
    local playerPed = PlayerPedId()
    playerApperance = getPedAppearance(playerPed)

    reverseCamera = false;
    isCameraInterpolating = false;

    FreezeEntityPosition(playerPed, true)
    exports["ev-clothes"]:setCamera(2)

    if type == "barber" then
        SendReactMessage("setCurrentShop", "parent")
        SendReactMessage("setSubMenus", Config.SubMenus["all"])
    else
        SendReactMessage("setCurrentShop", type)
        SendReactMessage("setSubMenus", Config.SubMenus[type])
    end
    toggleNuiFrame(true)
    RenderScriptCams(true, false, 0, true, true);
    DisplayRadar(false)
end

RegisterNUICallback("changeHairColor", function(data)
    local ped = PlayerPedId()
    if data.type == "hair" then
        SetPedHairColor(ped, data.currentIndex, data.currentTextureIndex)
    elseif data.type == "makeup" then
        SetPedHeadOverlayColor(ped, data.id, 1, data.currentIndex, data.currentTextureIndex)
    end
end)

local testoCat = {
    {"ZONE_TORSO", 0},
    {"ZONE_HEAD", 0},
    {"ZONE_LEFT_ARM", 0},
    {"ZONE_RIGHT_ARM", 0},
    {"ZONE_LEFT_LEG", 0},
    {"ZONE_RIGHT_LEG", 0},
    {"ZONE_UNKNOWN", 0},
    {"ZONE_NONE", 0},
}

function SetSkin(model, setDefault)
    -- TODO: If not isCop and model not in copModellist, do below.
    -- Model is a hash, GetHashKey(modelName)
    SetEntityInvincible(PlayerPedId(),true)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        player = PlayerPedId()
        FreezePedCameraRotation(player, true)
        if setDefault and model ~= nil then
            if (model ~= `mp_f_freemode_01` and model ~= `mp_m_freemode_01`) then
                SetPedRandomComponentVariation(PlayerPedId(), true)
            else
                SetPedHeadBlendData(player, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
                SetPedComponentVariation(player, 11, 0, 11, 0)
                SetPedComponentVariation(player, 8, 0, 1, 0)
                SetPedComponentVariation(player, 6, 1, 2, 0)
                SetPedHeadOverlayColor(player, 1, 1, 0, 0)
                SetPedHeadOverlayColor(player, 2, 1, 0, 0)
                SetPedHeadOverlayColor(player, 4, 2, 0, 0)
                SetPedHeadOverlayColor(player, 5, 2, 0, 0)
                SetPedHeadOverlayColor(player, 8, 2, 0, 0)
                SetPedHeadOverlayColor(player, 10, 1, 0, 0)
                SetPedHeadOverlay(player, 1, 0, 0.0)
                SetPedHairColor(player, 1, 1)
            end
        end
    end
    SetEntityInvincible(PlayerPedId(),false)
end

RegisterNUICallback("changeClothe", function(data, cb)
    local ped = PlayerPedId()
    if data.componentSettings.component_id then
        setPedComponent(ped, data, cb)
    elseif data.componentSettings.prop_id then
        setPedProp(ped, data)
    elseif data.type == "ped" then
        setPlayerModel(ped, data)
    elseif data.type == "pedface" then
        SetPedComponentVariation(PlayerPedId(), 0, data.currentIndex, data.currentTextureIndex, 0)
    elseif data.type == "parent" then
        setPlayerHeadFeature(ped, data)
    elseif data.type == "face" then
        setPlayerFaceFeature(ped, data)
    elseif data.type == "skin" then
        SetPedHeadOverlay(ped, data.componentSettings.overlay_id, data.currentIndex, data.currentTextureIndex  / 10)
    elseif data.type == "hair" then
        SetPedComponentVariation(ped, data.componentId, data.currentIndex, data.currentTextureIndex, 0)
    elseif data.type == "fade" then
        local charHair = GetPedDrawableVariation(ped, 2)
        local charGender = "m"
        local playerSex = RPC.execute("ev-clothes:getPlayerGender")
        if playerSex == 0 then
            charGender = "m"
        else
            charGender = "f"
        end

        ClearPedDecorations(ped)
        if hairDecor[charGender][charHair] ~= nil then
            AddPedDecorationFromHashes(ped, hairDecor[charGender][data.currentIndex][1], hairDecor[charGender][data.currentIndex][2])
            currentFadeStyle[charGender] = {
                first = hairDecor[charGender][data.currentIndex][1],
                second = hairDecor[charGender][data.currentIndex][2]
            }
        else
            AddPedDecorationFromHashes(ped, hairDecorDefault[data.currentIndex], hairDecorDefault[data.currentIndex])
        end
    elseif data.type == "eyebrows" then
        SetPedHeadOverlay(ped, data.componentId, data.currentIndex, data.currentTextureIndex / 10)
    elseif data.type == "makeup" then
        SetPedHeadOverlay(ped, data.componentId, data.currentIndex, 1.0)
        SetPedHeadOverlayColor(ped, data.componentId, 1, data.currentTextureIndex, 0)
    elseif data.type == "tattoo" then
        SetTats(tattoosList, data.tattooId, data.currentIndex)
    end
end)

RegisterNUICallback("getComponentSettings", function(data, cb)
    local ped = PlayerPedId()
    if data.componentSettings.component_id then
        cb(getComponentSettings(ped, data.componentSettings.component_id))
    elseif data.componentSettings.prop_id then
        cb( getPropSettings(ped,data.componentSettings.prop_id) )
    elseif data.type == "ped" then
        setPlayerModel(ped, data)
    end
end)

RegisterCommand('sas', function()
    TriggerServerEvent('ev-clothes:saveSkin', getPedAppearance(PlayerPedId()))
end)

RegisterCommand('yenile', function(source, args, rawCommand)
    TriggerServerEvent("ev-clothes:loadPlayerSkin", PlayerPedId())
end)

RegisterNetEvent('ev-clothes:loadSkin')
AddEventHandler('ev-clothes:loadSkin', function(ped, data)
    setPedAppearance(ped, data)
end)

RegisterNetEvent("ev-clothes:openClothing", OpenShops)

function isPedMale(ped)
    local entityModel = GetEntityModel(ped);
    local freemodeMale = GetHashKey('mp_m_freemode_01');
  
    return entityModel == freemodeMale;
end

function GetTats()
    local tempTats = {}
    if currentTats == nil then return {} end
    for i = 1, #currentTats do
        for key in pairs(tattooHashList) do
            for j = 1, #tattooHashList[key] do
                if tattooHashList[key][j][1] == currentTats[i][2] then
                    tempTats[key] = j
                end
            end
        end
    end
    return tempTats
end

function SetTats(tattoos, id, index)
    local ped = PlayerPedId()
    local isMale = isPedMale(ped)
    local infos = tattoos[id][index]

    if not playerTattoos[id] then
        for k, v in pairs(playerTattoos) do
            AddPedDecorationFromHashes(ped, GetHashKey(v.collection), GetHashKey(v.hashMale))
        end
    else
        ClearPedDecorations(ped)
        Wait(100)      
        for k, v in pairs(playerTattoos) do
            AddPedDecorationFromHashes(ped, GetHashKey(v.collection), GetHashKey(v.hashMale))
        end
    end

    AddPedDecorationFromHashes(ped, GetHashKey(infos.collection), GetHashKey(infos.hashMale))  


    if playerTattoos[id] then
        table.insert(playerTattoos[id], {{
            collection = infos.collection,
            hash = infos.hashMale
        }})
    else
        playerTattoos[id] = {
            {            
                collection = infos.collection,
                hash = infos.hashMale
            }
        }
    end
end
