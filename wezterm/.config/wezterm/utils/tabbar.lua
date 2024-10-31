local wezterm = require('wezterm')
local M = {}

local function getMemoryUsageCell()
    local success, stdout, stderr = wezterm.run_child_process { 'free', '-b' }
    if success then
        -- Suche nach "Speicher:" und extrahiere den "gesamt" und "benutzt" Wert
        local total_memory, used_memory = stdout:match(".*Speicher:%s*(%d+)%s+(%d+)")
        if total_memory and used_memory then
            local used_percentage = (tonumber(used_memory) / tonumber(total_memory)) * 100
            return string.format("RAM: %2d%%", math.floor(used_percentage + 0.5))
        else
            wezterm.log_error('Konnte Werte von free -b nicht parsen:' .. stdout)
        end
    else
        wezterm.log_error('Kommand (free -b) failed:' .. stderr)
    end
end

local function getCPUUsageCell()
    local success, stdout, stderr = wezterm.run_child_process { 'bash', '-c', 'top -bn1 | grep "CPU(s)"' }
    if success then
        -- Suche nach "Speicher:" und extrahiere den "gesamt" und "benutzt" Wert
        -- %CPU(s):  5,8 us,  2,2 sy,  0,0 ni, 92,0 id,  0,0 wa,  0,0 hi, (Output Ubuntu 24.04)
        local cpu_idle = stdout:match(".*%,%s(%d+[.,]%d+)%sid%,"):gsub(",", ".")
        if cpu_idle then
            local used_percentage = 100 - tonumber(cpu_idle)
            return string.format("CPU: %2d%%", math.floor(used_percentage + 0.5))
        else
            wezterm.log_error('Konnte Werte von top nicht parsen:' .. stdout)
        end
    else
        wezterm.log_error('Kommand (top ...) failed:' .. stderr)
    end
end 

local function getDateTimeCell(screenWidth)
    if screenWidth < 1024 then
        return wezterm.strftime '%H:%M'
    elseif screenWidth >= 1024 and screenWidth < 1720 then
        return wezterm.strftime '%d-%m %H:%M'
    elseif screenWidth >= 1720 and screenWidth < 2560 then
        return wezterm.strftime '%Y-%m-%d %H:%M KW: %W'
    end

    return wezterm.strftime '%A the %d. of %B %Y %H:%M KW: %W'
end

local function generateTabEntries(right_cells)
    -- The powerline < symbol
    local LEFT_ARROW = utf8.char(0xe0b3)
    -- The filled in variant of the < symbol
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

    -- Color palette for the backgrounds of each cell
    local colors = {
        '#2b2042',
        '#3c1361',
        '#52307c',
        '#663a82',
        '#7c5295',
        '#b491c8',
    }

    -- Foreground color for the text across the fade
    local text_fg = '#c0c0c0'
    -- The elements to be formatted
    local elements = {}
    -- How many cells have been formatted
    local num_cells = 0

    -- Translate a cell into elements
    function push(text, is_last)
        local cell_no = num_cells + 1
        table.insert(elements, { Foreground = { Color = text_fg } })
        table.insert(elements, { Background = { Color = colors[cell_no] } })
        table.insert(elements, { Text = ' ' .. text .. ' ' })
        if not is_last then
        table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
        table.insert(elements, { Text = SOLID_LEFT_ARROW })
        end
        num_cells = num_cells + 1
    end

    while #right_cells > 0 do
        local cell = table.remove(right_cells, 1)
        push(cell, #right_cells == 0)
    end

    return elements
end 

local function styleLeftTabBar(config)
    config.colors = {
        tab_bar = {
          -- The color of the strip that goes along the top of the window
          -- (does not apply when fancy tab bar is in use)
          background = '#0b0022',
      
          -- The active tab is the one that has focus in the window
          active_tab = {
            -- The color of the background area for the tab
            bg_color = '#2b2042',
            -- The color of the text for the tab
            fg_color = '#c0c0c0',
      
            -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
            -- label shown for this tab.
            -- The default is "Normal"
            intensity = 'Normal',
      
            -- Specify whether you want "None", "Single" or "Double" underline for
            -- label shown for this tab.
            -- The default is "None"
            underline = 'None',
      
            -- Specify whether you want the text to be italic (true) or not (false)
            -- for this tab.  The default is false.
            italic = false,
      
            -- Specify whether you want the text to be rendered with strikethrough (true)
            -- or not for this tab.  The default is false.
            strikethrough = false,
          },
      
          -- Inactive tabs are the tabs that do not have focus
          inactive_tab = {
            bg_color = '#1b1032',
            fg_color = '#808080',
      
            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab`.
          },
      
          -- You can configure some alternate styling when the mouse pointer
          -- moves over inactive tabs
          inactive_tab_hover = {
            bg_color = '#3b3052',
            fg_color = '#909090',
            italic = true,
      
            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab_hover`.
          },
      
          -- The new tab button that let you create new tabs
          new_tab = {
            bg_color = '#1b1032',
            fg_color = '#808080',
      
            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab`.
          },
      
          -- You can configure some alternate styling when the mouse pointer
          -- moves over the new tab button
          new_tab_hover = {
            bg_color = '#3b3052',
            fg_color = '#909090',
            italic = true,
      
            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab_hover`.
          },
        },
      }
end

wezterm.on("update-status", function(window, pane)
    local present, conf = pcall(window.effective_config, window)
    if not present then
      return
    end

    local right_cells = {}

    -- Get CPU Usage
    table.insert(right_cells, getCPUUsageCell() or 'CPU: ⚠️')
    -- Get RAM Usage Tab
    table.insert(right_cells, getMemoryUsageCell() or 'RAM: ⚠️')
    -- Get Date Tab depending on Window size
    table.insert(right_cells, getDateTimeCell(window:get_dimensions()['pixel_width']))

    local finalTableEntries = generateTabEntries(right_cells) or {}
    window:set_right_status(wezterm.format(finalTableEntries))
end)

M.apply_to_config = function(config) 
    config.status_update_interval = 5000
    config.tab_bar_at_bottom = true
    config.use_fancy_tab_bar = false
    styleLeftTabBar(config)
end

return M