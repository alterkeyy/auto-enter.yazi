# auto-enter.yazi

A Yazi plugin that combines the best of `smart-enter` and `fast-enter`. It allows you to open files or enter directories with a single key, with optional support for jumping directly to the innermost folder.

## Features

- **Smart Entry**: Open files or enter directories using the same key.
- **Innermost Folder**: Automatically navigate through nested single-subfolder structures to reach the innermost directory.
- **Configurable**: Easily enable/disable multi-file opening and innermost folder navigation.

## Installation

```sh
# Example installation (adjust according to your package manager)
ya pkg add alterkeyy/auto-enter
```

## Usage

Bind a key (e.g., `l`) to the plugin in your `~/.config/yazi/keymap.toml`:

```toml
[[mgr.prepend_keymap]]
on   = "l"
run  = "plugin auto-enter"
desc = "Enter the child directory, or open the file"
```

## Configuration

Add the following to your `~/.config/yazi/init.lua` to customize the plugin's behavior:

```lua
require("auto-enter"):setup {
    open_multi = true,
    innermost = true,
}
```

- `open_multi`: If `true`, the `open` command will target all selected files. If `false` (default), it only targets the hovered file.
- `innermost`: If `true`, entering a directory will jump to the deepest nested subfolder if there is only one subfolder at each level.

## Credit
[ourongxing/fast-enter.yazi: Plugin for Yazi to enter the subfolder faster, or open the file directly.](https://github.com/ourongxing/fast-enter.yazi)
[plugins/smart-enter.yazi at main · yazi-rs/plugins](https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi)

## License

MIT
