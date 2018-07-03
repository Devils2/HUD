      if !CLIENT then return end

      surface.CreateFont( "Creditserv", { font = "Montserrat", size = 14, weight = 4 } )
      surface.CreateFont( "Credit", { font = "Montserrat", size = 16, weight = 4 } )
      surface.CreateFont( "ElegantHUDFont", { font = "Montserrat", size = 16, weight = 4 } )
      surface.CreateFont( "ElegantHUDTitle", { font = "Montserrat", size = 25, weight = 0 } )
      surface.CreateFont( "ElegantHUDFood", { font = "Montserrat", size = 12, weight = 0 } )

      local health_icon = Material( "icon16/heart.png" )
      local shield_icon = Material( "icon16/shield.png" )
      local cash_icon = Material( "icon16/money.png" )
      local star_icon = Material( "icon16/star.png" )
      local tick_icon = Material( "icon16/tick.png" )


      local maxBarSize = 215

      local function DrawFillableBar( x, y, w, h, baseCol, fillCol, icon, txt )
          DrawRect( x, y, w, h, baseCol )
          DrawRect( x, y, w, h, fillCol )
      end

      local function DrawRect( x, y, w, h, col )
          surface.SetDrawColor( col )
          surface.DrawRect( x, y, w, h )
      end

      local function DrawText( msg, fnt, x, y, c, align )
          draw.SimpleText( msg, fnt, x, y, c, align and align or TEXT_ALIGN_CENTER )
      end

      local function DrawOutlinedRect( x, y, w, h, t, c )
         surface.SetDrawColor( c )
         for i = 0, t - 1 do
             surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
         end
      end

      local v = { "DarkRP_HUD", "CHudBattery", "CHudHealth" }

      hook.Add( 'HUDShouldDraw', 'HUD_HIDE_DRP', function( vs )
          if table.HasValue( v, vs ) then return false end
      end )

      hook.Add( 'HUDPaint', 'HUD_DRAW_HUD', function()
          CreateHUD()
      end )

--      local function CreateModelHead()
--          model = vgui.Create("DModelPanel")
--          function model:LayoutEntity( Entity ) return end
--      end
--      hook.Add( 'InitPostEntity', 'HUD_GIVE_HEAD', CreateModelHead )

      local function CreateImageIcon( icon, x, y, col, val )
          surface.SetDrawColor( col )
          surface.SetMaterial( icon )
          local w, h = 16, 16
          if val then
              surface.SetDrawColor( Color( 255, 255, 255 ) )
          end
          surface.DrawTexturedRect( x, y, w, h )
      end

      function GetBarSize( data )
          return ( maxBarSize / 100 ) * data < maxBarSize and ( maxBarSize / 100 ) * data or maxBarSize
      end

      function CreateHUD()

          local self = LocalPlayer()

          local bX, bY, bW, bH = 0, ScrH() - 140, 320, 110 -- The main box with shit in it
          local tX, tY, tW, tH = 0, ScrH() - 900, 10000, 40 -- The title bar box (above main box)


          local back = Color( 14, 14, 14 )
          local through = Color( 0, 0, 0, 250 )


--          DrawRect( bX, bY, bW, bH, back )
          DrawRect( tX, tY, tW, tH, back )


--          DrawOutlinedRect( bX, bY, bW, bH, 2, through )
          DrawOutlinedRect( tX, tY, tW, tH, 2, through )


          local job = team.GetName( self:Team() )
          local offset = 0

          -- Legit aids
          if #job > 20 then
              offset = 4
          elseif #job > 16 then
              offset = 3.4
          elseif #job > 12 then
              offset = 3
          elseif #job >= 8 then
              offset = 1.5
          elseif #job > 4 then
              offset = -0.3
          else
              offset = -1.5
          end

          local x = 850 - ( #job ) * offset

          draw.SimpleText( self:Nick(), "ElegantHUDTitle", 800, ScrH() - 885, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
          draw.SimpleText( "By Devils_monkey", "ElegantHUDTitle", 450, ScrH() - 880, Color( 189, 195, 199), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
          draw.SimpleText( "Pour: Phénix RP", "ElegantHUDTitle", 1050, ScrH() - 880, Color( 189, 195, 199), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
--          draw.SimpleText( job, "ElegantHUDFont", x - ( offset * 2 ), ScrH() - 158, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

          local hX, hY, hW, hH = 100, ScrH() - 895, 190, 24

          function Hunger()
            if ply:getDarkRPVar("Energy") then
              local hunger = math.ceil(LocalPlayer():getDarkRPVar("Energy") or 0)
                if hunger > 100 then 
                  hunger = 100 end
            end  
          end

          local hX, hY, hW, hH = 735, ScrH() - 870, 190, 10

          local divide = 5
          local offset = 20
          local maxBarSize = 0

          DrawRect( hX + divide, hY, GetBarSize( LocalPlayer():getDarkRPVar("Energy") ) - divide / 2 - offset, hH, Color( 220, 20, 60, 190 ) )
          DrawText( LocalPlayer():getDarkRPVar("Energy") > 0 and LocalPlayer():getDarkRPVar("Energy") .. "%" or 0 .. "%", "ElegantHUDFood", 840, ScrH() - 872, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )

          local hX, hY, hW, hH = 100, ScrH() - 895, 190, 24


          DrawRect( hX - offset, hY, maxBarSize + divide / 22, hH, Color( 26, 26, 26 ) )
          DrawRect( hX + divide, hY, GetBarSize( self:Health() ) - divide / 2 - offset, hH, Color( 220, 20, 60, 190 ) )
          DrawText( self:Health() > 0 and self:Health() .. "%" or 0 .. "%", "ElegantHUDFont", 215, ScrH() - 890, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )

          local hX, hY, hW, hH = 1307, ScrH() - 920, 435, 24

          DrawRect( hX - offset, hY + 28, maxBarSize + divide / 22, hH, Color( 26, 26, 26 ) )
          DrawRect( hX - 30 + divide, hY + 28, GetBarSize( self:Armor() > 0 and self:Armor() or 0 ) - divide / 2 - offset, hH, Color( 30, 144, 255 ) )
          DrawText( self:Armor() > 0 and self:Armor() .. "%" or 0 .. "%", "ElegantHUDFont", 1375, ScrH() - 890, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )

--          local hX, hY, hW, hH = 100, ScrH() - 900, 90, 24

--          DrawRect( hX - offset, hY + 55, maxBarSize + divide / 2, hH, Color( 26, 26, 26 ) )
--          DrawRect( hX + divide, hY + 55, GetBarSize( 100 ) - divide / 2 - offset, hH, Color( 46, 204, 113 ) )

          CreateImageIcon( health_icon, 84, ScrH() - 890, Color( 255, 0, 0 ) )
          CreateImageIcon( shield_icon, 1478, ScrH() - 888, Color( 30,144,255 ) )
--          CreateImageIcon( cash_icon, 84, ScrH() - 798, Color( 255, 255, 255 ) )
          CreateImageIcon( star_icon, 40, ScrH() - 890, Color( 40, 40, 40 ), self:isWanted() )
          CreateImageIcon( tick_icon, 1527, ScrH() - 888, Color( 40, 40, 40 ), self:getDarkRPVar("HasGunlicense") )

--          DrawText( DarkRP.formatMoney( self:getDarkRPVar( "money" ) ), "ElegantHUDFont", 215, ScrH() - 798, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )

      end
