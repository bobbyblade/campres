function campres(inst)
	inst:AddTag("freeresurrector")
	inst:AddComponent("freeresurrector")
	return inst
end
function freerespostinit(inst)
	print "campres freeres"
	inst.oldresdo = inst.DoResurrect
	inst.oldrescan = inst.CanResurrect
	inst.CanResurrect = function (self)
		self:oldrescan()
		
		local res = TheSim:FindFirstEntityWithTag("freeresurrector")
		if res and res.components.freeresurrector then
			print "free camp res can"
			return true
		end
		
	end
	
	inst.DoResurrect = function(self)
		self:oldresdo()
		local res = TheSim:FindFirstEntityWithTag("freeresurrector")
		if res and res.components.freeresurrector then
			print "free camp res do"
			res.components.freeresurrector:Resurrect(self.inst)
			return true
		end
	end
end

AddPrefabPostInit('firepit', campres)
AddComponentPostInit("resurrectable", freerespostinit)