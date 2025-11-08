# Neovim 0.12 Config

This is a minimal, single-file `init.lua` setup for Neovim 0.12+, using native package management (`vim.pack`) and a light suite of modern plugins.

## Requirements

* **Neovim 0.12** or newer.
* **`git`** must be installed and available in your `PATH`.
* A **[Nerd Font](https://www.nerdfonts.com/font-downloads)** is required for icons in `lualine`, `bufferline`, and `nvim-tree`.

---

## Installation

1.  **Create the config directory:**
    ```bash
    mkdir -p ~/.config/nvim
    ```

2.  **Save the configuration:**
    Place the full `init.lua` content into `~/.config/nvim/init.lua`.

3.  **Launch Neovim:**
    Open Neovim by running `nvim`.

4.  **Install Plugins:**
    On the first launch, a `vim.pack` prompt should ask to install the missing plugins.
    * **Press `A`** to install **A**ll plugins.

5.  **Restart Neovim:**
    Once all plugins are installed, quit and restart `nvim`. The setup, including Treesitter parsers, should complete automatically.

---

## Keymap Overview

This configuration uses `,` (comma) as the **leader** key.

### General Editor & Text

* `<leader>w` (n) : Toggle word wrap ON
* `<leader>W` (n) : Toggle word wrap OFF
* `Y` (n) : Yank line (full line)
* `<C-c>` (n) : Copy current line to clipboard
* `<C-c>` (v) : Copy selection to clipboard
* `>` (v) : Indent selection
* `<` (v) : Outdent selection

### Window & Buffer Management

* `<C-h>` (n) : Move window to far left
* `<C-l>` (n) : Move window to far right
* `gt` (n) : Go to next buffer
* `gT` (n) : Go to previous buffer
* `gb` (n) : [Telescope] Go to buffer
* `<leader>sb` (n) : [Telescope] Search buffers

### File & Project Navigation

* `<C-n>` (n) : Toggle NvimTree file explorer
* `<M-1>` (n) : Open Oil file explorer
* `<M-2>` (n) : Open MiniFiles file explorer
* `<C-p>` (n) : [Telescope] Find files
* `<C-e>` (n) : [Telescope] Find old files (history)

### Telescope (Search)

* `<leader>sg` (n) : Live Grep (search project text)
* `<leader>sw` (n) : Grep for word under cursor
* `<leader>sf` (n) : Search Functions (LSP)
* `<leader>sc` (n) : Search Classes (LSP)
* `<leader>sv` (n) : Search Variables (LSP)
* `<leader>ss` (n) : Search All Symbols (LSP)
* `<leader>sh` (n) : Search help tags
* `<leader>sk` (n) : Search keymaps

### LSP & Code

* `gd` (n) : Go to Definition
* `K` (n) : Hover documentation
* `[d` (n) : Go to previous diagnostic
* `]d` (n) : Go to next diagnostic
* `<leader>ca` (n) : Code Actions
* `<leader>rn` (n) : Rename symbol
* `<leader>vr` (n) : View References
* `<leader>vws` (n) : View Workspace Symbols
* `<leader>lf` (n) : Format buffer (LSP)
* `<C-h>` (i) : Signature Help (in insert mode)

### Diagnostics & Quickfix

* `<leader>ge` (n) : Jump to next diagnostic
* `<leader>gE` (n) : Jump to previous diagnostic
* `<leader>vd` (n) : Show diagnostic in float
* `<leader>sd` (n) : [Telescope] Search all diagnostics
* `<leader>x` (n) : Close quickfix window
* `<leader>sn` (n) : Next item in quickfix
* `<leader>sp` (n) : Previous item in quickfix
* `<leader>sq` (n) : [Telescope] Search quickfix list

### Bookmarks (bookmarks.nvim)

* `<leader>ba` (n) : Add bookmark at line
* `<leader>br` (n) : Remove bookmark at line
* `<leader>bl` (n) : [Telescope] List all bookmarks
* `mn` (n) : Jump to next bookmark (plugin default)
* `mp` (n) : Jump to previous bookmark (plugin default)
