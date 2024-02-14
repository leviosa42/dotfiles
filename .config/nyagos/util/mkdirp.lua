-- mkdirp.lua

return function(path)
    nyagos.exec({"mkdir", "/p", path})
end
