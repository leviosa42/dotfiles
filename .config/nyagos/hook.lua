nyagos.preexechook = function(args)
	-- %OLDPWD%
	local oldpwd = nyagos.getwd()
	nyagos.env.OLDPWD = oldpwd
end

nyagos.postexechook = function(args)
	-- %PWD%
	local pwd = nyagos.getwd()
	nyagos.env.PWD = pwd
end
