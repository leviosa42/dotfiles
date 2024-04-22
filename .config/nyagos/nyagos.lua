logger = require("util.logger")
logger.title = ".nyagos"

nyagos.env.OLDPWD = nyagos.getwd()

require("env")
require("alias")
require("prompt")
require("hook")
