
local M = {}

M.show_notifications = false

M.setup = function(show_notifications)
  M.show_notifications = show_notifications
end

M.message = function(msg, log_level)
    -- TODO: add VSCode support
    if(not M.show_notifications) then
        return
    end

    if(log_level == nil) then
        log_level = vim.log.levels.INFO
    else 
        log_level = vim.log.levels[string.upper(log_level)]
    end

    vim.notify(msg, log_level, { title = 'Persistent Macros' })

end

return M