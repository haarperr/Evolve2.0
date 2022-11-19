Generic = {}
Generic.NPCS = {}

Generic.SpawnLocations = {
  -- vector4(620.48, 2752.6, 42.09 - 1.0, 359.94)
  vector4(-1605.03,-994.58,7.53 - 1.0,136.79),
}

Generic.ShopKeeperLocations = {
  vector4(-3037.773, 584.8989, 6.97, 30.0),
  vector4(1960.64, 3739.03, 31.50, 321.36),
  vector4(1393.84,3606.8,33.99,172.8),
  vector4(549.01,2672.44,41.16,122.33),
  vector4(2558.39,380.74,107.63,21.54),
  vector4(-1819.57,793.59,137.09,134.3),
  vector4(-1221.26,-907.92,11.3,54.44),
  vector4(-706.12,-914.56,18.22,94.66),
  vector4(24.47,-1348.47,28.5,298.26),
  vector4(-47.36,-1758.68,28.43,50.84),
  vector4(1164.95,-323.7,68.21,101.73),
  vector4(372.19,325.74,102.57,276.17),
  vector4(2678.63,3278.86,54.25,344.4),
  vector4(1727.3,6414.27,34.04,259.1),
  vector4(-160.56,6320.76,30.59,319.99),
  vector4(1165.29,2710.85,37.16,178.47),
  vector4(1697.23,4923.42,41.07,327.94),
  vector4(159.84,6640.89,30.7,242.18),
  vector4(-1486.81,-377.38,39.17,143.01),
  vector4(-3241.1,999.93,11.84,10.23),
  vector4(-2966.38,391.79,14.05,99.55),
  vector4(1134.29,-983.39,45.42,292.7)
}

Generic.SportShopLocations = {
  vector4(-679.46, 5839.32, 16.34, 218.69),
}

Generic.CasinoLocations = {
  {
    coords = vector4(1087.97,221.13,-50.2,184.64), -- coat check
    flags = { "isCasinoMembershipGiver" },
  },
  {
    coords = vector4(1129.99,275.29,-52.04,270.69), -- rest room 1
  },
  {
    coords = vector4(1157.45,247.93,-52.04,2.02), -- rest room 2
  },
  {
    coords = vector4(1100.64,195.64,-50.44,314.95), -- jewel store
  },
  {
    coords = vector4(1117.42,219.91,-50.38,85.22), -- casino chips
    flags = { "isCasinoChipSeller" },
  },
  {
    coords = vector4(1109.61,229.28,-50.63,220.93), -- wheel of fortune
  },
  {
    coords = vector4(1110.2,208.29,-50.44,82.67), -- drinks bar
    flags = { "isCasinoDrinkGiver" },
  },
}

Generic.WeaponShopLocations = {
  vector4(18.405214, -1107.799, 28.900189, 155.5359),
  vector4(1697.8782, 3757.5742, 33.705394, 131.57858),
  vector4(813.32147, -2155.235, 28.619213, 359.52685),
  vector4(247.11634, -51.46736, 68.941253, 335.71105),
  vector4(840.95526, -1029.181, 27.194877, 270.98162),
  vector4(-326.3847, 6081.5922, 30.454809, 137.66893),
  vector4(-659.0343, -939.3759, 20.829368, 82.845191),
  vector4(-1310.523, -394.3834, 35.695827, 342.87866),
  vector4(-1112.808, 2697.7214, 17.556976, 133.08863),
  vector4(2564.7326, 298.35971, 107.73506, 270.29769),
  vector4(-3167.443, 1087.0684, 19.838766, 157.01432),
}

Generic.ToolShopLocations = {
  vector4(44.838947296143, -1748.5364990234, 28.549386978149, 35.3),
  vector4(2749.2309570313, 3472.3308105469, 54.679393768311, 244.4),
}

Generic.GemShopLocations = {
  vector4(-549.58,-618.83,33.72,178.55),
}

Generic.WeedShopLocations = {
  vector4(1175.49, -437.54, 65.9, 262.06),
}

Generic.JobVehLocations = {
  vector4(-50.2,-1089.03,25.48,154.36),
}

Generic.WineryBuyLocations = {
  vector4(-1928.02,2060.22,139.85,308.35),
}

Generic.LicenseBuyLocations = {
  vector4(-540.57,-191.22,37.23,119.25),
}

Generic.MobilePhoneUsers = {
  vector4(726.82,-1074.63,21.25,283.09),
  vector4(729.65,-1069.9,21.25,176.13),
  -- vector4(480.13,-1312.7,28.25,193.05),
}

