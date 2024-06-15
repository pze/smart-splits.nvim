local types = require('smart-splits.types')
local Direction = types.Direction
local log = require('smart-splits.log')

local dir_keys_zellij = {
    [Direction.left] = 'Left',
    [Direction.right] = 'Right',
    [Direction.up] = 'Up',
    [Direction.down] = 'Down',
}


local function zellij_exec(args)
end

---@type SmartSplitsMultiplexer
local M = {}

M.type = 'zellij'

---@return boolean
function M.current_pane_at_edge(direction)
    return false
end

function M.is_in_session()
    return vim.env.ZELLIJ_SESSION_NAME ~= nil
end

---Try to get current tmux pane ID
---returns nil if failed or not in a tmux session.
---@return string|nil
function M.current_pane_id()
end

function M.current_pane_is_zoomed()
    return false
end

function M.next_pane(direction)
end

function M.resize_pane(direction, amount)
    if not M.is_in_session() then
        return false
    end

    direction = dir_keys_tmux[direction] ---@diagnostic disable-line
    local ok, _ = pcall(zellij_exec, { 'resize-pane', string.format('-%s', direction), amount })
    return ok
end

function M.split_pane(direction, size)
end

function M.on_init()

end

function M.on_exit()
end

return M
