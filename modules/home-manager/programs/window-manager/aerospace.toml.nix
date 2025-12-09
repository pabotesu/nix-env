# Start AeroSpace at login
start-at-login = true

# Normalization settings
enable-normalization-flatten-containers = true
enable-normalization-opposite-orientation-for-nested-containers = true

# Accordion layout settings
accordion-padding = 30

# Default root container settings
default-root-container-layout = 'tiles'
default-root-container-orientation = 'auto'

# Mouse follows focus settings
on-focused-monitor-changed = ['move-mouse monitor-lazy-center']
on-focus-changed = ['move-mouse monitor-lazy-center']

# Automatically unhide macOS hidden apps
automatically-unhide-macos-hidden-apps = true

# Auto start borders
after-startup-command = [
  'exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0'
]

# Monitor mapping workspase
[workspace-to-monitor-force-assignment]
1 = 'main'
2 = 2

# Key mapping preset
[key-mapping]
preset = 'qwerty'

# Gaps settings
[gaps]
inner.horizontal = 6
inner.vertical =   6
outer.left =       6
outer.bottom =     6
outer.top =        6
outer.right =      6

# Main mode bindings
[mode.main.binding]
# Launch applications
alt-enter = 'exec-and-forget open -na alacritty'

# Window management
alt-shift-q = "close"
alt-slash = 'layout tiles horizontal vertical'
alt-comma = 'layout accordion horizontal vertical'
alt-m = 'fullscreen'

# Focus movement
alt-h = 'focus left'
alt-j = 'focus down'
alt-k = 'focus up'
alt-l = 'focus right'

# Window movement
alt-shift-h = 'move left'
alt-shift-j = 'move down'
alt-shift-k = 'move up'
alt-shift-l = 'move right'

# Workspace management
alt-1 = 'workspace 1'
alt-2 = 'workspace 2'
alt-3 = 'workspace 3'
alt-4 = 'workspace 4'
alt-5 = 'workspace 5'
alt-6 = 'workspace 6'
alt-7 = 'workspace 7'
alt-8 = 'workspace 8'
alt-9 = 'workspace 9'

# Move windows to workspaces
alt-shift-1 = 'move-node-to-workspace 1 --focus-follows-window'
alt-shift-2 = 'move-node-to-workspace 2 --focus-follows-window'
alt-shift-3 = 'move-node-to-workspace 3 --focus-follows-window'
alt-shift-4 = 'move-node-to-workspace 4 --focus-follows-window'
alt-shift-5 = 'move-node-to-workspace 5 --focus-follows-window'
alt-shift-6 = 'move-node-to-workspace 6 --focus-follows-window'
alt-shift-7 = 'move-node-to-workspace 7 --focus-follows-window'
alt-shift-8 = 'move-node-to-workspace 8 --focus-follows-window'
alt-shift-9 = 'move-node-to-workspace 9 --focus-follows-window'

# Workspace navigation
alt-tab = 'workspace-back-and-forth'
alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

# Enter service mode
alt-shift-semicolon = 'mode service'

alt-f = 'fullscreen'

alt-s = 'layout v_accordion' # 'layout stacking' in i3
alt-w = 'layout h_accordion' # 'layout tabbed' in i3
alt-e = 'layout tiles horizontal vertical' # 'layout toggle split' in i3

alt-shift-space = 'layout floating tiling' # 'floating toggle' in i3
alt-shift-c = 'reload-config'
alt-r = 'mode resize'

# Service mode bindings
[mode.service.binding]
# Reload config and exit service mode
esc = ['reload-config', 'mode main']

# Close all windows but current
backspace = ['close-all-windows-but-current', 'mode main']

# Join with adjacent windows
alt-shift-h = ['join-with left', 'mode main']
alt-shift-j = ['join-with down', 'mode main']
alt-shift-k = ['join-with up', 'mode main']
alt-shift-l = ['join-with right', 'mode main']


[mode.resize.binding]
    h = 'resize width -50'
    j = 'resize height +50'
    k = 'resize height -50'
    l = 'resize width +50'
    enter = 'mode main'
    esc = 'mode main'
