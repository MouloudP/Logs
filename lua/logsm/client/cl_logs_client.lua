surface.CreateFont( "FontLogsServeur1", {
font = "Roboto",
size = ScrW() / 80,
weight = 1000,
})

surface.CreateFont( "FontLogsServeur2", {
    font = "Roboto",
    size = ScrW() / 87.27,
    weight = 1000,
})

surface.CreateFont( "FontLogsServeur3", {
    font = "Roboto",
    size = ScrW() / 80,
    weight = 1000,
})

surface.CreateFont( "FontLogsServeur4", {
    font = "Arial",
    size = ScrW() / 64,
    weight = 700,
})
surface.CreateFont( "FontLogsServeur5", {
    font = "Arial",
    size = ScrW() / 128,
    weight = 1000,
})

local foncti = {}
local User = {}

function foncti.timeToStr( time )
  local tnp = time
  local s = tnp % 60
  tnp = math.floor(tnp / 60)
  local m = tnp % 60
  tnp = math.floor(tnp / 60)
  local h = tnp % 24 + 2
  tnp = math.floor(tnp / 24)


  return string.format("%02i:%02i:%02i", h, m, s )
end

net.Receive("Logs::OpenMenu",function()

  local float = net.ReadFloat()
  local tbl1 = util.Decompress(net.ReadData(float))
  local tbl = util.JSONToTable(tbl1)
  local numberlogs = net.ReadFloat()
  local Max = net.ReadFloat()

  local menu_logs = {}

  menu_logs.BaseBox = vgui.Create("DFrame")
  menu_logs.BaseBox:SetSize(ScrW()/1.1, ScrH()/1.1)
  menu_logs.BaseBox:SetTitle("")
  menu_logs.BaseBox:ShowCloseButton(false)
  menu_logs.BaseBox:SetVisible(true)
  menu_logs.BaseBox:SetDraggable(true)
  menu_logs.BaseBox:MakePopup()
  menu_logs.BaseBox:Center()
  menu_logs.BaseBox.Paint = function(self,w,h)

      draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
      draw.RoundedBox(6, w/300, h/165, w/1.007, h/1.012, Color(255, 255, 255, 255))
      draw.RoundedBox(6, w / 45, h / 7.5, w / 6.8, h / 1.25, Color(107, 126, 255))
      draw.RoundedBox(6, w / 5.11, h / 7.5, w / 1.52, h / 1.25, Color(107, 126, 255))
      draw.RoundedBox(6, w / 1.16, h / 7.5, w / 8.3, h / 1.25, Color(107, 126, 255))
      draw.DrawText(logs.Config.Title, "FontLogsServeur4", w/2, h/50, Color(107, 126, 255), TEXT_ALIGN_CENTER)
      draw.DrawText(foncti.timeToStr(os.time()), "FontLogsServeur4", w/11, h/1.11, Color(255, 255, 255), TEXT_ALIGN_CENTER)
      draw.DrawText("Page : " .. numberlogs / 50, "FontLogsServeur4", w/2.5, h/1.05, Color(107, 126, 255), TEXT_ALIGN_CENTER)

  end

  foncti.Fonction1(menu_logs.BaseBox,tbl,1)

  menu_logs.close = vgui.Create("DButton", menu_logs.BaseBox)
  menu_logs.close:SetSize(ScrW()/30, ScrW()/80)
  menu_logs.close:SetPos(ScrW()/1.1 - menu_logs.close:GetWide() * 1.4, ScrH() / 120)
  menu_logs.close:SetText("")
  menu_logs.close:SetTextColor(Color(0,0,0,255))
  menu_logs.close.Paint = function(self,w,h)

      draw.RoundedBox(3, 0, 0, w, h, Color(107, 126, 255) )
      draw.DrawText("X", "FontLogsServeur4", w/2, h/200 - 4, Color(255, 255, 255), TEXT_ALIGN_CENTER)

  end

  menu_logs.close.DoClick = function()

      menu_logs.BaseBox:Remove()

  end

  menu_logs.panel3 = vgui.Create("DPanel", menu_logs.BaseBox)
  menu_logs.panel3:SetSize(menu_logs.BaseBox:GetWide() / 7, menu_logs.BaseBox:GetTall() / 1.3)
  menu_logs.panel3:SetPos(menu_logs.BaseBox:GetWide() / 40,menu_logs.BaseBox:GetTall() / 7)
  menu_logs.panel3.Paint = function(self, w, h)
  end


  menu_logs.scroll = vgui.Create("DScrollPanel", menu_logs.panel3)
  menu_logs.scroll:Dock(FILL)


  menu_logs.sbar = menu_logs.scroll:GetVBar()
  function menu_logs.sbar:Paint()end
  function menu_logs.sbar.btnUp:Paint() end
  function menu_logs.sbar.btnDown:Paint() end
  function menu_logs.sbar.btnGrip:Paint() end



  menu_logs.layout = vgui.Create("DIconLayout", menu_logs.scroll)
  menu_logs.layout:Dock(FILL)
  menu_logs.layout:SetSpaceY(5)
  menu_logs.layout:SetSpaceX(0)

  if numberlogs > 50 then

    menu_logs.LeftBoutton = vgui.Create("DButton", menu_logs.BaseBox)
    menu_logs.LeftBoutton:SetSize(menu_logs.BaseBox:GetWide() / 50, menu_logs.BaseBox:GetWide() / 50)
    menu_logs.LeftBoutton:SetPos(menu_logs.BaseBox:GetWide() / 3, menu_logs.BaseBox:GetTall() / 1.05)
    menu_logs.LeftBoutton:SetText("")
    menu_logs.LeftBoutton:SetTextColor(Color(0,0,0,255))
    menu_logs.LeftBoutton.BtnColor = 30
    menu_logs.LeftBoutton.HoverColor = Color(0,0,0)
    menu_logs.LeftBoutton.Lerp = 0
    menu_logs.LeftBoutton.LerpTxt = 0
    menu_logs.LeftBoutton.Paint = function(self,w,h)

      draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
      draw.RoundedBox(6, w/100, h/20, w/1.02, h/1.13, Color(255, 255, 255, 255))
      draw.DrawText("<", "FontLogsServeur4", w/2, h/10, Color(107, 126, 255), TEXT_ALIGN_CENTER)

    end


    menu_logs.LeftBoutton.DoClick = function()

      net.Start("Logs::UpLogs")
      net.WriteFloat(-50)
      net.SendToServer()
      menu_logs.BaseBox:Remove()

    end

  end

  if not (numberlogs + 50 > Max + 25) then

    menu_logs.RightBoutton = vgui.Create("DButton", menu_logs.BaseBox)
    menu_logs.RightBoutton:SetSize(menu_logs.BaseBox:GetWide() / 50, menu_logs.BaseBox:GetWide() / 50)
    menu_logs.RightBoutton:SetPos(menu_logs.BaseBox:GetWide() / 2.1, menu_logs.BaseBox:GetTall() / 1.05)
    menu_logs.RightBoutton:SetText("")
    menu_logs.RightBoutton:SetTextColor(Color(0,0,0,255))
    menu_logs.RightBoutton.BtnColor = 30
    menu_logs.RightBoutton.HoverColor = Color(0,0,0)
    menu_logs.RightBoutton.Lerp = 0
    menu_logs.RightBoutton.LerpTxt = 0
    menu_logs.RightBoutton.Paint = function(self,w,h)

      draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
      draw.RoundedBox(6, w/100, h/20, w/1.02, h/1.13, Color(255, 255, 255, 255))
      draw.DrawText(">", "FontLogsServeur4", w/2, h/10, Color(107, 126, 255), TEXT_ALIGN_CENTER)

    end

    menu_logs.RightBoutton.DoClick = function()

      net.Start("Logs::UpLogs")
      net.WriteFloat(50)
      net.SendToServer()
      menu_logs.BaseBox:Remove()

    end

  end


  for k,v in pairs(logs.Config.Categorie) do

    menu_logs.BouttonLogs = vgui.Create("DButton", menu_logs.layout)
    menu_logs.BouttonLogs:SetSize(menu_logs.panel3:GetWide(), menu_logs.panel3:GetTall() / 20)
    menu_logs.BouttonLogs:SetText("")
    menu_logs.BouttonLogs:SetTextColor(Color(0,0,0,255))
    menu_logs.BouttonLogs.BtnColor = 30
    menu_logs.BouttonLogs.HoverColor = Color(0,0,0)
    menu_logs.BouttonLogs.Lerp = 0
    menu_logs.BouttonLogs.LerpTxt = 0
    menu_logs.BouttonLogs.Paint = function(self,w,h)

      draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
      draw.RoundedBox(6, w/100, h/20, w/1.02, h/1.13, Color(255, 255, 255, 255))
      draw.DrawText(v.nom, "FontLogsServeur4", w/2, h/10, Color(107, 126, 255), TEXT_ALIGN_CENTER)

    end


    menu_logs.BouttonLogs.DoClick = function()

      foncti.Fonction1(menu_logs.BaseBox,tbl,k)

    end

  end

  menu_logs.RechercheAvancé = vgui.Create("DButton", menu_logs.BaseBox)
  menu_logs.RechercheAvancé:SetSize(menu_logs.panel3:GetWide(), menu_logs.panel3:GetTall() / 20)
  menu_logs.RechercheAvancé:SetPos(menu_logs.BaseBox:GetWide() / 5, menu_logs.BaseBox:GetTall() / 12 )
  menu_logs.RechercheAvancé:SetText("")
  menu_logs.RechercheAvancé:SetTextColor(Color(0,0,0,255))
  menu_logs.RechercheAvancé.BtnColor = 30
  menu_logs.RechercheAvancé.HoverColor = Color(0,0,0)
  menu_logs.RechercheAvancé.Lerp = 0
  menu_logs.RechercheAvancé.LerpTxt = 0
  menu_logs.RechercheAvancé.Paint = function(self,w,h)

    draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
    draw.RoundedBox(6, w/100, h/20, w/1.02, h/1.13, Color(255, 255, 255, 255))
    draw.DrawText("Recherche Avancé", "FontLogsServeur4", w/2, h/10, Color(107, 126, 255), TEXT_ALIGN_CENTER)

  end

  menu_logs.RechercheAvancé.DoClick = function()

    foncti.Fonction3(menu_logs.BaseBox,tbl)

  end

end)

