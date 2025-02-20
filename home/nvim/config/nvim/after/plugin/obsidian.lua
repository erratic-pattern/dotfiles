local obsidian = require "obsidian"

--- Returns the given day of the current week as Unix time
--- @param day integer A day specifier in the range 1-7 with 1 representing Sunday
--- @return integer dayOfWeek the day as Unix time
local function dayOfWeek(day)
  if day < 1 or day > 7 then error("Day must be within range 1-7") end
  -- Current time as a table
  local current_time = os.date("*t", os.time())
  -- Truncate to midnight of current day as Unix time
  local current_day = os.time { year = current_time.year, month = current_time.month, day = current_time.day }
  -- Roll back/forward to Monday
  local offset = 86400 * -(current_time.wday - day)
  return current_day + offset
end

vim.api.nvim_create_autocmd("filetype", {
  pattern = "markdown",
  callback = function(event)
    -- set conceallevel on markdown to allow obsidian-nvim ui features
    vim.opt_local.conceallevel = 2
  end
})

-- Global keybinds
vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianNew<cr>", { noremap = true });
vim.keymap.set("v", "<leader>nn", "<cmd>ObsidianLinkNew<cr>", { noremap = true });
vim.keymap.set("n", "<leader>nd", "<cmd>ObsidianToday<cr>", { noremap = true });
vim.keymap.set("n", "<leader>nD", "<cmd>ObsidianTomorrow<cr>", { noremap = true });
vim.keymap.set("n", "<leader>ny", "<cmd>ObsidianYesterday<cr>", { noremap = true });
vim.keymap.set("n", "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", { noremap = true });
vim.keymap.set("n", "<leader>nt", "<cmd>ObsidianNewFromTemplate<cr>", { noremap = true });
vim.keymap.set("n", "<leader>nT", "<cmd>ObsidianTags<cr>", { noremap = true });
vim.keymap.set("n", "<leader>nl", "<cmd>ObsidianLinks<cr>", { noremap = true });
-- note: issue with using <cmd>
-- see https://github.com/epwalsh/obsidian.nvim/issues/454
vim.keymap.set("v", "<leader>ne", ":ObsidianExtractNote<cr>", { noremap = true });


