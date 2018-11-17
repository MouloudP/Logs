if SERVER then

  MsgC(Color(0, 76, 153), "-- [Logs] Chargement Coté Serveur...\n")

  local files = file.Find("logsm/shared/*.lua","LUA")

  for _, file in ipairs( files ) do

    AddCSLuaFile("logsm/shared/" .. file)
    include("logsm/shared/" .. file)

  end

  local files = file.Find("logsm/server/*.lua","LUA")

  for _, file in ipairs( files ) do

    include("logsm/server/" .. file)

  end

  local files = file.Find("logsm/client/*.lua","LUA")

  for _, file in ipairs( files ) do

    AddCSLuaFile("logsm/client/" .. file)

  end

  MsgC(Color(0, 76, 153), "-- [Logs] Chargement Coté Serveur...\n")

end

if CLIENT then

  local files = file.Find("logsm/client/*.lua","LUA")

  for _, file in ipairs( files ) do

    include("logsm/client/" .. file)

  end

  local files = file.Find("logsm/shared/*.lua","LUA")

  for _, file in ipairs( files ) do

    include("logsm/shared/" .. file)

  end

end
