function campres(inst)
	inst:AddTag("freeresurrector")
	inst:AddComponent("freeresurrector")
	return inst
end
function freerespostinit(inst)
	print "campres freeres"
	inst.oldresdo = inst.DoResurrect
	inst.oldrescan = inst.CanResurrect

	inst.FindClosestFreeResurrector = function(self)
		local res = nil
		local closest_dist = 0
		for k,v in pairs(GLOBAL.Ents) do
			if v.components.freeresurrector then
				local dist = v:GetDistanceSqToInst(self.inst)
				if not res or dist < closest_dist then
					res = v
					closest_dist = dist
				end
			end
		end
		return res
	end
	
	inst.CanResurrect = function (self)
		self:oldrescan()
		
		local res = self:FindClosestFreeResurrector()
	
		if res then
			return true
		end
		
	end
	
	inst.DoResurrect = function(self)
		self:oldresdo()
		local res = self:FindClosestFreeResurrector()
	
		if res and res.components.freeresurrector then
			print "free camp res do"
			res.components.freeresurrector:Resurrect(self.inst)
			return true
		end
	end
end

AddPrefabPostInit('firepit', campres)
AddComponentPostInit("resurrectable", freerespostinit)