local present, presence = pcall(require, "presence")
if not present then
   return
end

presence:setup {
    -- General options
    auto_update         = true,
    neovim_image_text   = "The One True Text Editor",
    main_image          = "file",
    log_level           = nil,
    debounce_timeout    = 10,
    enable_line_number  = false,
    blacklist           = {},
    buttons             = true,

    -- Rich Presence text options
    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "Working on %s",
    line_number_text    = "Line %s out of %s",
}
