-- Helix Space Mode Keymaps in Neovim
-- Designed to match Helix space bindings using fzf-lua and Neovim LSP/builtins

local fzf = require("fzf-lua")

-- Helper function to check if a buffer has an active LSP client
local function has_lsp()
  return #vim.lsp.get_clients({ bufnr = 0 }) > 0
end

-- LSP Hover (Space + k)
vim.keymap.set("n", "<leader>k", function()
  if has_lsp() then
    vim.lsp.buf.hover()
  else
    vim.notify("No active LSP client for current buffer", vim.log.levels.WARN)
  end
end, { desc = "Show documentation for item under cursor" })

-- LSP Rename (Space + r)
vim.keymap.set("n", "<leader>r", function()
  if has_lsp() then
    vim.lsp.buf.rename()
  else
    vim.notify("No active LSP client for current buffer", vim.log.levels.WARN)
  end
end, { desc = "Rename symbol" })

-- LSP Code Actions (Space + a)
vim.keymap.set("n", "<leader>a", function()
  if has_lsp() then
    fzf.lsp_code_actions()
  else
    vim.notify("No active LSP client for current buffer", vim.log.levels.WARN)
  end
end, { desc = "Apply code action" })

-- LSP References (Space + h)
vim.keymap.set("n", "<leader>h", function()
  if has_lsp() then
    fzf.lsp_references()
  else
    vim.notify("No active LSP client for current buffer", vim.log.levels.WARN)
  end
end, { desc = "Select symbol references" })

-- LSP Document Symbols (Space + s)
vim.keymap.set("n", "<leader>s", function()
  if has_lsp() then
    fzf.lsp_document_symbols()
  else
    -- Fallback to document outline if LSP isn't active, or just notify
    vim.notify("No active LSP client for current buffer", vim.log.levels.WARN)
  end
end, { desc = "Open document symbol picker" })

-- LSP Workspace Symbols (Space + S)
vim.keymap.set("n", "<leader>S", function()
  if has_lsp() then
    fzf.lsp_live_workspace_symbols()
  else
    vim.notify("No active LSP client for workspace symbols", vim.log.levels.WARN)
  end
end, { desc = "Open workspace symbol picker" })

-- LSP Document Diagnostics (Space + d)
vim.keymap.set("n", "<leader>d", function()
  fzf.diagnostics_document()
end, { desc = "Open document diagnostics picker" })

-- LSP Workspace Diagnostics (Space + D)
vim.keymap.set("n", "<leader>D", function()
  fzf.diagnostics_workspace()
end, { desc = "Open workspace diagnostics picker" })

-- File Pickers
-- Space + f: Open file picker at LSP workspace root / project root
vim.keymap.set("n", "<leader>f", function()
  fzf.files()
end, { desc = "Open file picker" })

-- Space + F: Open file picker at current working directory (CWD)
vim.keymap.set("n", "<leader>F", function()
  fzf.files({ cwd = vim.fn.getcwd() })
end, { desc = "Open file picker at current working directory" })

-- File Explorers
-- Space + e: Open file explorer at workspace root
vim.keymap.set("n", "<leader>e", ":E<CR>", { silent = true, desc = "Open file explorer" })

-- Space + .: Open file explorer at current buffer's directory
vim.keymap.set("n", "<leader>.", ":Explore %:p:h<CR>", { silent = true, desc = "Open file explorer at buffer directory" })

-- Other Pickers
-- Space + b: Open buffer picker
vim.keymap.set("n", "<leader>b", function()
  fzf.buffers()
end, { desc = "Open buffer picker" })

-- Space + j: Open jumplist picker
vim.keymap.set("n", "<leader>j", function()
  fzf.jumps()
end, { desc = "Open jumplist picker" })

-- Space + g: Open changed file picker (Git status)
vim.keymap.set("n", "<leader>g", function()
  fzf.git_status()
end, { desc = "Open changed file picker" })

-- Space + ': Open last fuzzy picker
vim.keymap.set("n", "<leader>'", function()
  fzf.resume()
end, { desc = "Open last fuzzy picker" })

-- Space + /: Global search in workspace folder
vim.keymap.set("n", "<leader>/", function()
  fzf.live_grep()
end, { desc = "Global search in workspace folder" })

-- Space + ?: Open command palette
vim.keymap.set("n", "<leader>?", function()
  fzf.commands()
end, { desc = "Open command palette" })

-- Window Mode
-- Space + w: Enter window mode
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Enter window mode" })

-- Clipboard Mappings (System Clipboard "+)
-- Space + y: Yank selections to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })

-- Space + Y: Yank main selection to clipboard (For Neovim, same as yank selection)
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y', { desc = "Yank selection to system clipboard" })

-- Space + p: Paste system clipboard after selection
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste system clipboard after" })

-- Space + P: Paste system clipboard before selection
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste system clipboard before" })

-- Space + R: Replace selections by clipboard contents (Visual mode)
vim.keymap.set("v", "<leader>R", '"_d"+P', { desc = "Replace selection with clipboard" })

-- Commenting Mappings (using Neovim native commenting)
-- Space + c: Comment/uncomment selections
vim.keymap.set("n", "<leader>c", "gcc", { remap = true, desc = "Toggle line comment" })
vim.keymap.set("v", "<leader>c", "gc", { remap = true, desc = "Toggle selection comment" })

-- Space + C: Block comment/uncomment selections
vim.keymap.set("n", "<leader>C", "gbc", { remap = true, desc = "Toggle block comment line" })
vim.keymap.set("v", "<leader>C", "gb", { remap = true, desc = "Toggle block selection comment" })

-- Space + Alt-c: Line comment/uncomment selections
vim.keymap.set("n", "<leader><A-c>", "gcc", { remap = true, desc = "Toggle line comment" })
vim.keymap.set("v", "<leader><A-c>", "gc", { remap = true, desc = "Toggle line comment selection" })

-- Helix-style LSP Goto Mappings
-- gd: Go to definition
vim.keymap.set("n", "gd", function()
  if has_lsp() then
    fzf.lsp_definitions()
  else
    vim.notify("No active LSP client for definition", vim.log.levels.WARN)
  end
end, { desc = "Go to definition" })

-- gD: Go to declaration
vim.keymap.set("n", "gD", function()
  if has_lsp() then
    fzf.lsp_declarations()
  else
    vim.notify("No active LSP client for declaration", vim.log.levels.WARN)
  end
end, { desc = "Go to declaration" })

-- gy: Go to type definition
vim.keymap.set("n", "gy", function()
  if has_lsp() then
    fzf.lsp_typedefs()
  else
    vim.notify("No active LSP client for type definition", vim.log.levels.WARN)
  end
end, { desc = "Go to type definition" })

-- gr: Go to references
vim.keymap.set("n", "gr", function()
  if has_lsp() then
    fzf.lsp_references()
  else
    vim.notify("No active LSP client for references", vim.log.levels.WARN)
  end
end, { desc = "Go to references" })

-- gi: Go to implementation
vim.keymap.set("n", "gi", function()
  if has_lsp() then
    fzf.lsp_implementations()
  else
    vim.notify("No active LSP client for implementation", vim.log.levels.WARN)
  end
end, { desc = "Go to implementation" })
