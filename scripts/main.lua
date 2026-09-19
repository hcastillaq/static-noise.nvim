#!/usr/bin/env -S nvim --headless --clean -u NONE -l

local script_path = vim.fn.fnamemodify(arg[0], ":p")
local root = vim.fn.fnamemodify(script_path, ":h:h")
package.path = root .. "/?.lua;" .. root .. "/?/init.lua;" .. package.path

local function run_build()
  require("scripts.lib.build").run(root)
end

local function run_validation()
  require("scripts.lib.validate").run(root)
end

local log = require("scripts.lib.log")

local function run_all()
  log.step(1, 2, "building adapter")
  run_build()
  log.step(2, 2, "validating adapter")
  run_validation()
end

local function usage()
  print([[Usage:
  ./scripts/main.lua                 build and validate the theme
  ./scripts/main.lua sync             use upstream/target.json to update the snapshot]])
end

local command = arg[1]
if command == nil or command == "all" then
  run_all()
elseif command == "sync" then
  require("scripts.lib.upstream").sync(root)
elseif command == "build" then
  run_build()
elseif command == "validate" then
  run_validation()
elseif command == "help" then
  usage()
else
  usage()
  error("static-noise: unknown command " .. tostring(command), 0)
end
