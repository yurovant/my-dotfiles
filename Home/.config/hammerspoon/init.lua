-- ###########################################################
-- Create a text file named unnamed.txt in the current folder.
-- ###########################################################
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "U", function()
  local script = [[
      tell application "Finder"
          if (count of windows) is not 0 then
              set currentFolder to (folder of front window) as alias
          else
              -- Default to Desktop if no window is open
              set currentFolder to (path to desktop folder)
          end if
          set filePath to (currentFolder as text) & "unnamed.txt"
          do shell script "touch " & quoted form of POSIX path of filePath
      end tell
  ]]
  hs.osascript.applescript(script)
  hs.alert.show("File 'unnamed.txt' created")
end)


-- ###########################################################
-- Branch name to commit message
-- ###########################################################
-- Changes this:
-- ft1/feature/STRY0552406__Article-Root-Page__Enable-the-rich-text-component
-- to this:
-- STRY0552406 : Article Root Page : Enable the rich text component
-- ###########################################################
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
  -- Save current clipboard
  local originalClipboard = hs.pasteboard.getContents()
  
  -- Simulate Cmd+C to copy selected text
  hs.eventtap.keyStroke({"cmd"}, "c")
  -- Wait a bit for clipboard to update
  hs.timer.usleep(200000)
  
  -- Get the copied text
  local selectedText = hs.pasteboard.getContents()
  
  if selectedText then
    local replacedText = selectedText
    
    -- Remove everything before and including the last "/"
    replacedText = replacedText:gsub(".*/", "")
    
    -- Replace hyphens with spaces
    replacedText = replacedText:gsub("-", " ")
    
    -- Replace double space after previous cleanup with " : "
    replacedText = replacedText:gsub("  ", " : ")
    
    -- Put new text on clipboard and paste it
    hs.pasteboard.setContents(replacedText)
    hs.eventtap.keyStroke({"cmd"}, "v")
    
    -- Restore original clipboard
    hs.timer.doAfter(0.5, function()
      hs.pasteboard.setContents(originalClipboard)
    end)
  else
    hs.alert.show("No text selected!")
  end
end)


-- Reload config with Ctrl + Shift + R
hs.hotkey.bind({"ctrl", "shift"}, "F15", function()
  print("[VWorkspace] Reloading config...")
  hs.reload()
end)

-- local VWorkspaceManager = require("Scripts.VWorkspaceManager")

-- Start the virtual workspace manager
-- VWorkspaceManager:init()

print("Hammerspoon config loaded")

hs.alert.show("Hammerspoon config loaded")
