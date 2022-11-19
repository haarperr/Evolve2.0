
MenuData = {
  apartment_check = {
    {
      title = "Apartment",
      description = "Forclose Apartment",
      key = "judge",
      children = {
          { title = "Yes", action = "ev-apartments:handler", key = { forclose = true} },
          { title = "No", action = "ev-apartments:handler", key = { forclose = false } },
      }
    }
  }
}
