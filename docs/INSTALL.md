
# Install

Klipper Mod for the K1 (Max) is designed to be fully removable and not break any functions of the stock software.

> [!CAUTION]
> *If you want to install this Klipper Mod to your K1 (Max) then be aware, that you risk to loose your warranty or damage the printer. Proceed at your own risk if you want to try this mod!*

## Installation

The mod is provided as a gzipped tarball:

1) Download the latest `K1-KlipperMod*.tgz` file from [Releases](https://github.com/ballaswag/creality_k1_klipper_mod/releases) and extract its content into a temporary directory on the K1.
2) In the temporary directory, run `./k1mod_init.sh`
3) Wait, this takes couple minutes because the extraction and swap creation takes time.
4) Verify `k1mod_init.sh` exits with code `0`.
5) Power cycle (must flip the power switch off and on to allow flashing of the toolhead firmware).

After installation the printer will by default start the Klipper Mod system instead of the stock K1 software. It is still possible to start the stock software without uninstalling the mod, if needed. See section [Dual Boot](#dual-boot) below.

### Install Custom Files

The Klipper Mod installer has a mechanism to install custom files from USB flash drive during the installation. All files that are put inside the `klipper_mod` folder will be copied to the same path in the mod system as inside the `klipper_mod` folder.

> **Example**  
> A file `klipper_mod/var/lib/iwd/MyWifi.psk` on the USB drive will be copied to `/var/lib/iwd/MyWifi.psk` during installation.

This mechanism can also be used to overwrite default config files. Check the [Linux](LINUX.md) documentation page for more info about the file system layout.

### Initial Network Setup

Once rebooted, Guppy Screen will start. Use the WIFI menu in Guppy Screen to rejoin the WIFI network. The IP will be different from before. Refresh the Guppy Screen System tab to see the new assigned IP.

It is also possible to install a custom network configuration via the custom file installation mechanism described above. 

## Updating

Updating the mod works similar to the installation. Be aware that that most local changes are lost during the update. Only a limited set of files is preserved while updating:

- Moonraker database
- G-Code files
- Network configuration and hostname
- Dropbear SSH Keys

To remove all persistent files, [Uninstall](UNINSTALL.md) the mod before re-installing.

> [!WARNING]
> If you have important files like custom printer configs make sure to create a backup before updating. You can use the custom file installation mechanism to re-install them from the USB drive.

## Dual Boot

There are multiple options to boot the stock Flashforge software, while the mod is installed.

- USB drive: put a file named `klipper_mod_skip` on a USB drive and plug it in before printer start
- SSH: log in via SSH and run the command `reboot-stock-system` to restart and boot the stock software
- Klipper Macro: Execute the Klipper macro `REBOOT_STOCK_SYSTEM`
