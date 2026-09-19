local M = {}

local function write(level, message)
  print(string.format("[static-noise][%s] %s", level, message))
end

function M.info(message)
  write("INFO", message)
end

function M.success(message)
  write(" OK ", message)
end

function M.warn(message)
  write("WARN", message)
end

function M.error(message)
  write("FAIL", message)
end

function M.step(number, total, message)
  write(string.format("%d/%d", number, total), message)
end

return M