function foncti.Fonction1(panel,tbl,id)

  local menu_logs = {}

    if IsValid(foncti.panelLogs) then

      foncti.panelLogs:Remove()

    end

    foncti.panelLogs = vgui.Create("DPanel", panel)
    foncti.panelLogs:SetSize(panel:GetWide() / 1.4, panel:GetTall() / 1.3)
    foncti.panelLogs:SetPos(panel:GetWide() / 5,panel:GetTall() / 7)
    foncti.panelLogs.Paint = function(self, w, h)
    end


    menu_logs.scroll = vgui.Create("DScrollPanel", foncti.panelLogs)
    menu_logs.scroll:Dock(FILL)


    menu_logs.sbar = menu_logs.scroll:GetVBar()
    function menu_logs.sbar:Paint()end
    function menu_logs.sbar.btnUp:Paint() end
    function menu_logs.sbar.btnDown:Paint() end
    function menu_logs.sbar.btnGrip:Paint() end



    menu_logs.layout = vgui.Create("DIconLayout", menu_logs.scroll)
    menu_logs.layout:Dock(FILL)
    menu_logs.layout:SetSpaceY(5)
    menu_logs.layout:SetSpaceX(0)

    for i,j in SortedPairs(tbl, true) do

      if j.Categorie == logs.Config.Categorie[id].sousnom or logs.Config.Categorie[id].sousnom == "all" then

        menu_logs.AllLogs = vgui.Create("DButton", menu_logs.layout)
        menu_logs.AllLogs:SetSize(foncti.panelLogs:GetWide() / 1.1, foncti.panelLogs:GetTall() / 17)
        menu_logs.AllLogs:SetText("")
        menu_logs.AllLogs.BtnColor = 30
        menu_logs.AllLogs.HoverColor = Color(0,0,0)
        menu_logs.AllLogs.Lerp = 0
        menu_logs.AllLogs.LerpTxt = 0
        menu_logs.AllLogs:SetTextColor(Color(0,0,0,255))
        menu_logs.AllLogs.Paint = function(self,w,h)


          draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
          draw.RoundedBox(6, w/300, h/20, w/1.007, h/1.1, Color(255, 255, 255, 255))

          draw.DrawText(j.time, "FontLogsServeur2", w/18, h/3.8, Color(107, 126, 255), TEXT_ALIGN_CENTER)
          draw.DrawText(j.text1, "FontLogsServeur1", w/2, h/4.7, Color(107, 126, 255), TEXT_ALIGN_CENTER)

        end

        menu_logs.AllLogs.DoClick = function()

          foncti.Fonction2(panel,i,tbl)

        end

      end

    end

 end

 function foncti.Fonction2(panel,id,tbl)

   local menu_logs = {}

     if IsValid(foncti.panelInfoOfPlayer) then

       foncti.panelInfoOfPlayer:Remove()

     end

     foncti.panelInfoOfPlayer = vgui.Create("DPanel", panel)
     foncti.panelInfoOfPlayer:SetSize(panel:GetWide() / 8.3, panel:GetTall() / 1.3)
     foncti.panelInfoOfPlayer:SetPos(panel:GetWide() / 1.155,panel:GetTall() / 7)
     foncti.panelInfoOfPlayer.Paint = function(self, w, h)
     end


     menu_logs.scrollInfo = vgui.Create("DScrollPanel", foncti.panelInfoOfPlayer)
     menu_logs.scrollInfo:Dock(FILL)


     menu_logs.sbarinfo = menu_logs.scrollInfo:GetVBar()
     function menu_logs.sbarinfo:Paint()end
     function menu_logs.sbarinfo.btnUp:Paint() end
     function menu_logs.sbarinfo.btnDown:Paint() end
     function menu_logs.sbarinfo.btnGrip:Paint() end



     menu_logs.layoutinfo = vgui.Create("DIconLayout", menu_logs.scrollInfo)
     menu_logs.layoutinfo:Dock(FILL)
     menu_logs.layoutinfo:SetSpaceY(5)
     menu_logs.layoutinfo:SetSpaceX(0)

     local tbljoueur = tbl[id]

     for number,p in pairs(tbljoueur.Concerné) do

       menu_logs.AllLogs = vgui.Create("DButton", menu_logs.layoutinfo)
       menu_logs.AllLogs:SetSize(foncti.panelInfoOfPlayer:GetWide() / 1.1, foncti.panelInfoOfPlayer:GetTall() / 12)
       menu_logs.AllLogs:SetText("")
       menu_logs.AllLogs.BtnColor = 30
       menu_logs.AllLogs.HoverColor = Color(0,0,0)
       menu_logs.AllLogs.Lerp = 0
       menu_logs.AllLogs.LerpTxt = 0
       menu_logs.AllLogs:SetTextColor(Color(0,0,0,255))
       menu_logs.AllLogs.Paint = function(self,w,h)


         draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
         draw.RoundedBox(6, w/300, h/20, w/1.007, h/1.1, Color(255, 255, 255, 255))

         draw.DrawText(p, "FontLogsServeur5", w/2, h/10, Color(107, 126, 255), TEXT_ALIGN_CENTER)

         if player.GetBySteamID(p) then

           draw.DrawText(player.GetBySteamID(p):Nick(), "FontLogsServeur5", w/2, h/2, Color(107, 126, 255), TEXT_ALIGN_CENTER)

         end

       end

       menu_logs.AllLogs.DoClick = function(self)

         self.menu = DermaMenu()
         self.menu:AddOption( "SteamID32", function() SetClipboardText( p )  end )
         self.menu:Open()

       end

    end

 end




