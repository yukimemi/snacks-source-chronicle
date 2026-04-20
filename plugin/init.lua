-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20.
-- =============================================================================

local function read_lines(path)
  if path == nil or path == "" then
    return {}
  end
  local expanded = vim.fn.expand(path)
  if vim.fn.filereadable(expanded) == 0 then
    return {}
  end
  return vim.fn.readfile(expanded)
end

local function match_any(file, patterns)
  for _, pattern in ipairs(patterns) do
    if file:match(pattern) then
      return true
    end
  end
  return false
end

local function accept(file)
  local include = vim.g.chronicle_include_patterns
  if type(include) == "table" and #include > 0 and not match_any(file, include) then
    return false
  end
  local exclude = vim.g.chronicle_exclude_patterns
  if type(exclude) == "table" and #exclude > 0 and match_any(file, exclude) then
    return false
  end
  return true
end

local function make_finder(path_var)
  return function()
    local lines = read_lines(vim.g[path_var])
    local items = {}
    for _, file in ipairs(lines) do
      if file ~= "" and accept(file) then
        items[#items + 1] = {
          text = file,
          file = file,
        }
      end
    end
    return items
  end
end

local sources = {
  chronicle_read = {
    finder = make_finder("chronicle_read_path"),
    format = "file",
    preview = "file",
    confirm = "jump",
  },
  chronicle_write = {
    finder = make_finder("chronicle_write_path"),
    format = "file",
    preview = "file",
    confirm = "jump",
  },
}

local function register()
  if not _G.Snacks or not _G.Snacks.picker then
    return false
  end
  Snacks.picker.sources = Snacks.picker.sources or {}
  for name, src in pairs(sources) do
    Snacks.picker.sources[name] = src
  end
  return true
end

if not register() then
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = register,
  })
  vim.api.nvim_create_autocmd("User", {
    pattern = "SnacksReady",
    once = true,
    callback = register,
  })
end
