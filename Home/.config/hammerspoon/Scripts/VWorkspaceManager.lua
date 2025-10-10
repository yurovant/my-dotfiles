-- ###########################################################
-- Virtual Workspace Manager for Hammerspoon
-- ###########################################################

local VWorkspaceManager = {}

-- Configuration
VWorkspaceManager.config = {
  maxWorkspaces = 5,
  workspaceKeys = {"F15", "F16", "F17", "F18", "F19"},
  showNotifications = true,
  notificationDuration = 1.5
}

-- State
VWorkspaceManager.workspaces = {}
VWorkspaceManager.currentWorkspace = 1
VWorkspaceManager.lastFocusedApp = {}

-- Initialize workspaces
for i = 1, VWorkspaceManager.config.maxWorkspaces do
  VWorkspaceManager.workspaces[i] = {
    apps = {},
    lastFocusedApp = nil
  }
end

-- Helper: Show notification
function VWorkspaceManager:notify(message)
  if self.config.showNotifications then
    hs.alert.show(message, self.config.notificationDuration)
  end
  print("[VWorkspace] " .. message)
end

-- Helper: Get application identifier (bundle ID or name)
function VWorkspaceManager:getAppIdentifier(app)
  local bundleID = app:bundleID()
  return bundleID or app:name()
end

-- Helper: Find workspace containing an application
function VWorkspaceManager:findWorkspaceForApp(app)
  local appId = self:getAppIdentifier(app)
  for wsNum, workspace in ipairs(self.workspaces) do
    for _, wsAppId in ipairs(workspace.apps) do
      if wsAppId == appId then
        return wsNum
      end
    end
  end
  return nil
end

-- Helper: Check if workspace has applications
function VWorkspaceManager:hasApplications(workspaceNum)
  return #self.workspaces[workspaceNum].apps > 0
end

-- Hide all applications in current workspace
function VWorkspaceManager:hideCurrentWorkspace()
  local workspace = self.workspaces[self.currentWorkspace]
  local focusedApp = hs.application.frontmostApplication()
  
  print("[VWorkspace] Hiding workspace " .. self.currentWorkspace)
  
  if focusedApp then
    local appId = self:getAppIdentifier(focusedApp)
    -- Save the currently focused app for this workspace
    if self:isAppInWorkspace(appId, self.currentWorkspace) then
      workspace.lastFocusedApp = appId
      print("[VWorkspace] Saved last focused app: " .. (focusedApp:name() or "unknown"))
    end
  end
  
  for _, appId in ipairs(workspace.apps) do
    local app = self:findApplicationByIdentifier(appId)
    if app then
      print("[VWorkspace] Hiding app: " .. app:name())
      app:hide()
    end
  end
end