function foncti.Fonction3(panel,tbl)

  local menu_logs = {}

  local joueurchoose = ""

  foncti.Panel = vgui.Create("DFrame", panel)
  foncti.Panel:SetSize(ScrW()/2, ScrH()/2)
  foncti.Panel:ShowCloseButton(false)
  foncti.Panel:SetVisible(true)
  foncti.Panel:SetDraggable(true)
  foncti.Panel:Center()
  foncti.Panel.Paint = function(self,w,h)

      draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
      draw.RoundedBox(6, w/300, h/165, w/1.007, h/1.012, Color(255, 255, 255, 255))
      draw.RoundedBox(6, w / 45, h / 7.5, w / 3.9, h / 1.25, Color(107, 126, 255))
      draw.RoundedBox(6, w / 2.5, h / 7.5, w / 1.9, h / 1.25, Color(107, 126, 255))
      draw.DrawText("Recherche Avancé", "FontLogsServeur4", w/2, h/50, Color(107, 126, 255), TEXT_ALIGN_CENTER)

      if joueurchoose != "" then
        draw.DrawText("Joueur Sélectionné : \n" .. joueurchoose:Nick(), "FontLogsServeur1", w/7, h/50, Color(107, 126, 255), TEXT_ALIGN_CENTER)
      end

  end

  menu_logs.close2 = vgui.Create("DButton", foncti.Panel)
  menu_logs.close2:SetSize(ScrW()/30, ScrW()/80)
  menu_logs.close2:SetPos(ScrW()/2 - menu_logs.close2:GetWide() * 1.4, ScrH() / 120)
  menu_logs.close2:SetText("")
  menu_logs.close2:SetTextColor(Color(0,0,0,255))
  menu_logs.close2.Paint = function(self,w,h)

      draw.RoundedBox(3, 0, 0, w, h, Color(107, 126, 255) )
      draw.DrawText("X", "FontLogsServeur4", w/2, h/200 - 4, Color(255, 255, 255), TEXT_ALIGN_CENTER)

  end

  menu_logs.close2.DoClick = function()

      foncti.Panel:Remove()

  end

  menu_logs.panelPlayer = vgui.Create("DPanel", foncti.Panel)
  menu_logs.panelPlayer:SetSize(foncti.Panel:GetWide() / 4, foncti.Panel:GetTall() / 1.3)
  menu_logs.panelPlayer:SetPos(foncti.Panel:GetWide() / 40,foncti.Panel:GetTall() / 7)
  menu_logs.panelPlayer.Paint = function(self, w, h)
    draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
  end


  menu_logs.scrollPlayer = vgui.Create("DScrollPanel", menu_logs.panelPlayer)
  menu_logs.scrollPlayer:Dock(FILL)


  menu_logs.sbarPlayer = menu_logs.scrollPlayer:GetVBar()
  function menu_logs.sbarPlayer:Paint()end
  function menu_logs.sbarPlayer.btnUp:Paint() end
  function menu_logs.sbarPlayer.btnDown:Paint() end
  function menu_logs.sbarPlayer.btnGrip:Paint() end



  menu_logs.layoutPlayer = vgui.Create("DIconLayout", menu_logs.scrollPlayer)
  menu_logs.layoutPlayer:Dock(FILL)
  menu_logs.layoutPlayer:SetSpaceY(5)
  menu_logs.layoutPlayer:SetSpaceX(0)

  menu_logs.SteamidSearh = vgui.Create("DButton", menu_logs.layoutPlayer)
  menu_logs.SteamidSearh:SetSize(menu_logs.panelPlayer:GetWide(), menu_logs.panelPlayer:GetTall() / 13)
  menu_logs.SteamidSearh:SetText("")
  menu_logs.SteamidSearh.BtnColor = 30
  menu_logs.SteamidSearh.HoverColor = Color(0,0,0)
  menu_logs.SteamidSearh.Lerp = 0
  menu_logs.SteamidSearh.LerpTxt = 0
  menu_logs.SteamidSearh:SetTextColor(Color(0,0,0,255))
  menu_logs.SteamidSearh.Paint = function(self,w,h)


    draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
    draw.RoundedBox(6, w/300, h/20, w/1.007, h/1.1, Color(255, 255, 255, 255))
    draw.DrawText("SteamID", "FontLogsServeur4", w/2, h/50, Color(107, 126, 255), TEXT_ALIGN_CENTER)

  end

  menu_logs.SteamidSearh.DoClick = function()

    foncti.Panel:Remove()
    foncti.Fonction4(panel,tbl)

  end

  for _,v in SortedPairs(player.GetAll(), true) do

    menu_logs.PlayerBoutton = vgui.Create("DButton", menu_logs.layoutPlayer)
    menu_logs.PlayerBoutton:SetSize(menu_logs.panelPlayer:GetWide(), menu_logs.panelPlayer:GetTall() / 13)
    menu_logs.PlayerBoutton:SetText("")
    menu_logs.PlayerBoutton.BtnColor = 30
    menu_logs.PlayerBoutton.HoverColor = Color(0,0,0)
    menu_logs.PlayerBoutton.Lerp = 0
    menu_logs.PlayerBoutton.LerpTxt = 0
    menu_logs.PlayerBoutton:SetTextColor(Color(0,0,0,255))
    menu_logs.PlayerBoutton.Paint = function(self,w,h)


      draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
      draw.RoundedBox(6, w/300, h/20, w/1.007, h/1.1, Color(255, 255, 255, 255))
      draw.DrawText(v:Nick(), "FontLogsServeur4", w/2, h/50, Color(107, 126, 255), TEXT_ALIGN_CENTER)

    end

    menu_logs.PlayerBoutton.DoClick = function()

      joueurchoose = v

    end

  end

  menu_logs.panelLogsPlayer = vgui.Create("DPanel", foncti.Panel)
  menu_logs.panelLogsPlayer:SetSize(foncti.Panel:GetWide() / 1.9, foncti.Panel:GetTall() / 1.3)
  menu_logs.panelLogsPlayer:SetPos(foncti.Panel:GetWide() / 2.45,foncti.Panel:GetTall() / 7)
  menu_logs.panelLogsPlayer.Paint = function(self, w, h)
  end


  menu_logs.scrollModule = vgui.Create("DScrollPanel", menu_logs.panelLogsPlayer)
  menu_logs.scrollModule:Dock(FILL)


  menu_logs.sbarModule = menu_logs.scrollModule:GetVBar()
  function menu_logs.sbarModule:Paint()end
  function menu_logs.sbarModule.btnUp:Paint() end
  function menu_logs.sbarModule.btnDown:Paint() end
  function menu_logs.sbarModule.btnGrip:Paint() end



  menu_logs.layoutModule = vgui.Create("DIconLayout", menu_logs.scrollModule)
  menu_logs.layoutModule:Dock(FILL)
  menu_logs.layoutModule:SetSpaceY(5)
  menu_logs.layoutModule:SetSpaceX(0)

  for i, j in pairs(logs.Config.Categorie) do

    menu_logs.PlayerBoutton = vgui.Create("DButton", menu_logs.layoutModule)
    menu_logs.PlayerBoutton:SetSize(menu_logs.panelLogsPlayer:GetWide(), menu_logs.panelLogsPlayer:GetTall() / 13)
    menu_logs.PlayerBoutton:SetText("")
    menu_logs.PlayerBoutton.BtnColor = 30
    menu_logs.PlayerBoutton.HoverColor = Color(0,0,0)
    menu_logs.PlayerBoutton.Lerp = 0
    menu_logs.PlayerBoutton.LerpTxt = 0
    menu_logs.PlayerBoutton:SetTextColor(Color(0,0,0,255))
    menu_logs.PlayerBoutton.Paint = function(self,w,h)


      draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
      draw.RoundedBox(6, w/300, h/20, w/1.007, h/1.1, Color(255, 255, 255, 255))
      draw.DrawText(j.nom, "FontLogsServeur4", w/2, h/50, Color(107, 126, 255), TEXT_ALIGN_CENTER)

    end

    menu_logs.PlayerBoutton.DoClick = function()

      if joueurchoose != "" then

        local tbl = {id1 = i, player = joueurchoose}

        net.Start("Logs::ChoosePlayer")
        net.WriteBool(true)
        net.WriteTable(tbl)
        net.SendToServer()

        User.Panel = panel
      --  foncti.Fonction5(panel,tbl,joueurchoose, i)

      end

    end

  end

