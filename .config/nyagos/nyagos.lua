logger = require("util.logger")
logger.title = ".nyagos"

nyagos.env.OLDPWD = nyagos.getwd()

nyagos.eval("chcp 65001")

require("env")
require("alias")
require("prompt")
require("hook")
