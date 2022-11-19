local GeneralEntries, SubMenu = MenuEntries['general'], {}

local Buying = {
    {
        id = 'ev-fuel:pdmmenushit',
        title = "Set Commission",
        icon = "#drivinginstructor-drivingtest",
        event = "ev-fuel:pdmmenushit"
    },
    {
        id = 'ev-pdm:testdrivepdm',
        title = "Enable Test Drive",
        icon = "#drivinginstructor",
        event = "ev-pdm:testdrivepdm"
    },
    {
        id = 'ev-pdm:enableBuypdm',
        title = "Enable Purchase",
        icon = "#animation-money",
        event = "ev-pdm:enableBuypdm"
    },
}

Citizen.CreateThread(function()
    for index, data in ipairs(Buying) do
        SubMenu[index] = data.id
        MenuItems[data.id] = {data = data}
    end

    GeneralEntries[#GeneralEntries+1] = {
        data = {
            id = "Buying",
            icon = "#car",
            title = "PDM" 
        },
        subMenus = SubMenu,
        isEnabled = function(pEntity, pContext)
            return (isPDM)
        end,
    }
end)