end

function foncti.Fonction4(panel,tbl)

  local menu_logs = {}

  menu_logs.DTextEntrySupport = vgui.Create("DFrame", panel)
  menu_logs.DTextEntrySupport:SetSize(ScrW()/2, ScrH()/2)
  menu_logs.DTextEntrySupport:ShowCloseButton(false)
  menu_logs.DTextEntrySupport:SetVisible(true)
  menu_logs.DTextEntrySupport:SetDraggable(true)
  menu_logs.DTextEntrySupport:Center()
  menu_logs.DTextEntrySupport.Paint = function(self,w,h)

      draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
      draw.RoundedBox(6, w/300, h/165, w/1.007, h/1.012, Color(255, 255, 255, 255))
      draw.RoundedBox(6, w / 4.45, h / 6, w / 1.8, h / 2, Color(107, 126, 255))
      draw.DrawText("Recherche Avancé", "FontLogsServeur4", w/2, h/50, Color(107, 126, 255), TEXT_ALIGN_CENTER)
      draw.DrawText("Part SteamID32", "FontLogsServeur4", w/2, h/5.5, Color(255, 255, 255), TEXT_ALIGN_CENTER)

  end

  menu_logs.close2 = vgui.Create("DButton", menu_logs.DTextEntrySupport)
  menu_logs.close2:SetSize(ScrW()/30, ScrW()/80)
  menu_logs.close2:SetPos(ScrW()/2 - menu_logs.close2:GetWide() * 1.4, ScrH() / 120)
  menu_logs.close2:SetText("")
  menu_logs.close2:SetTextColor(Color(0,0,0,255))
  menu_logs.close2.Paint = function(self,w,h)

      draw.RoundedBox(3, 0, 0, w, h, Color(107, 126, 255) )
      draw.DrawText("X", "FontLogsServeur4", w/2, h/200 - 4, Color(255, 255, 255), TEXT_ALIGN_CENTER)

  end

  menu_logs.close2.DoClick = function()

      menu_logs.DTextEntrySupport:Remove()

  end

  menu_logs.DTextEntryLeVrai = vgui.Create("DTextEntry", menu_logs.DTextEntrySupport)
  menu_logs.DTextEntryLeVrai:SetSize(ScrW()/4, ScrH()/10)
  menu_logs.DTextEntryLeVrai:SetVisible(true)
  menu_logs.DTextEntryLeVrai:Center()
  menu_logs.DTextEntryLeVrai.Paint = function(self,w,h)

      draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
      draw.RoundedBox(6, w/300, h/165, w/1.007, h/1.012, Color(255, 255, 255, 255))
      draw.DrawText(self:GetValue(), "FontLogsServeur4", w/2, h/3.5, Color(107, 126, 255), TEXT_ALIGN_CENTER)

  end

  menu_logs.DTextEntryLeVrai.OnEnter = function()

      local steam = menu_logs.DTextEntryLeVrai:GetValue()

      net.Start("Logs::ChoosePlayer")
      net.WriteBool(false)
      net.WriteString(steam)
      net.SendToServer()
    --  foncti.Fonction7(panel, steam, tbl)
      menu_logs.DTextEntrySupport:Remove()

      User.Panel = panel

   end

