# ghidra

This directory used to vendor [zackelia/ghidra-dark](https://github.com/zackelia/ghidra-dark),
a Python script that patched a dark FlatLaf look into Ghidra. It only ever
supported Ghidra 9.0 through 10.1 and is obsolete: Ghidra 10.3 introduced a
real theme system, and current releases (12.x) ship a dark theme out of the box.
Nothing here needs installing any more.

## Switching to the built-in dark theme (Ghidra 10.3+ / 12.x)

1. Open the Ghidra project window (or any tool such as the CodeBrowser).
2. `Edit -> Theme -> Switch...`
3. Pick **Flat Dark** (there is also **Flat Light** and the classic Nimbus/Metal
   looks) and click OK. The choice is saved per Ghidra version under your user
   settings directory (`~/.config/ghidra/<version>/` on Linux,
   `~/Library/ghidra/<version>/` on macOS) and survives restarts.

`Edit -> Theme -> Configure...` lets you tweak individual colours, fonts and
icons on top of whatever theme is active.

## Saving a customised theme into this repo

Once you have configured a theme the way you like it:

1. `Edit -> Theme -> Save...` gives the customised theme a name (it becomes a
   `<name>.theme` file in the user settings directory above).
2. `Edit -> Theme -> Export...` writes that theme to a file of your choosing.
   Export as a plain `.theme` (choose the `.theme.zip` variant only if you
   changed icons and want them bundled).
3. Drop the exported file into `ghidra/themes/` in this repo and commit it.

## Restoring it on a new machine

1. `Edit -> Theme -> Import...` and select the file from `ghidra/themes/`.
2. `Edit -> Theme -> Switch...` and choose it.

Ghidra keeps a `.bak` of any theme it overwrites on import; those are
gitignored.
