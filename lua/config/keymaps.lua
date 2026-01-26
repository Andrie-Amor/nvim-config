local arrow_modes = { "n", "i", "v", "s", "o" }
local arrow_keys = { "<Up>", "<Down>", "<Left>", "<Right>" }

local function arrow_hint()
  vim.notify_once("Arrow keys are disabled (use hjkl). Toggle: <leader>ta or :ArrowKeysToggle")
end

local function disable_arrow_keys()
  for _, mode in ipairs(arrow_modes) do
    for _, key in ipairs(arrow_keys) do
      vim.keymap.set(mode, key, arrow_hint, { silent = true, desc = "Arrow keys disabled" })
    end
  end
  vim.g.arrow_keys_disabled = true
end

local function enable_arrow_keys()
  for _, mode in ipairs(arrow_modes) do
    for _, key in ipairs(arrow_keys) do
      pcall(vim.keymap.del, mode, key)
    end
  end
  vim.g.arrow_keys_disabled = false
end

local function toggle_arrow_keys()
  if vim.g.arrow_keys_disabled then
    enable_arrow_keys()
    vim.notify("Arrow keys enabled")
  else
    disable_arrow_keys()
    vim.notify("Arrow keys disabled")
  end
end

vim.api.nvim_create_user_command("ArrowKeysDisable", function()
  disable_arrow_keys()
  vim.notify("Arrow keys disabled")
end, {})

vim.api.nvim_create_user_command("ArrowKeysEnable", function()
  enable_arrow_keys()
  vim.notify("Arrow keys enabled")
end, {})

vim.api.nvim_create_user_command("ArrowKeysToggle", toggle_arrow_keys, {})

vim.keymap.set("n", "<leader>ta", toggle_arrow_keys, { desc = "Toggle arrow keys" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

disable_arrow_keys()