end

--function foncti.Fonction5(panel,tbl,joueurchoose, id)

net.Receive("Logs::ChoosePlayerSend",function()

  local id = net.ReadFloat()
  local tbl = net.ReadTable()
  local panel = User.Panel

  local menu_logs = {}

  if IsValid(foncti.panelLogs) then

    foncti.panelLogs:Remove()

  end

  foncti.Panel:Remove()

  foncti.panelLogs = vgui.Create("DPanel", panel)
  foncti.panelLogs:SetSize(panel:GetWide() / 1.4, panel:GetTall() / 1.3)
  foncti.panelLogs:SetPos(panel:GetWide() / 5,panel:GetTall() / 7)
  foncti.panelLogs.Paint = function(self, w, h)
  end


  menu_logs.scroll = vgui.Create("DScrollPanel", foncti.panelLogs)
  menu_logs.scroll:Dock(FILL)


  menu_logs.sbar = menu_logs.scroll:GetVBar()
  function menu_logs.sbar:Paint()end
  function menu_logs.sbar.btnUp:Paint() end
  function menu_logs.sbar.btnDown:Paint() end
  function menu_logs.sbar.btnGrip:Paint() end



  menu_logs.layout = vgui.Create("DIconLayout", menu_logs.scroll)
  menu_logs.layout:Dock(FILL)
  menu_logs.layout:SetSpaceY(5)
  menu_logs.layout:SetSpaceX(0)

  for valeur,f in SortedPairs(tbl, true) do

    if not istable(f) then continue end

    if f.Categorie == logs.Config.Categorie[id].sousnom or logs.Config.Categorie[id].sousnom == "all" then

      menu_logs.AllLogs = vgui.Create("DButton", menu_logs.layout)
      menu_logs.AllLogs:SetSize(foncti.panelLogs:GetWide() / 1.1, foncti.panelLogs:GetTall() / 17)
      menu_logs.AllLogs:SetText("")
      menu_logs.AllLogs.BtnColor = 30
      menu_logs.AllLogs.HoverColor = Color(0,0,0)
      menu_logs.AllLogs.Lerp = 0
      menu_logs.AllLogs.LerpTxt = 0
      menu_logs.AllLogs:SetTextColor(Color(0,0,0,255))
      menu_logs.AllLogs.Paint = function(self,w,h)


        draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
        draw.RoundedBox(6, w/300, h/20, w/1.007, h/1.1, Color(255, 255, 255, 255))

        draw.DrawText(f.time, "FontLogsServeur2", w/18, h/3.8, Color(107, 126, 255), TEXT_ALIGN_CENTER)
        draw.DrawText(f.text1, "FontLogsServeur1", w/2, h/4.7, Color(107, 126, 255), TEXT_ALIGN_CENTER)

      end

      menu_logs.AllLogs.DoClick = function()

        foncti.Fonction2(panel,id,tbl)

      end

    end

  end

end)


