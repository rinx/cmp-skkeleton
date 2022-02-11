# cmp-skkeleton

[skkeleton](https://github.com/vim-skk/skkeleton) source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

**This project is still work in progress. unstable.**

## Usage

Packer
```lua
use 'hrsh7th/nvim-cmp'
use { 'vim-skk/skkeleton', requires = { 'vim-denops/denops.vim' } }
use { 'rinx/cmp-skkeleton', after = { 'nvim-cmp', 'skkeleton' } }
```

```lua
require('cmp').setup {
  sources = {
    { name = 'skkeleton' }
  }
  view = {
    entries = 'native'
  }
}
```

## Demo

![demo](https://user-images.githubusercontent.com/1588935/135282555-974e7637-776a-43a9-96f8-6a54cef6af41.gif)

Reference: [skkeleton's ddc.vim demo](https://github.com/vim-skk/skkeleton#completion-with-ddcvim)
