util.AddNetworkString("Logs::OpenMenu")
util.AddNetworkString("Logs::ChoosePlayer")
util.AddNetworkString("Logs::ChoosePlayerSend")
util.AddNetworkString("Logs::ChoosePlayerSendSteam")
util.AddNetworkString("Logs::ChatAddText")
util.AddNetworkString("Logs::UpLogs")

local function timeToStr( time )
  local tnp = time
  local s = tnp % 60
  tnp = math.floor(tnp / 60)
  local m = tnp % 60
  tnp = math.floor(tnp / 60)
  local h = tnp % 24 + 2
  tnp = math.floor(tnp / 24)


  return string.format("%02i:%02i:%02i", h, m, s )
end

hook.Add("PlayerInitialSpawn","PlayerInitialSpawn::LogsAdd", function(ply)

  local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a rejoint le serveur", Categorie = "Spawn", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)

hook.Add("PlayerDeath","PlayerDeath::LogsAdd", function(victim, ent, attacker)

  local tbl = {}

  if victim == attacker or attacker:IsWorld() then

    tbl.info = {text1 = "Le Joueur " .. victim:Nick() .. " [" .. team.GetName(victim:Team()) .. "]" .. " s'est suicidé !", Categorie = "Death", time = timeToStr(os.time()), Concerné ={victim:SteamID()}}
    if istable(logs.Player[victim:SteamID()]) then
      table.insert(logs.Player[victim:SteamID()],tbl.info)
    else
      logs.Player[victim:SteamID()] = {}
      table.insert(logs.Player[victim:SteamID()],tbl.info)
    end

  else

    if not victim:IsPlayer() or not attacker:IsPlayer() then return end

    tbl.info = {text1 = "Le Joueur " .. victim:Nick() .. " [" .. team.GetName(victim:Team()) .. "]" .. " s'est fait tuer par " .. attacker:Nick() .. " [" .. team.GetName(attacker:Team()) .. "]" .. " avec une " .. attacker:GetActiveWeapon():GetClass(), Categorie = "Death", time = timeToStr(os.time()), Concerné ={victim:SteamID(), attacker:SteamID()}}

    if istable(logs.Player[victim:SteamID()]) then
      table.insert(logs.Player[victim:SteamID()],tbl.info)
    else
      logs.Player[victim:SteamID()] = {}
      table.insert(logs.Player[victim:SteamID()],tbl.info)
    end

    if istable(logs.Player[attacker:SteamID()]) then
      table.insert(logs.Player[attacker:SteamID()],tbl.info)
    else
      logs.Player[attacker:SteamID()] = {}
      table.insert(logs.Player[attacker:SteamID()],tbl.info)
    end

  end

  table.insert(logs.All,tbl.info)

end)

hook.Add("PlayerSpawn","PlayerSpawn::LogsAdd", function(ply)

  local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a Respawn", Categorie = "Respawn", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)

hook.Add("EntityTakeDamage","EntityTakeDamage::LogsAdd", function(victim, dmginfo)

  local attacker = dmginfo:GetAttacker()

  if not attacker:IsPlayer() or not victim:IsPlayer() then return end

  if victim == dmginfo:GetAttacker() then return end

  local tbl = {text1 = "Le Joueur " .. victim:Nick() .. " [" .. team.GetName(victim:Team()) .. "][" .. victim:GetActiveWeapon():GetClass() .. "] a pris " .. dmginfo:GetDamage() .. " de dégats par " .. attacker:Nick() .. " [" .. team.GetName(attacker:Team()) .. "][" .. attacker:GetActiveWeapon():GetClass() .. "]", Categorie = "damage1", time = timeToStr(os.time()), Concerné ={victim:SteamID(), attacker:SteamID()}}

  if istable(logs.Player[victim:SteamID()]) then
    table.insert(logs.Player[victim:SteamID()],tbl)
  else
    logs.Player[victim:SteamID()] = tbl
  end

  if istable(logs.Player[attacker:SteamID()]) then
    table.insert(logs.Player[attacker:SteamID()],tbl)
  else
    logs.Player[attacker:SteamID()] = {}
    table.insert(logs.Player[attacker:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)

hook.Add("PlayerDisconnected","PlayerDisconnected::LogsAdds", function(ply)

  local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a déconnecté", Categorie = "Disconnect", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)


hook.Add("playerDroppedMoney","playerDroppedMoney::LogsAdds", function(ply,amount)

  local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a jeté " .. amount .. "$", Categorie = "economie", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)


hook.Add("playerGaveMoney","playerGaveMoney::LogsAdds", function(ply,ply2,amount)

  local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a donné " .. amount .. "$ à " .. ply2:Nick() .. " [" .. team.GetName(ply2:Team()) .. "]", Categorie = "economie", time = timeToStr(os.time()), Concerné ={ply:SteamID(), ply2:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  if istable(logs.Player[ply2:SteamID()]) then
    table.insert(logs.Player[ply2:SteamID()],tbl)
  else
    logs.Player[ply2:SteamID()] = {}
    table.insert(logs.Player[ply2:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)


hook.Add("playerPickedUpMoney","playerPickedUpMoney::LogsAdds", function(ply,amount)

  local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a rammassé " .. amount .. "$", Categorie = "economie", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)

hook.Add("lockpickStarted","lockpickStarted::LogsAdds", function(ply,ent)

  if not ent:IsVehicle() then return end

  local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a commencer a lockipick la voiture de " .. ent:CPPIGetOwner():Nick() .. " [" .. team.GetName(ent:CPPIGetOwner():Team()) .. "]", Categorie = "lockpick", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)


hook.Add("OnPlayerChangedTeam","OnPlayerChangedTeam::LogsAdds", function(ply,old,new)

local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " est passé de " .. team.GetName(old) .. " à " .. team.GetName(new), Categorie = "teamchange", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)

hook.Add("onPlayerChangedName","onPlayerChangedName::LogsAdds", function(ply,old,new)

local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a changer de nom de " .. old .. " à " .. new, Categorie = "namechange", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)


hook.Add("PlayerSwitchWeapon","PlayerSwitchWeapon::LogsAdds", function(ply,old,new)

  if ply:Alive() then

    if not IsValid(old) then return end

    local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a changer d'arme : de [" .. old:GetClass() .. "] à [" .. new:GetClass() .. "]", Categorie = "changeweap", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

      if istable(logs.Player[ply:SteamID()]) then
        table.insert(logs.Player[ply:SteamID()],tbl)
      else
        logs.Player[ply:SteamID()] = {}
        table.insert(logs.Player[ply:SteamID()],tbl)
      end

      table.insert(logs.All,tbl)

    end

end)

hook.Add("playerArrested","playerArrested::LogsAdds", function(ply,time,ply2)

  local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]" .. " a été arrété pendant " .. time .. "s par " .. ply2:Nick() .. " [" .. team.GetName(ply2:Team()) .. "]", Categorie = "arrest", time = timeToStr(os.time()), Concerné ={ply:SteamID(), ply2:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  if istable(logs.Player[ply2:SteamID()]) then
    table.insert(logs.Player[ply2:SteamID()],tbl)
  else
    logs.Player[ply2:SteamID()] = {}
    table.insert(logs.Player[ply2:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)

hook.Add("PlayerSay","PlayerSay::LogsAdds", function(ply,string)

local tbl = {text1 = "Le Joueur " .. ply:Nick() .. " a écrit : " .. string, Categorie = "sayp", time = timeToStr(os.time()), Concerné ={ply:SteamID()}}

  if istable(logs.Player[ply:SteamID()]) then
    table.insert(logs.Player[ply:SteamID()],tbl)
  else
    logs.Player[ply:SteamID()] = {}
    table.insert(logs.Player[ply:SteamID()],tbl)
  end

  table.insert(logs.All,tbl)

end)

hook.Add("PlayerSay","SayCommande::OpenMenu",function(ply,string)

  if string == logs.Config.CommandeLogs then

    if logs.Config.Groupe[ply:GetUserGroup()] then

      local tbl = {}

      ply.Numberlogs = 50

      for k, v in pairs(logs.All) do

        if k < ply.Numberlogs and k > ply.Numberlogs - 50 then

          table.insert(tbl,v)

        end

      end

      local tbl1 = util.TableToJSON(tbl)
      local tbl = util.Compress(tbl1)

      net.Start("Logs::OpenMenu")
      net.WriteFloat(#tbl1)
      net.WriteData(tbl, #tbl1)
      net.WriteFloat(ply.Numberlogs)
      net.WriteFloat(#logs.All)
      net.Send(ply)

      return ""

    end

  end

end)

net.Receive("Logs::ChoosePlayer",function(_,ply)

  if not logs.Config.Groupe[ply:GetUserGroup()] then return end

  if net.ReadBool() then

    local tbl = net.ReadTable()

    net.Start("Logs::ChoosePlayerSend")
    net.WriteFloat(tbl.id1)
    net.WriteTable(logs.Player[tbl.player:SteamID()])
    net.Send(ply)

  else

    local steam = net.ReadString()

    if istable(logs.Player[steam]) then

      net.Start("Logs::ChoosePlayerSendSteam")
      net.WriteTable(logs.Player[steam])
      net.Send(ply)

    else


      net.Start("Logs::ChatAddText")
      net.Send(ply)

    end

  end

end)

net.Receive("Logs::UpLogs",function(_,ply)

  local number = net.ReadFloat()

  ply.Numberlogs = ply.Numberlogs + number

  local tbl = {}

  for k, v in pairs(logs.All) do

    if k < ply.Numberlogs and k > ply.Numberlogs - 50 then

      table.insert(tbl,v)

    end

  end

  local tbl1 = util.TableToJSON(tbl)
  local tbl = util.Compress(tbl1)

  net.Start("Logs::OpenMenu")
  net.WriteFloat(#tbl1)
  net.WriteData(tbl, #tbl1)
  net.WriteFloat(ply.Numberlogs)
  net.WriteFloat(#logs.All)
  net.Send(ply)

end)