function foncti.Fonction6(panel,tbl,id2)

  local menu_logs = {}

    if IsValid(foncti.panelInfoOfPlayer) then

      foncti.panelInfoOfPlayer:Remove()

    end

    foncti.panelInfoOfPlayer = vgui.Create("DPanel", panel)
    foncti.panelInfoOfPlayer:SetSize(panel:GetWide() / 8.3, panel:GetTall() / 1.3)
    foncti.panelInfoOfPlayer:SetPos(panel:GetWide() / 1.155,panel:GetTall() / 7)
    foncti.panelInfoOfPlayer.Paint = function(self, w, h)
    end


    menu_logs.scrollInfo = vgui.Create("DScrollPanel", foncti.panelInfoOfPlayer)
    menu_logs.scrollInfo:Dock(FILL)


    menu_logs.sbarinfo = menu_logs.scrollInfo:GetVBar()
    function menu_logs.sbarinfo:Paint()end
    function menu_logs.sbarinfo.btnUp:Paint() end
    function menu_logs.sbarinfo.btnDown:Paint() end
    function menu_logs.sbarinfo.btnGrip:Paint() end



    menu_logs.layoutinfo = vgui.Create("DIconLayout", menu_logs.scrollInfo)
    menu_logs.layoutinfo:Dock(FILL)
    menu_logs.layoutinfo:SetSpaceY(5)
    menu_logs.layoutinfo:SetSpaceX(0)

    for number,p in pairs(tbl[id2].Concerné) do

      menu_logs.AllLogs = vgui.Create("DButton", menu_logs.layoutinfo)
      menu_logs.AllLogs:SetSize(foncti.panelInfoOfPlayer:GetWide() / 1.1, foncti.panelInfoOfPlayer:GetTall() / 12)
      menu_logs.AllLogs:SetText("")
      menu_logs.AllLogs.BtnColor = 30
      menu_logs.AllLogs.HoverColor = Color(0,0,0)
      menu_logs.AllLogs.Lerp = 0
      menu_logs.AllLogs.LerpTxt = 0
      menu_logs.AllLogs:SetTextColor(Color(0,0,0,255))
      menu_logs.AllLogs.Paint = function(self,w,h)


        draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
        draw.RoundedBox(6, w/300, h/20, w/1.007, h/1.1, Color(255, 255, 255, 255))

        draw.DrawText(p, "FontLogsServeur5", w/2, h/10, Color(107, 126, 255), TEXT_ALIGN_CENTER)

        if player.GetBySteamID(p) then

          draw.DrawText(player.GetBySteamID(p):Nick(), "FontLogsServeur5", w/2, h/2, Color(107, 126, 255), TEXT_ALIGN_CENTER)

        end

      end

      menu_logs.AllLogs.DoClick = function(self)

        self.menu = DermaMenu()
        self.menu:AddOption( "SteamID32", function() SetClipboardText( p )  end )
        self.menu:AddOption( "Lien Panel", function() SetClipboardText( "https://trust-gaming.fr/panel/index.php?t=user&id=" .. p ) end )
        self.menu:Open()

      end

   end

