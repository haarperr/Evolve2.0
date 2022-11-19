function getJsonDataFromAdminBans()
    local imDoneNow = RPC.execute("ev-adminUI:getRecentBans")
    return imDoneNow
  end
  
  exports('getJsonDataFromAdminBans',getJsonDataFromAdminBans)
  