Generic.VehicleShopKeepersData = {
  {
    id = "bike_shop",
    model = "a_m_y_beach_02",
    location = vector4(-1109.4,-1694.36,3.5,308.3),
  },
  {
    id = "veh_rental",
    model = "a_m_y_business_02",
    location = vector4(110.59,-1090.72,28.31,17.39),
  },
  {
    id = "boat_shop",
    model = "s_m_y_grip_01",
    location = vector4(-874.3,-1325.08,0.61,87.95),
  },
  {
    id = "air_shop",
    model = "s_m_y_pilot_01",
    location = vector4(-1620.67,-3151.72,13.0,8.23),
  }
}

-- Generic.NPCS[#Generic.NPCS + 1] = {
--   id = "pawnshop",
--   name = "Pawn Shop",
--   pedType = 4,
--   model = "s_m_y_ammucity_01",
--   networked = false,
--   distance = 200.0,
--   position = {
--     coords = vector3(0.0, 0.0, 0.0),
--     heading = 0.0,
--     random = true
--   },
--   appearance = '{"eyebrow":{"params":[2,0,0.0],"mode":"overlay"},"skinproblem":{"params":[6,0,0.0],"mode":"overlay"},"freckles":{"params":[9,0,0.0],"mode":"overlay"},"badges":{"params":[10,0,0,1],"mode":"component"},"arms":{"params":[3,0,0,1],"mode":"component"},"hat":{"params":[0,-1,-1,1],"mode":"prop"},"beard_color":{"params":[2,0,0,0,0],"mode":"overlaycolor"},"kevlar":{"params":[9,0,0,1],"mode":"component"},"bag":{"params":[5,0,0,1],"mode":"component"},"undershirt":{"params":[8,0,0,1],"mode":"component"},"wrinkles":{"params":[3,0,0.0],"mode":"overlay"},"shoes":{"params":[6,0,0,1],"mode":"component"},"legs":{"params":[4,0,0,1],"mode":"component"},"watch":{"params":[6,-1,-1,1],"mode":"prop"},"haircolor":{"params":[-1,-1],"mode":"haircolor"},"bracelet":{"params":[7,-1,-1,1],"mode":"prop"},"torso":{"params":[11,0,0,1],"mode":"component"},"hair":{"params":[2,0,0,1],"mode":"component"},"glasses":{"params":[1,-1,-1,1],"mode":"prop"},"mask":{"params":[1,0,0,1],"mode":"component"},"beard":{"params":[1,0,0.0],"mode":"overlay"},"accesory":{"params":[7,0,0,1],"mode":"component"},"eyecolor":{"params":[-1],"mode":"eyecolor"},"face":{"params":[0,0,0,1],"mode":"component"},"ears":{"params":[2,-1,-1,1],"mode":"prop"}}',
--   settings = {
--       { mode = "invincible", active = true },
--       { mode = "ignore", active = true },
--       { mode = "freeze", active = true }
--   },
--   flags = {
--       ['isNPC'] = true,
--       ['isPawnBuyer'] = true
--   }
-- }
--[[Generic.NPCS[#Generic.NPCS + 1] = {
  id = "pawnshop",
  name = "Pawn Shop",
  pedType = 4,
  model = "s_m_y_dealer_01",
  networked = false,
  distance = 200.0,
  position = {
    coords = vector3(0.0, 0.0, 0.0),
    heading = 0.0,
    random = true
  },
  appearance = '{"eyebrow":{"params":[2,0,0.0],"mode":"overlay"},"skinproblem":{"params":[6,0,0.0],"mode":"overlay"},"freckles":{"params":[9,0,0.0],"mode":"overlay"},"badges":{"params":[10,0,0,1],"mode":"component"},"arms":{"params":[3,0,0,1],"mode":"component"},"hat":{"params":[0,-1,-1,1],"mode":"prop"},"beard_color":{"params":[2,0,0,0,0],"mode":"overlaycolor"},"kevlar":{"params":[9,0,0,1],"mode":"component"},"bag":{"params":[5,0,0,1],"mode":"component"},"undershirt":{"params":[8,0,0,1],"mode":"component"},"wrinkles":{"params":[3,0,0.0],"mode":"overlay"},"shoes":{"params":[6,0,0,1],"mode":"component"},"legs":{"params":[4,0,0,1],"mode":"component"},"watch":{"params":[6,-1,-1,1],"mode":"prop"},"haircolor":{"params":[-1,-1],"mode":"haircolor"},"bracelet":{"params":[7,-1,-1,1],"mode":"prop"},"torso":{"params":[11,0,0,1],"mode":"component"},"hair":{"params":[2,0,0,1],"mode":"component"},"glasses":{"params":[1,-1,-1,1],"mode":"prop"},"mask":{"params":[1,0,0,1],"mode":"component"},"beard":{"params":[1,0,0.0],"mode":"overlay"},"accesory":{"params":[7,0,0,1],"mode":"component"},"eyecolor":{"params":[-1],"mode":"eyecolor"},"face":{"params":[0,0,0,1],"mode":"component"},"ears":{"params":[2,-1,-1,1],"mode":"prop"}}',
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
      ['isPawnBuyer'] = true
  }
}]]



