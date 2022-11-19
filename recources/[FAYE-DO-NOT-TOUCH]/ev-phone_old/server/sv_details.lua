RPC.register("getCharacterInfo", function(pSource, pCid)
    local data = Await(SQL.execute("SELECT * FROM characters WHERE id = @cid", {
        ["cid"] = pCid.param
    }))
 
    local licenses = Await(SQL.execute("SELECT * FROM user_licenses WHERE cid = @cid", {
        ["cid"] = pCid.param
    }))

    if not data then return false, "" end
    if not licenses then return false, "" end
    userlicenses = {}
    --print("yo")
    for k,v in pairs(licenses) do
        --print("for loop", k, v)
        local licensestatus = false
        if tonumber(v.status) == 1 then
            licensestatus = true
        end


        userlicenses[#userlicenses+1] = {
            type = v.type,
            status = licensestatus
        }
    end

    --print("return")

    return data[1].bank_id or 0, data[1].phone_number or 0, data[1].cash or 0, data[1].bank or 0, 0, userlicenses
end)