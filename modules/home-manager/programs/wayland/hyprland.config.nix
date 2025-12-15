{envTheme, envColors}:
''

#-----------------------#
#       variables       #
#-----------------------#

$mainMod = ALT
$subMod = SUPER
$WOBSOCK = $XDG_RUNTIME_DIR/wob.sock

#-----------------------#
#      environment      #
#-----------------------#
env = QT_QPA_PLATFORM,wayland
env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
env = MOZ_ENABLE_WAYLAND,1
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland
env = XDG_CURRENT_DESKTOP,Hyprland
env = _JAVA_AWT_WM_NONREPARENTING,1
env = XMODIFIERS,@im=fcitx
env = QT_IM_MODULE,fcitx
env = bitdepth,10

#-----------------------#
#       monitor         #
#-----------------------#

# ---- nix-bookmonitor ---- #
# 内蔵ディスプレイ (ThinkPad T14 Gen1)
monitor=eDP-1, 1920x1080@60, 0x0, 1
monitor=DP-1, preferred, auto, 1
monitor=DP-2, preferred, auto, 1
monitor=, preferred, auto, 1

#-----------------------#
#       workspace       #
#-----------------------#
workspace = 1, monitor:eDP-1, default:true, persistent:true

#-----------------------#
#       exec-tools      #
#-----------------------#

exec-once = /home/pabotesu/.nix-profile/bin/waybar
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XMODIFIERS QT_IM_MODULE
exec-once = mako # notification tool
exec-once = hypridle
exec-once = wl-paste --type text --watch cliphist store # Stores only text data
exec-once = wl-paste --type image --watch cliphist store # Stores only image data
exec-once = rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob # indicator tool
exec-once = fcitx5 -D --replace
exec-once = nm-applet --indicator # NetworkManager system tray
exec-once = blueman-applet # Bluetooth system tray
exec-once = /run/current-system/sw/libexec/polkit-gnome-authentication-agent-1 # Polkit authentication for 1Password


# Some default env vars.
env = XCURSOR_SIZE,14

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 5
    gaps_out = 5
    border_size = 2
    col.active_border = rgba(${envColors.fg}ee) rgba(${envColors.blue}ee) 45deg
    col.inactive_border = rgba(${envColors.black}aa)

    layout = dwindle

    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
    allow_tearing = false
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10
    
    blur {
        enabled = true
        size = 3
        passes = 1
    }

    shadow {
        enabled = yes
        range = 4
        render_power = 3
        color = rgba(${envColors.black}ee)
    }
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_on_active = true
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    # workspace_swipe is disabled by default in recent versions
}

misc {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
device:epic-mouse-v1 {
#    sensitivity = -0.5
}

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


#-----------------------#
#       key-binds       #
#-----------------------#

# Screenlock
bind = $subMod, L, exec, hyprlock

# Start Launcher
bind = $mainMod, D, exec, pkill wofi || wofi --show drun -I
bind = $mainMod SHIFT, E, exec, pkill wlogout || wlogout -b 5

# Start Terminal
bind = $mainMod, Return,  exec, alacritty

# Full Screen Window
bind = $mainMod, F, fullscreen

# Floating Window
bind = $mainMod SHIFT, F, togglefloating

# Volume
bind = , XF86AudioRaiseVolume, exec, pamixer -i 10 && pamixer --get-volume > $WOBSOCK
bind = , XF86AudioLowerVolume, exec, pamixer -d 10 && pamixer --get-volume > $WOBSOCK
bind = , XF86AudioMute, exec, pamixer -t && ( pamixer --get-mute && echo 0 > $WOBSOCK ) || pamixer --get-volume > $WOBSOCK

# Volume Source
bind = SHIFT, XF86AudioRaiseVolume, exec, pamixer --default-source -i 10 && pamixer --default-source --get-volume > $WOBSOCK
bind = SHIFT, XF86AudioLowerVolume, exec, pamixer --default-source -d 10 && pamixer --default-source --get-volume > $WOBSOCK
bind = SHIFT, XF86AudioMute, exec, pamixer --default-source -t && ( pamixer --default-source --get-mute && echo 0 > $WOBSOCK ) || pamixer --default-source --get-volume > $WOBSOCK

# Microphone Mute (ThinkPad T14 Gen1: F4)
bind = , XF86AudioMicMute, exec, pamixer --default-source -t

# Brightness (ThinkPad T14 Gen1: F5/F6)
bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%- && echo $(($(brightnessctl get) * 100 / $(brightnessctl max))) > $WOBSOCK
bind = , XF86MonBrightnessUp, exec, brightnessctl set 5%+ && echo $(($(brightnessctl get) * 100 / $(brightnessctl max))) > $WOBSOCK

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod SHIFT, Q, killactive

# Screen Shot
bind = , PRINT, exec, grimblast --notify copy area | wl-paste -t image/png > ~/Pictures/Screenshots/$(date "+%Y%m%d-%H%M%S")'_grim_area.png'

# Clipboard History
bind = $mainMod SHIFT, P, exec, pkill wofi || (cliphist list | wofi --dmenu | cliphist decode | wl-copy)

# Move focus with mainMod + hjkl keys
bind = $mainMod, H, movefocus, l
bind = $mainMod, J, movefocus, d
bind = $mainMod, K, movefocus, u
bind = $mainMod, L, movefocus, r

# Move focus with mainMod + hjkl keys
bind = $mainMod SHIFT, H, movewindow, l
bind = $mainMod SHIFT, J, movewindow, d
bind = $mainMod SHIFT, K, movewindow, u
bind = $mainMod SHIFT, L, movewindow, r

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Example special workspace (scratchpad)
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Move/resize windows
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Window resize mode
bind = $mainMod SHIFT, R, submap, resize
submap = resize
binde = , h, resizeactive, 10 0
binde = , j, resizeactive, -10 0
binde = , k, resizeactive, 0 -10
binde = , l, resizeactive, 0 10
bind = , escape, submap, reset
submap = reset

''
