theme: let
  removeHash = str: builtins.substring 1 (builtins.stringLength str) str;
in rec
{
  # "#RRGGBB"
  xcolors = import ./colors/${theme};
  # "RRGGBB"
  colors = builtins.mapAttrs (_: value: removeHash value) xcolors;
}
