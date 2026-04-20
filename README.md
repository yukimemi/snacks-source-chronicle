# snacks-source-chronicle

This is a [folke/snacks.nvim](https://github.com/folke/snacks.nvim) picker source for [chronicle.vim](https://github.com/yukimemi/chronicle.vim).

# Requirements

- [folke/snacks.nvim](https://github.com/folke/snacks.nvim)
- [yukimemi/chronicle.vim](https://github.com/yukimemi/chronicle.vim)

# Usage

Two picker sources are registered:

```vim
:lua Snacks.picker.chronicle_read()
:lua Snacks.picker.chronicle_write()
```

# Filtering

Two optional globals let you filter the entries shown in the picker. Both take a list of Lua patterns and are evaluated against each file path.

- `vim.g.chronicle_include_patterns`: if set, only paths matching at least one pattern are kept.
- `vim.g.chronicle_exclude_patterns`: paths matching any pattern are dropped.

When both are set, `include` is applied first, then `exclude`.

```lua
vim.g.chronicle_exclude_patterns = { "claude", "%.tmp$" }
```

# Sample configuration

```lua
vim.keymap.set("n", "mr", function() Snacks.picker.chronicle_read() end,  { desc = "Chronicle read" })
vim.keymap.set("n", "mw", function() Snacks.picker.chronicle_write() end, { desc = "Chronicle write" })
```

With [folke/lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "yukimemi/snacks-source-chronicle",
  dependencies = {
    "folke/snacks.nvim",
    "yukimemi/chronicle.vim",
  },
}
```

With [yukimemi/rvpm](https://github.com/yukimemi/rvpm):

```sh
rvpm add yukimemi/snacks-source-chronicle
```

Or write it directly in `config.toml`:

```toml
[[plugins]]
url = "yukimemi/snacks-source-chronicle"
depends = ["snacks.nvim", "chronicle.vim"]
on_map = [
  { lhs = "mr", mode = "n", desc = "Chronicle Read" },
  { lhs = "mw", mode = "n", desc = "Chronicle Write" },
]
```

# License

Licensed under MIT License.

Copyright (c) 2026 yukimemi