-- Show all applications in target workspace
function VWorkspaceManager:showWorkspace(workspaceNum)
  local workspace = self.workspaces[workspaceNum]
  
  print("[VWorkspace] Showing workspace " .. workspaceNum)
  print("[VWorkspace] Apps in workspace: " .. #workspace.apps)
  
  -- Show all apps in the workspace
  for _, appId in ipairs(workspace.apps) do
    local app = self:findApplicationByIdentifier(appId)
    if app then
      print("[VWorkspace] Unhiding app: " .. app:name())
      app:unhide()
    end
  end
  
  -- Focus the last active app in this workspace
  if workspace.lastFocusedApp then
    local app = self:findApplicationByIdentifier(workspace.lastFocusedApp)
    if app then
      print("[VWorkspace] Activating last focused app: " .. app:name())
      app:activate()
    end
  else
    -- If no last focused app, focus the first app
    if #workspace.apps > 0 then
      local app = self:findApplicationByIdentifier(workspace.apps[1])
      if app then
        print("[VWorkspace] Activating first app: " .. app:name())
        app:activate()
      end
    end
  end
end

-- Find application by identifier
function VWorkspaceManager:findApplicationByIdentifier(identifier)
  local runningApps = hs.application.runningApplications()
  for _, app in ipairs(runningApps) do
    if self:getAppIdentifier(app) == identifier then
      return app
    end
  end
  return nil
end

-- Check if app is in workspace
function VWorkspaceManager:isAppInWorkspace(appId, workspaceNum)
  local workspace = self.workspaces[workspaceNum]
  for _, wsAppId in ipairs(workspace.apps) do
    if wsAppId == appId then
      return true
    end
  end
  return false
end

-- Add application to workspace
function VWorkspaceManager:assignAppToWorkspace(app, workspaceNum)
  local appId = self:getAppIdentifier(app)
  
  print("[VWorkspace] Assigning " .. app:name() .. " to workspace " .. workspaceNum)
  
  -- Remove from current workspace if exists
  local currentWs = self:findWorkspaceForApp(app)
  if currentWs then
    print("[VWorkspace] Removing from workspace " .. currentWs)
    self:removeAppFromWorkspace(appId, currentWs)
  end
  
  -- Add to new workspace
  local workspace = self.workspaces[workspaceNum]
  table.insert(workspace.apps, appId)
  workspace.lastFocusedApp = appId
  
  -- Hide apps from current workspace and switch
  if workspaceNum ~= self.currentWorkspace then
    self:hideCurrentWorkspace()
    self.currentWorkspace = workspaceNum
    self:showWorkspace(workspaceNum)
  else
    app:activate()
  end
  
  self:notify("Assigned " .. app:name() .. " to Workspace " .. workspaceNum)
end

-- Remove application from workspace
function VWorkspaceManager:removeAppFromWorkspace(appId, workspaceNum)
  local workspace = self.workspaces[workspaceNum]
  for i, wsAppId in ipairs(workspace.apps) do
    if wsAppId == appId then
      table.remove(workspace.apps, i)
      if workspace.lastFocusedApp == appId then
        workspace.lastFocusedApp = workspace.apps[1] or nil
      end
      break
    end
  end
end

-- Switch to workspace
function VWorkspaceManager:switchToWorkspace(workspaceNum)
  print("[VWorkspace] Switch requested to workspace " .. workspaceNum)
  
  -- Check activation condition
  if not self:hasApplications(workspaceNum) then
    self:notify("There are no apps assigned to this workspace")
    return
  end
  
  if workspaceNum == self.currentWorkspace then
    print("[VWorkspace] Already in workspace " .. workspaceNum)
    return
  end
  
  -- Hide current workspace
  self:hideCurrentWorkspace()
  
  -- Switch to new workspace
  self.currentWorkspace = workspaceNum
  
  -- Show new workspace
  self:showWorkspace(workspaceNum)
  
  self:notify("Switched to Workspace " .. workspaceNum)
end

-- Switch to next/previous workspace (for arrow keys and probably swipe gestures)
function VWorkspaceManager:switchToAdjacentWorkspace(direction)
  local targetWorkspace = self.currentWorkspace + direction
  
  -- Find next valid workspace
  while targetWorkspace >= 1 and targetWorkspace <= self.config.maxWorkspaces do
    if self:hasApplications(targetWorkspace) then
      self:switchToWorkspace(targetWorkspace)
      return
    end
    targetWorkspace = targetWorkspace + direction
  end
  
  self:notify("No " .. (direction > 0 and "next" or "previous") .. " workspace available")
end

-- Setup keyboard shortcuts
function VWorkspaceManager:setupShortcuts()
  print("[VWorkspace] Setting up shortcuts...")
  
  -- Workspace switching (F15-F19)
  for i = 1, self.config.maxWorkspaces do
    local key = self.config.workspaceKeys[i]
    
    print("[VWorkspace] Binding " .. key .. " for workspace " .. i)
    
    -- Switch to workspace (F15-F19)
    local switchSuccess = hs.hotkey.bind({}, key, function()
      print("[VWorkspace] " .. key .. " pressed - switching to workspace " .. i)
      self:switchToWorkspace(i)
    end)
    
    if not switchSuccess then
      print("[VWorkspace] WARNING: Failed to bind " .. key)
    end
    
    -- Assign current application to workspace (Shift + F15-F19)
    local assignSuccess = hs.hotkey.bind({"shift"}, key, function()
      print("[VWorkspace] Shift+" .. key .. " pressed - assigning to workspace " .. i)
      local app = hs.application.frontmostApplication()
      if app then
        self:assignAppToWorkspace(app, i)
      else
        self:notify("No application in focus")
      end
    end)
    
    if not assignSuccess then
      print("[VWorkspace] WARNING: Failed to bind Shift+" .. key)
    end
  end
  
  -- Optional: Add debug command to show current state (Ctrl + Shift + D)
  hs.hotkey.bind({"ctrl", "shift"}, "D", function()
    self:showDebugInfo()
  end)
  
  print("[VWorkspace] Shortcuts setup complete")
end

-- Setup movement between workspaces with Left and Right arrows
function VWorkspaceManager:setupArrowMovement()
  hs.hotkey.bind({"ctrl"}, "Left", function()
    self:switchToAdjacentWorkspace(-1)
  end)
  
  hs.hotkey.bind({"ctrl"}, "Right", function()
    self:switchToAdjacentWorkspace(1)
  end)
end

-- TODO: Setup movement between workspaces with swipe left and right gestures
function VWorkspaceManager:setupSwipeMovement()
  -- TODO
end

-- Debug info in Hammerspoon Console
function VWorkspaceManager:showDebugInfo()
  local info = "Current Workspace: " .. self.currentWorkspace .. "\n\n"
  for i, workspace in ipairs(self.workspaces) do
    info = info .. "Workspace " .. i .. " (F" .. (14 + i) .. "):\n"
    if #workspace.apps > 0 then
      for _, appId in ipairs(workspace.apps) do
        local app = self:findApplicationByIdentifier(appId)
        local appName = app and app:name() or appId
        local focused = (workspace.lastFocusedApp == appId) and " [FOCUSED]" or ""
        info = info .. "  - " .. appName .. focused .. "\n"
      end
    else
      info = info .. "  (empty)\n"
    end
  end
  
  hs.dialog.blockAlert("Virtual Workspace Debug", info, "OK")
  print(info)
end

-- Initialize
function VWorkspaceManager:init()
  print("[VWorkspace] Initializing test...")

  hs.alert.show("Hammerspoon module VWorkspaceManager")

  self:setupShortcuts()
  self:setupArrowMovement()

  -- TODO: Setup swipe gesture tracking for 3- and 4-finger swipes
  self:setupSwipeMovement()

  -- Auto-assign current applications to Workspace 1
  local runningApps = hs.application.runningApplications()
  local appCount = 0
  for _, app in ipairs(runningApps) do
    if app:isApplication() and not app:isHidden() then
      local appId = self:getAppIdentifier(app)
      table.insert(self.workspaces[1].apps, appId)
      print("[VWorkspace] Added to workspace 1: " .. app:name())
      appCount = appCount + 1
    end
  end
  
  print("[VWorkspace] Total apps in workspace 1: " .. appCount)
  
  local focusedApp = hs.application.frontmostApplication()
  if focusedApp then
    self.workspaces[1].lastFocusedApp = self:getAppIdentifier(focusedApp)
    print("[VWorkspace] Focused app: " .. focusedApp:name())
  end
  
  self:notify("Virtual Workspace Manager loaded - Currently in Workspace 1")
  print("[VWorkspace] Initialization complete")
end

return VWorkspaceManager