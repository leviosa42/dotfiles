-- misc
alias({
    q = "__exit__",
    clear = "__cls__",
    clc = "__cls__",
    view = nyagos.which("explorer.exe"),
    reload = ("lua_f " .. nyagos.getenv("XDG_CONFIG_HOME") .. "/nyagos/nyagos.lua"),
})
nyagos.alias[":q"] = "__exit__"
-- cd
nyagos.alias[".."] = "cd .."

-- eza
if nyagos.which("eza") then
    alias({
        __eza__ = nyagos.which("eza"),
        eza = "__eza__ --color=automatic -1F --group-directories-first -h --git --time-style=long-iso",
        ls = "eza",
        ll = "ls -l",
        la = "ls -laa",
        lt = "eza -a -T -L=3 -I='node_modules|.git|.cache'"
    })
else
    alias({
        ls = "__ls__ -oF",
        ll = "ls -l",
        la = "ls -al"
    })
end