obsidian.setup({
  workspaces = {
    {
      name = "vault",
      path = "~/Notes",
    },
  },
  -- mappings defined in enter_note callback
  mappings = {},

  log_level = vim.log.levels.INFO,

  daily_notes = {
    --   -- Optional, if you keep daily notes in a separate directory.
    -- folder = "daily",
    --   -- Optional, if you want to change the date format for the ID of daily notes.
    --   date_format = "%Y-%m-%d",
    --   -- Optional, if you want to change the date format of the default alias of daily notes.
    --   alias_format = "%B %-d, %Y",
    --   -- Optional, default tags to add to each new daily note created.
    default_tags = { "daily" },
    --   -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    --   template = nil
  },

  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },

  -- Where to put new notes. Valid options are
  --  * "current_dir" - put new notes in same directory as the current buffer.
  --  * "notes_subdir" - put new notes in the default notes subdirectory.
  new_notes_location = "notes_subdir",

  notes_subdir = "notebox",

  -- Optional, customize how note IDs are generated given an optional title.
  ---@param title string|?
  ---@return string
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and an optional title suffix.
    if title then
      title = title:gsub("[ _/]", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      return os.time() .. "-" .. title
    else
      return tostring(os.time())
    end
  end,

  -- Optional, customize how note file names are generated given the ID, target directory, and title.
  ---@param spec { id: string, dir: obsidian.Path, title: string|? }
  ---@return string|obsidian.Path The full path to the new note.
  note_path_func = function(spec)
    -- This is equivalent to the default behavior.
    local path = spec.dir / tostring(spec.id)
    return path:with_suffix(".md")
  end,

  -- Optional, customize how wiki links are formatted. You can set this to one of:
  --  * "use_alias_only", e.g. '[[Foo Bar]]'
  --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
  --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
  --  * "use_path_only", e.g. '[[foo-bar.md]]'
  -- Or you can set it to a function that takes a table of options and returns a string, like this:
  wiki_link_func = function(opts)
    return require("obsidian.util").wiki_link_id_prefix(opts)
  end,

  -- Optional, customize how markdown links are formatted.
  markdown_link_func = function(opts)
    return require("obsidian.util").markdown_link(opts)
  end,

  -- Either 'wiki' or 'markdown'.
  preferred_link_style = "wiki",

  -- Optional, boolean or a function that takes a filename and returns a boolean.
  -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
  disable_frontmatter = false,

  -- Optional, alternatively you can customize the frontmatter data.
  ---@return table
  note_frontmatter_func = function(note)
    -- Add the title of the note as an alias.
    if note.title then
      note:add_alias(note.title)
    end

    local out = { id = note.id, aliases = note.aliases, tags = note.tags }

    -- `note.metadata` contains any manually added fields in the frontmatter.
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end

    return out
  end,

  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {
      start_of_week = function()
        return os.date("%Y-%m-%d", dayOfWeek(2)) -- Roll back/forward to Monday
      end,
      end_of_week = function()
        return os.date("%Y-%m-%d", dayOfWeek(6)) -- Roll back/forward to Friday
      end
    },

  },

  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  -- URL it will be ignored but you can customize this behavior here.
  ---@param url string
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    -- vim.fn.jobstart({ "open", url }) -- Mac OS
    -- vim.fn.jobstart({"xdg-open", url})  -- linux
    -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
    vim.ui.open(url) -- need Neovim 0.10.0+
  end,

  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
  -- file it will be ignored but you can customize this behavior here.
  ---@param img string
  follow_img_func = function(img)
    vim.fn.jobstart { "open", "-a", "Preview", img } -- Mac OS preview
    -- vim.fn.jobstart({"xdg-open", url})  -- linux
    -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
  end,

  -- Optional, set to true if you use the Obsidian Advanced URI plugin.
  -- https://github.com/Vinzent03/obsidian-advanced-uri
  use_advanced_uri = false,

  -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
  open_app_foreground = false,

  picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    name = "telescope.nvim",
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    note_mappings = {
      -- Create a new note from your query.
      new = "<C-x>",
      -- Insert a link to the selected note.
      insert_link = "<C-l>",
    },
    tag_mappings = {
      -- Add tag(s) to current note.
      tag_note = "<C-x>",
      -- Insert a tag at the current location.
      insert_tag = "<C-l>",
    },
  },

  -- Optional, sort search results by "path", "modified", "accessed", or "created".
  -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
  -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
  sort_by = "modified",
  sort_reversed = true,

  -- Set the maximum number of lines to read from notes on disk when performing certain searches.
  search_max_lines = 1000,

  -- Optional, determines how certain commands open notes. The valid options are:
  -- 1. "current" (the default) - to always open in the current window
  -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
  -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
  open_notes_in = "current",

  -- Optional, define your own callbacks to further customize behavior.
  callbacks = {
    -- Runs at the end of `require("obsidian").setup()`.
    ---@param client obsidian.Client
    post_setup = function(client) end,

    -- Runs anytime you enter the buffer for a note.
    ---@param client obsidian.Client
    ---@param note obsidian.Note
    enter_note = function(client, note)
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      vim.keymap.set("n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end, { noremap = false, expr = true, buffer = true })

      -- Smart action depending on context, either follow link or toggle checkbox.
      vim.keymap.set("n", "<cr>", function()
        return require("obsidian").util.smart_action()
      end, { noremap = false, buffer = true, expr = true })

      -- Toggle checkbox
      vim.keymap.set("n", "<leader>nc", function()
        return "<cmd>ObsidianToggleCheckbox<cr>"
      end, { noremap = true, buffer = true, expr = true })

      -- Toggle checkbox (visual mode)
      vim.keymap.set("v", "<leader>nc", function()
        return ":g//:ObsidianToggleCheckbox<cr>"
      end, { noremap = true, buffer = true, expr = true })

      -- Show backlinks
      vim.keymap.set("n", "<leader>nb", "<cmd>ObsidianBacklinks<cr>", { noremap = true, buffer = true })
    end,

    -- Runs anytime you leave the buffer for a note.
    ---@param client obsidian.Client
    ---@param note obsidian.Note
    leave_note = function(client, note) end,

    -- Runs right before writing the buffer for a note.
    ---@param client obsidian.Client
    ---@param note obsidian.Note
    pre_write_note = function(client, note) end,

    -- Runs anytime the workspace is set/changed.
    ---@param client obsidian.Client
    ---@param workspace obsidian.Workspace
    post_set_workspace = function(client, workspace) end,
  },

  -- Optional, configure additional syntax highlighting / extmarks.
  -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
  ui = {
    enable = true,          -- set to false to disable all additional syntax features
    update_debounce = 200,  -- update delay after a text change (in milliseconds)
    max_file_length = 5000, -- disable UI features for files with more than this many lines
    -- Define how various check-boxes are displayed
    checkboxes = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      ["!"] = { char = "", hl_group = "ObsidianImportant" },
      -- Replace the above with this if you don't have a patched font:
      -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
      -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

      -- You can also add more custom ones...
    },
    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    -- Replace the above with this if you don't have a patched font:
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    block_ids = { hl_group = "ObsidianBlockID" },
    hl_groups = {
      -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      ObsidianTodo = { bold = true, fg = "#f78c6c" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianImportant = { bold = true, fg = "#d73128" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianBlockID = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#75662e" },
    },
  },

  -- Specify how to handle attachments.
  attachments = {
    -- The default folder to place images in via `:ObsidianPasteImg`.
    -- If this is a relative path it will be interpreted as relative to the vault root.
    -- You can always override this per image by passing a full path to the command instead of just a filename.
    img_folder = "assets/imgs", -- This is the default

    -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
    ---@return string
    img_name_func = function()
      -- Prefix image names with timestamp.
      return string.format("%s", os.time())
    end,

    -- A function that determines the text to insert in the note when pasting an image.
    -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
    -- This is the default implementation.
    ---@param client obsidian.Client
    ---@param path obsidian.Path the absolute path to the image file
    ---@return string
    img_text_func = function(client, path)
      path = client:vault_relative_path(path) or path
      return string.format("![%s](%s)", path.name, path)
    end,
  },
})
