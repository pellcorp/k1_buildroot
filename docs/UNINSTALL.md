# Uninstall

There are multiple options to uninstall Klipper Mod from an K1 (Max) printer.

> [!WARNING]
> During uninstall, all you local changes to the mod are removed from the printer. That includes all your custom files such as the G-Code files or custom Klipper configuration. Make sure to create a back-up if you want to re-install at a later point.
>
> If you just want to go back to go back to the stock software occasionally, consider to use on of the Dual Boot options described in the [Install](INSTALL.md) documentation.

> [!CAUTION]
> A power cycle is required after uninstall to allow the stock firmware to reflash toolhead firmware back to the old stock version.

## Uninstall via USB

Create a marker file `klipper_mod_remove` in the USB thumb drive, plug it into the printer then reboot will automatic uninstall the mod.

## Uninstall via SSH

Log in via SSH run the command `remove-klipper-mod`. Confirm removal. The printer will reboot and automatically uninstall the mod during start-up.

## Uninstall via Klipper Macro

Run the macro `REMOVE_KLIPPER_MOD` and confirm the removal. The printer will reboot and automatically uninstall the mod during start-up.
