--[[ 
    Gma3 Icon List
    version 1.0.0
    Last update April 16, 2025
    Developed by Jeremy Dufeux - Carrot Industries
    https://carrot-industries.com
    contact: contact@carrot-industries.com

    License described in the LICENSE.txt file
]]

local pluginHandle = select(4, ...)

Icon = {
  arrow_down = "arrow_down",
  arrow_up = "arrow_up",
  backup = "backup",
  cooking = "cooking",
  execconfig = "execconfig",
  FlipLeftRight = "FlipLeftRight",
  icon_timer = "icon_timer",
  minus = "minus",
  object_3d = "object_3d",
  object_agenda = "object_agenda",
  object_align = "object_align",
  object_appear = "object_appear",
  object_bitmaps = "object_bitmaps",
  object_camera = "object_camera",
  object_clock = "object_clock",
  object_cmd = "object_cmd",
  object_colpick = "object_colpick",
  object_content = "object_content",
  object_commandwing = "object_commandwing",
  object_datapool = "object_datapool",
  object_dmx = "object_dmx",
  object_encbar = "object_encbar",
  object_filter = "object_filter",
  object_fixture = "object_fixture",
  object_fps = "object_fps",
  object_gels = "object_gels",
  object_generators = "object_generators",
  object_group1 = "object_group1",
  object_gobos = "object_gobos",
  object_layout = "object_layout",
  object_info = "object_info",
  object_images = "object_images",
  object_macro = "object_macro",
  object_matricks = "object_matricks",
  object_meshes = "object_meshes",
  object_message = "object_message",
  object_pages = "object_pages",
  object_playback = "object_playback",
  object_plugin1 = "object_plugin1",
  object_preset = "object_preset",
  object_phase = "object_phase",
  object_question_small = "object_question_small",
  object_quickey = "object_quickey",
  object_runningpb = "object_runningpb",
  object_scribbles = "object_scribbles",
  object_sel_bar = "object_sel_bar",
  object_selgrid = "object_selgrid",
  object_sequence = "object_sequence",
  object_smart = "object_smart",
  object_sound3 = "object_sound3",
  object_special_master = "object_special_master",
  object_stepbar = "object_stepbar",
  object_symbols = "object_symbols", 
  object_sysinfo = "object_sysinfo",
  object_sysmonitor = "object_sysmonitor",
  object_tags = "object_tags",
  object_timecode = "object_timecode",
  object_timecodeslots = "object_timecodeslots",
  object_trackp = "object_trackp",
  object_universe = "object_universe",
  object_user = "object_user",
  object_video = "object_video",
  object_view = "object_view",
  object_world1 = "object_world1",
  object_xkeys = "object_xkeys",
  PhaserCopy = "PhaserCopy",
  PhaserCut = "PhaserCut",
  PhaserPaste = "PhaserPaste",
  plus = "plus",
  star = "star",
  time = "time",
  tools = "tools",
}

function Main
  ()
  local contentRoot = CreateInputDialog()

  local columns = 4
  local rows= 12

  local grid = contentRoot:Append("UILayoutGrid")
  grid.Columns = columns
  grid.Rows = rows

  local actualColumns = 0
  local actualRows = 0

  for _, icon in pairs(Icon) do
    AddButton(grid, actualColumns, actualRows, icon, icon)
    if(actualColumns == columns) then
      actualColumns = 0
      actualRows = actualRows + 1
    else
      actualColumns = actualColumns + 1
    end
  end
end

function CreateInputDialog()
  local displayIndex = Obj.Index(GetFocusDisplay())
   if displayIndex > 5 then
     displayIndex = 1
   end
  local display = GetDisplayByIndex(displayIndex)
  local screenOverlay = display.ScreenOverlay
  screenOverlay:ClearUIChildren()

  local baseInput = screenOverlay:Append("BaseInput")
  baseInput.Name = "Gma3 Icons list"
  baseInput.H = "0"
  baseInput.W = 1200 
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
  titleBarIcon.Text = "Gma3 Icons list"
  titleBarIcon.Texture = "corner1"
  titleBarIcon.Anchors = "0,0"
  titleBarIcon.Icon = Icon.object_sequence

  local titleBarCloseButton = titleBar:Append("CloseButton")
  titleBarCloseButton.Anchors = "1,0"
  titleBarCloseButton.Texture = "corner2"

  local contentRoot = baseInput:Append("DialogFrame")
  contentRoot.Anchors = {
    left = 0,
    right = 0,
    top = 1,
    bottom = 1
  }
  contentRoot[1][1].SizePolicy = "Fixed"
  contentRoot[1][1].Size = 1000

  return contentRoot
end

function AddButton(parent, x, y, text, icon)
  local button = parent:Append("Button")
  button.PluginComponent = pluginHandle
  button.Text = text
  button.Font = "Medium20"
  button.TextalignmentH = "Left"
  button.Textshadow = 1;
  button.Anchors = {
    left = x,
    right = x,
    top = y,
    bottom = y
  }
  button.Margin = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2
  }
  button.Padding = "5,5"
  button.IconAlignmentH = "Right"
  button.Icon = icon
end

return Main