RegisterNUICallback('getInfoData', function(_, cb)
  local characterId = exports["isPed"]:isPed("cid")
  local bankid, phonenr, cash, bank, casino, licenses = RPC.execute("getCharacterInfo", characterId)
  cb({
    cid = characterId,
    bankid = bankid,
    phonenumber = phonenr,
    cash = cash,
    bank = bank,
    casino = casino,
    licenses = licenses
  })
end)