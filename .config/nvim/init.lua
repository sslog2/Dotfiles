local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }) end
vim.opt.rtp:prepend(lazypath)

local function open_neotree()
    require("neo-tree.command").execute({ action = "show", path = vim.fn.expand("%:p:h") })
end

vim.api.nvim_create_autocmd("BufEnter", {
    callback = open_neotree,
})

require("vim-options")
require("keymaps")
require("lazy").setup("plugins")
