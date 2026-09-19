local root = vim.fn.getcwd()
package.path = root .. "/?.lua;" .. root .. "/?/init.lua;" .. package.path
require("scripts.lib.validate").run(root)
