<h1 align="center">.files</h1>

<br>

A backup of my personal dotfiles.

Feel free to take whatever you want here.

> My dotfiles are configured on 1280x800 screen resolution

## Information

| Programs   | Using             |
| ---------- | ----------------- |
| WM         | awesome           |
| Editor     | neovim            |
| Compositor | picom             |
| Terminal   | alacritty         |
| Launcher   | rofi              |
| Music      | ncmpcpp / spotify |

## Setup

- Dependencies
    ```shell
    $ paru -S awesome-git picom-jonaburg-fix alacritty rofi acpi acpid \ 
    inotify-tools polkit-gnome light pulseaudio xdotool maim wireless_tools\ 
    playerctl mpdris2 mpc colord
    ```

- Fonts
    + **Iosevka**  - [here](https://github.com/be5invis/Iosevka)
    + **Icomoon**  - [here](https://www.dropbox.com/s/hrkub2yo9iapljz/icomoon.zip?dl=0)
    + **Material** - [here](https://github.com/google/material-design-icons)

- Config
    ```shell
    $ git clone --recurse-submodules https://github.com/ner0z/dotfiles.git
    $ cd dotfiles

    # Copy these files
    $ mkdir -p $HOME/.config/ && cp -r ./config/* $HOME/.config/
    $ mkdir -p $HOME/.local/bin/ && cp -r ./bin/* $HOME/.local/bin/
    $ cp -r ./misc/* $HOME/
    ```

## Shots

!['main'](https://i.imgur.com/nvXb9KN.png)

## Acknowledgements

- Thanks to
    + [rxyhn](https://github.com/rxyhn)
    + [javacafe01](https://github.com/JavaCafe01)
    + [elenapan](https://github.com/elenapan)

