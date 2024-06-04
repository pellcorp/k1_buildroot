
# Klipper Mod for Creality K1 (Max)

This is an *unofficial* mod to run Moonraker, custom Klipper, Mainsail & Fluidd on the Creality K1 (Max) printers and unlock the full power of open source software.

Klipper Mod for the K1 is designed to be fully removable and not break any functions of the stock software.

The mod is adapted for the K1 from the great work done by the [Flashfloreg Mod Project](https://github.com/xblax/flashforge_ad5m_klipper_mod).

> [!CAUTION]
> *If you want to install this mod to your K1 (Max) then be aware, that you risk to loose your warranty or damage the printer. Proceed at your own risk if you want to try this mod!*

*This mod is currently in alpha stage.* Many features are implemented already but they need to be tested thoroughly and polished a bit by early adopters.

> [!CAUTION]
> *This mod currently breaks PRTouch and expects users to replace it with a probe (Eddy, BLTouch, Microprobe)*


## Feature Overview

- [Klipper](https://www.klipper3d.org/) (Currently on the BTT Eddy branch) ‒ with improved configuration and default macros
- [Moonraker](https://github.com/Arksine/moonraker) on port 7125
- [Mainsail](https://docs.mainsail.xyz/) on port 4000
- [Fluidd](https://docs.fluidd.xyz/) on port 4001
- [Guppyscreen](https://github.com/ballaswag/guppyscreen) ‒ preview build variant
- Camera streaming via [ustreamer](https://github.com/pikvm/ustreamer) on port 8080
- [Moonraker-timelapse](https://github.com/mainsail-crew/moonraker-timelapse) support
- Network access: WiFi WPA Supplicant
- Customized Linux environment based on [Buildroot](https://buildroot.org/)
- SSH root access. Login: `root`, Password: `guppy`
- Automatic USB flash drive mounting
- "Dual boot" with stock K1 software

## Roadmap
- [KlipperScreen](https://klipperscreen.readthedocs.io/en/latest/) ‒ separate build variant
- Network access: Ethernet LAN (K1 Max) [iwd](https://iwd.wiki.kernel.org/)
- LCD backlight


All features of the mod run directly on the printer built-in system (X2000E). No additional hardware is required.

## Getting Started

Download test latest [Release Build](https://github.com/ballaswag/creality_k1_klipper_mod/releases) and read through the documentation for [Installation](docs/INSTALL.md). Also make yourself familiar with the [Uninstall](docs/UNINSTALL.md) methods, to get rid of the mod if you don't like it.

The Klipper Mod for K1 (Max) is currently provided in only one variant: 
- Alpha Guppy Screen variant for a more ligthweight UI on the limited hardware of the K1/Max. If you encounter any issues that could be caused by resource exhaustion (mostly system RAM), please check if the issue also occurs with the default stock.

You are welcome to participate int the [GitHub Discussions](https://github.com/ballaswag/creality_k1_klipper_mod/discussions) or open a new [Issue](https://github.com/ballaswag/creality_k1_klipper_mod/issues) if you find any bugs.

## Configuring a Probe
This mod currently abandons PRTouch and expects a probe to configured. By default, it uses the BTT Eddy probe configuration. Microprobe and BLTouch configurations are also avaible and can be enabled/disabled by editting `printer.cfg`. For probe that requires calibration, follow their respective manual to complete the initial collabration.

### BTT Eddy (TLDR)
Assuming firmware already flashed on the Eddy.
1. With Eddy ~20mm above bed, run `LDC_CALIBRATE_DRIVE_CURRENT CHIP=btt_eddy`
2. `SAVE_CONFIG`
3. `G28 X Y` (Home X Y)
4. `G0 X125 Y125 F6000` (Center Nozzle)
5. `PROBE_EDDY_CURRENT_CALIBRATE CHIP=btt_eddy` (Triggers manual z offse calibration - paper test)
6. `SAVE_CONFIG`

For detail BTT Eddy setup refer to their work-in-progress [guide](https://github.com/bigtreetech/Eddy).

## Documentation

Due to the beta stage of Klipper Mod the documentation is not fully-completed. The documentation is split into several topics:

- [Install](docs/INSTALL.md): How to install Klipper Mod
- [Uninstall](docs/UNINSTALL.md): Uninstall Klipper Mod
- [Linux Environment](docs/LINUX.md): Klipper Mod Linux environment
- [Guppy Screen](docs/GUPPY_SCREEN.md)
- [Camera](docs/CAMERA.md)
- [USB](docs/USB.md)
- [Build Instructions](docs/BUILDING.md)
