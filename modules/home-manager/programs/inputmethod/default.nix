{pkgs, ...}: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
    fcitx5.waylandFrontend = true;
  };

  # fcitx5 configuration
  home.file.".config/fcitx5/profile" = {
    force = true;
    text = ''
[Groups/0]
# Group Name
Name=Default
# Layout
Default Layout=us
# Default Input Method
DefaultIM=mozc

[Groups/0/Items/0]
# Name
Name=keyboard-us
# Layout
Layout=

[Groups/0/Items/1]
# Name
Name=mozc
# Layout
Layout=

[GroupOrder]
0=Default
    '';
  };

  home.file.".config/fcitx5/config" = {
    force = true;
    text = ''
[Hotkey]
# Enumerate when press trigger key repeatedly
EnumerateWithTriggerKeys=True
# Skip first input method while enumerating
EnumerateSkipFirst=False

[Hotkey/TriggerKeys]
0=Control+space
1=Zenkaku_Hankaku

[Hotkey/AltTriggerKeys]
0=Shift_L

[Hotkey/EnumerateForwardKeys]
0=Control+Shift_L

[Hotkey/EnumerateBackwardKeys]
0=Control+Shift_R

[Hotkey/PrevPage]
0=Up

[Hotkey/NextPage]
0=Down

[Hotkey/PrevCandidate]
0=Shift+Tab

[Hotkey/NextCandidate]
0=Tab

[Hotkey/TogglePreedit]
0=Control+Alt+P

[Behavior]
# Active By Default
ActiveByDefault=False
# Share Input State
ShareInputState=No
# Show preedit in application
PreeditEnabledByDefault=True
# Show Input Method Information when switch input method
ShowInputMethodInformation=True
# Show Input Method Information when changing focus
ShowInputMethodInformationWhenFocusIn=False
# Show compact input method information
CompactInputMethodInformation=True
# Show first input method information
ShowFirstInputMethodInformation=True
# Default page size
DefaultPageSize=10
# Override Xkb Option
OverrideXkbOption=False
# Custom Xkb Option
CustomXkbOption=
# Force Enabled Addons
EnabledAddons=
# Force Disabled Addons
DisabledAddons=
# Preload input method to be used by default
PreloadInputMethod=True
# Allow input method in the password field
AllowInputMethodForPassword=False
# Show preedit text when typing password
ShowPreeditForPassword=False
# Interval of saving user data in minutes
AutoSavePeriod=30

[Notifications]
# Hidden Notifications
HiddenNotifications=fcitx-diagnose,fcitx5-diagnose

[Behavior/Notifications]
# Show Notification After Input Method Changed
ShowInputMethodChangedNotification=False
    '';
  };
}
