# NeoVim Config

To install the config, copy init.lua to ~/.config/nvim/init.lua

if ~/.config/nvim/ doesnt exist just make a new folder

![Preview](https://i.imgur.com/bCPQGqO.png)

### Keybinds

Ctrl + f Focus on file tree

Ctrl + t Toggle file tree

Ctrl + k Search for files

Ctrl + s Save File

### How to Use it With Godot

To use the nvim config with godot, go to editor settings and find the option called "Editor" under "Dotnet".
Set the external editor to "Custom", the "Custom Exec Path" to nvim or whatever your neovim binary is called. Then put `--server /tmp/godot.pipe --remote-send "<esc>:n {file}<CR>:call cursor({line},{col})<CR>"` in the "Custom Exec Path Args" textbox.
Now restart godot and doubleclick your script. Then open your script with neovim and it should work. This supports GDScript and C#.
