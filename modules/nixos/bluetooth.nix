{ config, lib, pkgs, ... }:
{
  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # LE (Low Energy) モードでキーボードをサポート
        ControllerMode = "le";
        # 実験的機能を有効化（一部のキーボードで必要）
        Experimental = true;
        # 高速接続を有効化
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # Enable Blueman for Bluetooth management
  services.blueman.enable = true;
}
