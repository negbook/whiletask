--
load(LoadResourceFile("tasksync", 'tasksync.lua'))()

Tasksync._scaleformHandle = {}
Tasksync._scaleformHandleDrawing = {}
Tasksync._scaleformInfo = {}

Tasksync._loadscaleform = function(scaleformName,cb)
	local scaleformHandle = RequestScaleformMovie(scaleformName)
	while not HasScaleformMovieLoaded(scaleformHandle) do
		Citizen.Wait(0)
	end
	Tasksync._scaleformHandle[scaleformName] = scaleformHandle
	Tasksync._sendscaleformvalues = function (...)
		local tb = {...}
		PushScaleformMovieFunction(Tasksync._scaleformHandle[scaleformName],tb[1])
		for i=2,#tb do
			if type(tb[i]) == "number" then 
				if math.type(tb[i]) == "integer" then
						ScaleformMovieMethodAddParamInt(tb[i])
				else
						ScaleformMovieMethodAddParamFloat(tb[i])
				end
			elseif type(tb[i]) == "string" then ScaleformMovieMethodAddParamTextureNameString(tb[i])
			elseif type(tb[i]) == "boolean" then ScaleformMovieMethodAddParamBool(tb[i])
			end
		end 
		PopScaleformMovieFunctionVoid()
	end
	if cb then 
		cb(Tasksync._sendscaleformvalues)
	end 
end

Tasksync.ScaleformDraw = function(scaleformName,cb,layer, x ,y ,width ,height ,red ,green ,blue ,alpha ,unk) 
	if not Tasksync._scaleformHandleDrawing[scaleformName] then 
		Tasksync._loadscaleform(scaleformName,cb)
		if Tasksync._scaleformHandle[scaleformName] then 
			Tasksync._scaleformHandleDrawing[scaleformName] = true  
			Tasksync.addloop('scaleforms:draw:'..scaleformName,0,function()
				local handle = Tasksync._scaleformHandle[scaleformName]
				if handle then 
					if layer then SetScriptGfxDrawOrder(layer) end 
					DrawScaleformMovieFullscreen(handle)
					if layer then ResetScriptGfxAlign() end
				else 
					Tasksync.deleteloop('scaleforms:draw:'..scaleformName)
					Tasksync._scaleformHandleDrawing[scaleformName] = false 
				end 
			end)
		end 
	else 
		error("Duplicated Drawing Scaleform",2)
	end 
end 

Tasksync.ScaleformDrawMini = function(scaleformName, x ,y ,width ,height ,red ,green ,blue ,alpha ,unk, cb,layer) 
	if not Tasksync._scaleformHandleDrawing[scaleformName] then 
		Tasksync._loadscaleform(scaleformName,cb)
		if Tasksync._scaleformHandle[scaleformName] then 
			Tasksync._scaleformHandleDrawing[scaleformName] = true  
			Tasksync.addloop('scaleforms:draw:'..scaleformName,0,function()
				local handle = Tasksync._scaleformHandle[scaleformName]
				if handle then 
					if layer then SetScriptGfxDrawOrder(layer) end 
					DrawScaleformMovie(handle ,x ,y ,width ,height ,red ,green ,blue ,alpha ,unk )
					if layer then ResetScriptGfxAlign() end
				else 
					Tasksync.deleteloop('scaleforms:draw:'..scaleformName)
					Tasksync._scaleformHandleDrawing[scaleformName] = false 
				end 
			end)
		end
	else 
		error("Duplicated Drawing Scaleform",2)
	end 
end 

Tasksync.ScaleformCall = function(scaleformName,cb) 
	if not cb then error("What is you want to call?",2) end 
	Tasksync._loadscaleform(scaleformName,cb)
end 

Tasksync.ScaleformEnd = function(scaleformName,cb) 
	SetScaleformMovieAsNoLongerNeeded(Tasksync._scaleformHandle[scaleformName])
	Tasksync._scaleformHandle[scaleformName] = nil 
end 