end

net.Receive("Logs::ChoosePlayerSendSteam",function()

  local panel = User.Panel
  local tbl = net.ReadTable()

  local menu_logs = {}

  if IsValid(foncti.panelLogs) then

    foncti.panelLogs:Remove()

  end

  foncti.panelLogs = vgui.Create("DPanel", panel)
  foncti.panelLogs:SetSize(panel:GetWide() / 1.4, panel:GetTall() / 1.3)
  foncti.panelLogs:SetPos(panel:GetWide() / 5,panel:GetTall() / 7)
  foncti.panelLogs.Paint = function(self, w, h)
  end


  menu_logs.scroll = vgui.Create("DScrollPanel", foncti.panelLogs)
  menu_logs.scroll:Dock(FILL)


  menu_logs.sbar = menu_logs.scroll:GetVBar()
  function menu_logs.sbar:Paint()end
  function menu_logs.sbar.btnUp:Paint() end
  function menu_logs.sbar.btnDown:Paint() end
  function menu_logs.sbar.btnGrip:Paint() end



  menu_logs.layout = vgui.Create("DIconLayout", menu_logs.scroll)
  menu_logs.layout:Dock(FILL)
  menu_logs.layout:SetSpaceY(5)
  menu_logs.layout:SetSpaceX(0)

    for idh,f in SortedPairs(tbl, true) do

      if not istable(f) then continue end

      menu_logs.AllLogs = vgui.Create("DButton", menu_logs.layout)
      menu_logs.AllLogs:SetSize(foncti.panelLogs:GetWide() / 1.1, foncti.panelLogs:GetTall() / 17)
      menu_logs.AllLogs:SetText("")
      menu_logs.AllLogs.BtnColor = 30
      menu_logs.AllLogs.HoverColor = Color(0,0,0)
      menu_logs.AllLogs.Lerp = 0
      menu_logs.AllLogs.LerpTxt = 0
      menu_logs.AllLogs:SetTextColor(Color(0,0,0,255))
      menu_logs.AllLogs.Paint = function(self,w,h)


        draw.RoundedBox(6, 0, 0, w, h, Color(107, 126, 255))
        draw.RoundedBox(6, w/300, h/20, w/1.007, h/1.1, Color(255, 255, 255, 255))

        draw.DrawText(f.time, "FontLogsServeur2", w/18, h/3.8, Color(107, 126, 255), TEXT_ALIGN_CENTER)
        draw.DrawText(f.text1, "FontLogsServeur1", w/2, h/4.7, Color(107, 126, 255), TEXT_ALIGN_CENTER)

      end

      menu_logs.AllLogs.DoClick = function()

        foncti.Fonction6(panel,tbl,idh)

      end

    end

  end)

net.Receive("Logs::ChatAddText",function()

  chat.AddText(Color(255,255,255), "[", Color(255,0,0), "NOTIFICATION", Color(255,255,255), "]", Color(255,255,255), " Steam ID Incorrect")

end)
