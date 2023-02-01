# Half-Life (GoldSrc) Linux Font Patches
Patch unreadable fonts on Half-Life 1 (GoldSrc) based games on Linux.

![image](https://user-images.githubusercontent.com/14541962/215915153-32132781-630f-4c4f-a0d1-e7f4fa533378.png)


**There are patches available for**
* Counter-Strike 1.6
* Day of Defeat 1.2

# Installation
## Automatic installer (under construction)
### Prerequisites
The installer is based on ruby. So ensure ruby is already installed on your system.

To check, if it is available, just run the following command in your terminal:
```bash
ruby -v
```
> ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-linux]


If you do not get a version response, usually you can install it by using your package manager.

```bash
# Ubuntu Linux
sudo apt install ruby
# Arch Linux / Manjaro
sudo pacman -S ruby
# Fedora Linux / CentOS
sudo dnf install ruby
```
### Install
Run
```bash
\curl -sSL https://raw.githubusercontent.com/magynhard/halflife_goldsrc_linux_font_patches/master/setup.rb | ACTION=INSTALL ruby
```
in your terminal to run the automatic installer script.

It will automatically detect your Linux Distro and install everything necessary.

### Uninstall
To uninstall you can run the following command:

```bash
\curl -sSL https://raw.githubusercontent.com/magynhard/halflife_goldsrc_linux_font_patches/master/setup.rb | ACTION=UNINSTALL ruby
```

## Manual install
1. Install the fonts from `fonts` of this repo in your distribution.
2. Ensure that the font cache is cleared by command.
3. Copy the file(s) of the mod (e.g. `cstrike`) in the same folder of your installation.
4. Star your game and have fun again!
