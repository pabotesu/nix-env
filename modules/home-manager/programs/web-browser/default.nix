{
  pkgs,
  lib,
  ...
}: {
   programs = {
     vivaldi = lib.mkIf pkgs.stdenv.isLinux {
       enable = true;
       commandLineArgs = ["--enable-features=WebUIDarkMode" "--force-dark-mode"];
     };
   };
 }