Generic.NPCS[#Generic.NPCS + 1] = {
  id = "recycle_exchange",
  name = "Recycle Exchange",
  pedType = 4,
  model = "s_m_y_dwservice_01",
  networked = false,
  distance = 150.0,
  position = {
    coords = vector3(-355.84017944336, -1555.9376220703, 25.179180145264 -1),
    heading = 178.06901550293,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
      ['isPedShopRecycle'] = true
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "news_reporter",
  name = "News Reporter",
  pedType = 4,
  model = "a_m_m_paparazzi_01",
  networked = false,
  distance = 75.0,
  position = {
    coords = vector3(-598.85, -929.87, 22.87),
    heading = 83.47,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
      ['isCommonJobProvider'] = true
  }
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "head_stripper",
  name = "Head Stripper",
  pedType = 4,
  model = "csb_tonya",
  networked = false,
  distance = 25.0,
  position = {
    coords = vector3(110.98, -1297.22, 28.39),
    heading = 204.3,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true }
  },
  flags = {
      ['isNPC'] = true,
      ['isCommonJobProvider'] = true
  },
  scenario = "WORLD_HUMAN_SMOKING"
}


Generic.NPCS[#Generic.NPCS + 1] = {
  id = "paycheck_banker",
  name = "Bank Account Manager",
  pedType = 4,
  model = "cs_bankman",
  networked = false,
  distance = 25.0,
  position = {
    coords = vector3(242.020568847656, 227.114593505859, 106.031478881835),
    heading = 160.0,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
      { mode = "collision", active = true }
  },
  flags = {
      ['isNPC'] = true,
      ['isBankAccountManager'] = true
  },
  scenario = "PROP_HUMAN_SEAT_CHAIR_UPRIGHT"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "fish_market",
  name = "Fish Market",
  pedType = 4,
  model = "mp_m_weed_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-1507.338, 1504.958, 114.3),
    heading = 253.4327,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "fish_shop",
  name = "Fish Shop",
  pedType = 4,
  model = "ig_chef",
  networked = false,
  distance = 35.0,
  position = {
    coords = vector3(-1598.01,5200.89,4.38 - 1),
    heading = 73.401,
    random = true
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "boat_spawner",
  name = "Boat Spawn",
  pedType = 4,
  model = "csb_englishdave",
  networked = false,
  distance = 35.0,
  position = {
    coords = vector3(-806.87, -1497.12, 1.59 - 1), 
    heading = 285.00,
    random = true
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}


Generic.NPCS[#Generic.NPCS + 1] = {
  id = "carscrapeped",
  name = "Carscrap Ped",
  pedType = 4,
  model = "a_m_m_salton_04",
  networked = false,
  distance = 35.0,
  position = {
    coords = vector3(-218.85, -1368.73, 31.26 - 1), 
    heading = 25.45,
    random = true
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "isGarbageInst",
  name = "GARBAGE INST",
  pedType = 2,
  model = "s_m_y_garbage",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-321.55, -1546.16, 31.01 - 1.0),
    heading = 355.26,
},
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
    isNPC = true,
    isGarbageInst = true,
  },
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "coke_spawner",
  name = "Coke Spawn",
  pedType = 4,
  model = "s_m_m_pilot_02",
  networked = false,
  distance = 35.0,
  position = {
    coords = vector3(2121.2570800781, 4782.9345703125, 40.970268249512 - 1),
    heading = 322.08538818359,
    random = true
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_AA_SMOKE"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "digital_den_npc",
  name = "Digital Den",
  pedType = 4,
  model = "a_m_y_stwhi_02",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-656.85,-858.78,24.50 - 1),
    heading = 345.48,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_STAND_MOBILE_UPRIGHT"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "city_hall_npc_m",
  name = "City Hall Male",
  pedType = 4,
  model = "s_m_m_movprem_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-553.38,-192.37,38.21 - 1),
    heading = 209.45,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "city_hall_npc_f",
  name = "City Hall Female",
  pedType = 4,
  model = "ig_molly",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-551.37,-191.23,38.21 - 1),
    heading = 206.38,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "car_rental",
  name = "Car Rental",
  pedType = 4,
  model = "csb_popov",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(110.54,-1091.00,29.30 - 1),
    heading = 6.9090747833252,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "meth_enter",
  name = "meth_enter",
  pedType = 4,
  model = "g_m_m_chicold_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-259.221, -1535.840, 31.981 - 1),
    heading = 112.974,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_GUARD_STAND"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "meth_exit",
  name = "meth_exit",
  pedType = 4,
  model = "mp_m_meth_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(997.285, -3201.838, -36.393 - 1),
    heading = 313.844,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_GUARD_STAND"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "wean_laptop",
  name = "wean_laptop",
  pedType = 4,
  model = "ig_djtalignazio",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-1359.254, -760.668, 22.304 - 1),
    heading = 346.304,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
      isWean = true
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "reset_vault",
  name = "reset_vault",
  pedType = 4,
  model = "mp_m_securoguard_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(259.62, 218.05, 106.28 - 1),
    heading = 120.61,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "bike_rental",
  name = "bike_rental",
  pedType = 4,
  model = "a_m_y_gay_02",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(1635.2263183594, 2586.8859863281, 45.792892456055 - 1),
    heading = 356.6213684082,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}


