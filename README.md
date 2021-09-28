# cmp-skkeleton

[denops-skkeleton.vim](https://github.com/vim-skk/denops-skkeleton.vim) source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

**This project is still work in progress. unstable.**

## Usage

Packer
```lua
use 'hrsh7th/nvim-cmp'
use 'vim-denops/denops.vim'
use 'vim-skk/denops-skkeleton.vim'
use { 'rinx/cmp-skkeleton', after = { 'nvim-cmp', 'denops-skkeleton.vim' } }
```

```lua
require('cmp').setup {
  sources = {
    { name = 'skkeleton' }
  }
}
```
