nyagos.env.PROMPT = ">^..^<$$ "

nyagos.prompt = function(this)
    -- local user = nyagos.getenv('USERNAME')
    -- local host = nyagos.getenv('USERDOMAIN')
    -- local home = nyagos.getenv('HOME') or nyagos.getenv('USERPROFILE')
    -- local pat  = '^' .. home:gsub('[().%%+-*?%[%]^$]', '%%%0')
    -- local cwd  = nyagos.netdrivetounc(nyagos.getwd()):gsub(pat, '~')
    local nyan = nyagos.getenv("ERRORLEVEL") == "0" and '$e[36m=^..^=' or '$e[31m=^xx^='
    local root = nyagos.elevated() and '#' or '$$'
    return nyagos.default_prompt(
        '$e[39;0m' .. -- default, off
        '┌ ' .. '$e[33m' .. '$p' .. '$e[39;0m:' .. '\n' ..
        '└ ' .. '$e[39;0m' .. nyan .. '$s' .. '$e[39;0m' .. root .. '$e[0m' .. '$s',
        'NYAGOS'
    )
end