Generic.NPCS[#Generic.NPCS + 1] = {
  id = "cop_veh",
  name = "cop_veh",
  pedType = 4,
  model = "s_m_y_cop_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(442.93109130859, -973.83795166016, 25.699853897095 - 1),
    heading = 200.93731689453,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}


Generic.NPCS[#Generic.NPCS + 1] = {
  id = "pawn_give_items",
  name = "Pawn Shop",
  pedType = 4,
  model = "s_m_y_dealer_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-278.75561523438, 2206.0366210938, 129.8599395752 - 1),
    heading = 65.663047790527,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
      ['isPawnBuyer'] = true
  },
  scenario = "WORLD_HUMAN_AA_SMOKE"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "scuba_boat",
  name = "scuba_boat",
  pedType = 4,
  model = "a_m_y_runner_02",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-1607.6905517578, 5264.7602539063, 3.9741053581238 - 1),
    heading = 157.43057250977,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
      ['isScuba'] = true
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "weed_buy",
  name = "weed_buy",
  pedType = 4,
  model = "a_f_y_hippie_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(1175.7839355469, -437.48831176758, 66.926574707031 - 1),
    heading = 256.32238769531,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
      ['isWeedBuy'] = true
  },
  scenario = "WORLD_HUMAN_AA_SMOKE"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "mine_sell",
  name = "mine_sell",
  pedType = 4,
  model = "s_m_y_construct_02",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-1463.947265625, -182.22857666016, 48.82568359375  - 1),
    heading = 34.015747070312,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
      isMineSells = true
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "garbage_man",
  name = "garbage_man",
  pedType = 4,
  model = "s_m_y_dockwork_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-354.22418212891, -1545.876953125, 27.712768554688  - 1),
    heading = 269.29135131836,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "ems_garage",
  name = "ems_garage",
  pedType = 4,
  model = "s_m_m_doctor_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(301.254, -574.746, 43.262 - 1),
    heading = 108.96,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}


Generic.NPCS[#Generic.NPCS + 1] = {
  id = "ditigal_den",
  name = "ditigal_den",
  pedType = 4,
  model = "cs_beverly",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(1137.61, -470.75, 66.66 - 1),
    heading = 256.44036865234,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
  scenario = "WORLD_HUMAN_CLIPBOARD"
}


Generic.NPCS[#Generic.NPCS + 1] = {
  id = "247deliveries",
  name = "247deliveries",
  pedType = 4,
  model = "cs_jimmydisanto",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(919.82, -1256.61, 25.51 - 1),
    heading = 41.18,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "tow_truck_yard",
  name = "tow_truck_yard",
  pedType = 4,
  model = "cs_paper",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-191.82, -1166.46, 23.67 - 1),
    heading = 313.69,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "dodo_logistics",
  name = "dodo_logistics",
  pedType = 4,
  model = "a_m_m_genfat_02",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-437.85, -2795.49, 7.29 - 1),
    heading = 55.99,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "jail_jobs",
  name = "jail_jobs",
  pedType = 4,
  model = "a_m_m_hillbilly_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(1775.42, 2553.27, 45.55 - 1),
    heading = 142.99,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "house_robberies",
  name = "house_robberies",
  pedType = 4,
  model = "a_m_m_hasjew_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(206.56, -1851.56, 27.48 - 1),
    heading = 146.14,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}

Generic.NPCS[#Generic.NPCS + 1] = {
  id = "fishing_location",
  name = "fishing_location",
  pedType = 4,
  model = "mp_m_exarmy_01",
  networked = false,
  distance = 50.0,
  position = {
    coords = vector3(-335.7744, 6105.9951, 31.447172 - 1),
    heading = 224.41415,
    random = false
  },
  appearance = nil,
  settings = {
      { mode = "invincible", active = true },
      { mode = "ignore", active = true },
      { mode = "freeze", active = true },
  },
  flags = {
      ['isNPC'] = true,
  },
}
