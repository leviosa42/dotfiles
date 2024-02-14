-- logger.lua
-- Utility module to log for .nyagos
local M = {}

M.INDENT = "\t"

M.depth = 0

M.title = ""

function M:log(...)
    local args = {...}
    local indent = M.INDENT:rep(M.depth)
    local title = "[" .. self.title .. "]"
    local message = table.concat(args, " ")
    print(title .. " " .. indent .. message)
end

return M