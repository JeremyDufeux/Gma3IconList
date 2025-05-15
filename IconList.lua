--[[ 
    Gma3 Icon List
    version 1.1.0.0
    Last update April 16, 2025
    Developed by Jeremy Dufeux - Carrot Industries
    https://carrot-industries.com
    contact: contact@carrot-industries.com

    This software is licensed as described in the LICENSE.txt file.
]]

local signalTable = select(3, ...)
local pluginHandle = select(4, ...)

if IconList == nil then
  IconList = {}
end

function IconList.Main()
  local displayIndex = Obj.Index(GetFocusDisplay())
  if displayIndex > 5 then
    displayIndex = 1
  end
  
  local icons = IconList.CreateIconTableFromXMLFile()
  if(icons == nil) then
    Printf("No icons found")
    return
  end

  local width = 1600
  local height = 800

  local columns = 4
  local rows= 50

  local buttonSize = 120

  local iconsAmount = IconList.GetTableSize(icons)
  if(iconsAmount == 0) then
    Printf("No icons found")
    return
  end

  if iconsAmount % columns > 0 then
    rows = math.floor(iconsAmount / columns) + 1
  else
    rows = math.floor(iconsAmount / columns)
  end
  local scrollHeight = rows * buttonSize

  local display = GetDisplayByIndex(displayIndex)
  local screenOverlay = display.ScreenOverlay
  screenOverlay:ClearUIChildren()

  local baseInput = screenOverlay:Append("BaseInput")
  baseInput.Name = "Gma3 Icons list"
  baseInput.H = "0"
  baseInput.W = width 
  baseInput.Rows = 2
  baseInput[1][1].SizePolicy = "Fixed"
  baseInput[1][1].Size = "60"
  baseInput[1][2].SizePolicy = "Stretch"

  local titleBar = baseInput:Append("TitleBar")
  titleBar.Columns = 2
  titleBar.Anchors = "0,0"
  titleBar[2][2].SizePolicy = "Fixed"
  titleBar[2][2].Size = "50"
  titleBar.Texture = "corner2"

  local titleBarIcon = titleBar:Append("TitleButton")
  titleBarIcon.Text = "Gma3 Icons list - "..iconsAmount.." icons"
  titleBarIcon.Texture = "corner1"
  titleBarIcon.Anchors = "0,0"
  titleBarIcon.Icon = "object_sequence"

  local titleBarCloseButton = titleBar:Append("CloseButton")
  titleBarCloseButton.Anchors = "1,0"
  titleBarCloseButton.Texture = "corner2"

  local dlgFrame = baseInput:Append("DialogFrame")
	dlgFrame.H = "100%"
	dlgFrame.W = "100%"
	dlgFrame.Columns = 2
	dlgFrame.Rows = 1
	dlgFrame.Anchors = { left = 0, right = 0, top = 1, bottom = 1 }

	dlgFrame[1][1].SizePolicy = "Content"
	dlgFrame[2][1].SizePolicy = "Stretch"
	dlgFrame[2][2].SizePolicy = "Content"

	local boxHolder = dlgFrame:Append("UIObject")
	boxHolder.Anchors = { left = 0, right = 1, top = 0, bottom = 0 }
	boxHolder.H, boxHolder.W = height, "100%"
	boxHolder.Transparent = true

	local scrollbox = boxHolder:Append("ScrollBox")

	local scrollbar = dlgFrame:Append("ScrollBarV")
	scrollbar.ScrollTarget = scrollbox
	scrollbar.Anchors = "1,0"

	local grid = scrollbox:Append("UILayoutGrid")
	grid.W, grid.H = width-48, scrollHeight
  grid.Columns = columns
  grid.Rows = rows

  local actualColumns = 0
  local actualRows = 0

  for _, icon in pairs(IconList.GetSortedKeys(icons)) do
    IconList.AddButton(grid, actualColumns, actualRows, icon, icon, buttonSize)
    if(actualColumns == columns-1) then
      actualColumns = 0
      actualRows = actualRows + 1
    else
      actualColumns = actualColumns + 1
    end
  end
end

function IconList.CreateIconTableFromXMLFile(xmlFilePath)
  local texturePath = GetPath("textures")
  local textureFilePath = texturePath.."/graphics.textures.xml"
  
  local file = io.open(textureFilePath, "r")
  if not file then
      Printf("Can't find the graphics.textures.xml file")
      Printf("It should be located in "..texturePath)
      return nil
  end
  
  local content = file:read("*all")
  file:close()
  
  local cleanedContent = content:gsub("<!%-%-.-%-%->"," ")
  
  local icons = {}
  for name in cleanedContent:gmatch("<Texture%s+Name=\"([^\"]+)\"") do
      icons[name] = name
  end
  
  return icons
end

function IconList.GetSortedKeys(tbl)
  local keys = {}

  for key in pairs(tbl) do
    table.insert(keys, key)
  end
  
  table.sort(keys, function(a, b)
    return string.lower(a) < string.lower(b)
  end)

  return keys
end

function IconList.GetTableSize(t)
  local count = 0
  for _ in pairs(t) do
      count = count + 1
  end
  return count
end

function IconList.CopyToClipboard(text)
  local tmpFile = os.tmpname()
  local file = io.open(tmpFile, "w")
  
  if not file then
    Printf("Failed to create temporary file")
    return
  end

  file:write(text)
  file:close()
  
  local host = HostOS()

  if(host == "Windows") then
    os.execute("type " .. tmpFile .. " | clip")
  elseif(host == "Linux") then
    os.execute("cat " .. tmpFile .. " | xclip -selection clipboard")
  elseif(host == "Mac") then
    os.execute("cat " .. tmpFile .. " | pbcopy")
  else
    Printf("Unsupported OS: " .. host)
  end
end

function IconList.AddButton(parent, x, y, text, icon, buttonSize)
  local margin = 4

  local grid = parent:Append("UILayoutGrid")
  grid.Anchors = {
    left = x,
    right = x,
    top = y,
    bottom = y
  }
  grid.Columns = 2
  grid.Rows = 1
  grid.Margin = {
    left = margin*2,
    right = margin*2,
    top = margin,
    bottom = margin
  }
  grid.W = 520

  local label = grid:Append("Button")
  label.PluginComponent = pluginHandle
  label.Text = text
  label.Font = "Medium20"
  label.TextalignmentH = "Left"
  label.Textshadow = 1;
  label.Anchors = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  }
  label.Padding = "5,5"
  label.Clicked = "Callback"

  local button = grid:Append("Button")
  button.PluginComponent = pluginHandle
  button.Anchors = {
    left = 1,
    right = 1,
    top = 0,
    bottom = 0
  }
  button.Icon = icon
  button.W = buttonSize
  button.Clicked = "Callback"

  signalTable.Callback = function(caller)
    Printf("Clicked on "..caller.Text)    
    IconList.CopyToClipboard(caller.Text)
  end

end

return IconList.Main