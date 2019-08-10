# Installing MTGA on macOS using Wine, and making it look pretty!

The following instructions are heavily inspired by [/u/uhohohdear](https://www.reddit.com/user/uhohohdear).

**IMPORTANT UPDATE:** ~~ WOTC just released a [new executable](https://forums.mtgarena.com/forums/threads/58489) that should work with these original directions. I updated the download link below.

## Dependencies

0. Your macOS/OS X version must be 10.8 or greater
1. Your Mac must support OpenGL 4.0 or greater (you can find out whether it does [here](https://support.apple.com/HT202823))
2. You must download the [Magic the Gathering Arena Windows executable](https://forums.mtgarena.com/forums/threads/58489)
3. You must download [makeMTGArena.zip](https://github.com/abcbarryn/MTGArena-for-mac/releases/download/Ver-1.0/MTGArena.zip) and unzip it. It will create MTGArena.app, which is a custom Wineskin wrapper you can use to install MTGArena.

*Note: If you're like me, you may not trust unofficial Wineskin wrappers. Unfortunately, the Wineskin project is way behind and only supports Wine 2.x. We need at least Wine 3.0 to run MTGA. If Wineskin ever gets around to updating, you can get the official download [here](http://wineskin.urgesoftware.com/tiki-index.php?page=Downloads).*

## Installing MTGA

0. Drag the custom Wineskin wrapper to your `/Applications/` folder.
1. Right click/Control click the Wineskin wrapper (MTGArena.app) and select "Open"

*Note: The wrapper has "Screen Options" and then "Auto Detect GPU Info for Direct3D" unchecked and "Use Mac Driver instead of X11" checked. If you complete installation of MTGA and are getting DirectX 11 errors, come back to this step and change these settings, but the defaults sjould work.*

2. Click "Install Software"
3. Click "Choose Setup Executable"
4. Navigate to and select the Magic the Gathering Arena Windows executable you previously downloaded ("MTGAInstaller_0.1.1615.720204.msi")
5. Wait for MTGA to install and ignore any warnings (hopefully you won't have any!). When complete, click "Finish"
6. Back in Wineskin, a "Choose Executable" window should be available. Select "MTGA.exe".

You can now click "Quit" and start playing MTGA! If you'd like to add Retina support, carry on.

## Adding Retina/HiDPI Support

0. In Wineskin, click "Advanced" and then select "Tools"
1. Click "Registry Editor (regedit)"
2. Navigate to `HKEY_CURRENT_USER -> Software -> Wine -> Mac Driver` (if `Mac Driver` doesn't exist, navigate to `HKEY_CURRENT_USER -> Software -> Wine` and then use `Edit -> New -> Key` to create a new key named `Mac Driver`)
3. Select `Edit -> New -> String Value` from the menu and name it `RetinaMode`
4. Double click `RetinaMode`, set its value to `y`, and click "OK"
5. Close the Registry Editor and then click "Config Utility (winecfg)" in Wineskin's Advanced -> Tools menu
6. Click on the "Graphics" tab, enter the correct dpi under "Screen resoution", and click "OK".

  *Note: You can find your screen's dpi on [Apple Support](https://support.apple.com/en-us/HT202471) or via [DPI Love](http://dpi.lv/).*
  
You can now close Wineskin and start playing MTGA in high resolution!

## FAQS

### I'm getting a DirectX 11 error and it's making me sad.
This wrapper already includes the fixes below, so you should not have these issues.

Repeat steps 0 and 1 under "Installing MTGA" and trying unchecking "Auto Detect GPU Info for Direct3D" and checking "Use Mac Driver instead of X11". If you're still having problems, use TextEdit to create a plaintext file (use `shift+command+T` to toggle between rich text and plaintext) with the following information:

```
REGEDIT4
[HKEY_CURRENT_USER\Software\Wine\Direct3D]
"DirectDrawRenderer"="opengl"
"UseGLSL"="enabled"
"MaxVersionGL"=dword:00030003
```

Save this file as `d3d.reg`. Go to `/Applications/` then right click/control click the Wineskin wrapper (MTGArena.app) and select "Show Package Contents". Open "Wineskin.app". In Wineskin, click "Advanced", select "Tools", and then click "Registry Editor (regedit)". From the "Registry" menu, choose "Import Registry File..." and select the `d3d.reg` file you just created. Close regedit, exit Wineskin, and try running MTGArena again.

### I'm playing MTGA in windowed mode and, after switching to another program, it stops responding.
Everything is fine. Just grab the MTGA window and wiggle it a little bit. Everything should be back to normal.

### I tried to launch MTGA and I get some error that crashes the program!
Again, the fix for this is already applied but I left the question in the FAQ, you should not have this issue with this wrapper.

This is a common issue with running MTGA in Wine. Close the program and wait a few seconds. It should work fine on the second attempt. ¯\\\_(ツ)\_/¯

If this really bugs you, here's a fix so that MTGA will launch perfectly every time:

0. Right/control-click the Wineskin wrapper (MTGArena.app) and select "Show Package Contents"
1. Navigate to `Contents/MacOS`
2. Rename "WineskinLauncer" to "WineskinLauncher.bin"
3. Create a new plaintext file in `Content/MacOS` and save it as "WineskinLauncher"

  *Note: If you're using TextEdit, make sure you've turned off the option to add a .txt file extension.*

4. Paste the following inside of the new WineskinLauncher file:

```
#!/bin/sh

dir=$(dirname "$(dirname "$0")")
rm -f "$dir/Resources/drive_c/Program Files/Wizards of the Coast/MTGA/MTGA_Data/Logs/PerfLogRecord.dat" >/dev/null 2>&1
exec "$dir"/MacOS/WineskinLauncher.bin $@
```

5. In Terminal, run `chmod 755 /Applications/MTGArena.app/Contents/MacOS/WineskinLauncher`

### There's an Arena update and nothing works anymore!
Yeah. It's annoying. You will need to download a new msi and reinstall.

1. Either unzip the empty Wineskin wrapper again (MTGArena.app) or right click it and select "Show Package Contents" and click "Wineskin" then click "Advanced", then "Tools", then "Rebuild Wrapper". You should now have an "empty" wrapper again. Exit.
3. Double click the wrapper and select "Install Software"
4. Click "Choose Setup Executable"
5. Navigate to and select the Magic the Gathering Arena Windows msi file you previously downloaded
6. Install as above.
