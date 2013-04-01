local FreeResurrector = Class(function(self, inst)
    self.inst = inst
end)



--this is a bit presentationally-specific for component land but whatever.
function FreeResurrector:Resurrect(dude)
	print ("Camp Res!")
	
	self.inst:AddTag("busy")	
	GetClock():MakeNextDay()

	self:OnUsed()

    dude.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
    dude:Hide()
    TheCamera:SetDistance(12)

    scheduler:ExecuteInTime(3, function()
        dude:Show()
        --self.inst:Hide()
        --self.inst.AnimState:PlayAnimation("debris")
        
        dude.sg:GoToState("amulet_rebirth")
		
        --SaveGameIndex:SaveCurrent()
        
        dude:ListenForEvent("animover", function(inst)
			if inst.sg:HasStateTag("idle") then
				inst:RemoveEventCallback("animover")
			end
            self.inst:Show()
            if dude.HUD then
                dude.HUD:Show()
            end
            TheCamera:SetDefault()
            self.inst:RemoveTag("busy")
			if dude.components.hunger then
				dude.components.hunger:SetPercent(1)
			end
	
			if dude.components.health then
				--dude.components.health:RemovePenalty()
				dude.components.health:SetPercent(1)
			end
			
			if dude.components.sanity then
				dude.components.sanity:SetPercent(1)
			end
        end)
        
    end)
   
    --TheSim:SnapCamera()
    
end


function FreeResurrector:OnBuilt(builder)

end


function FreeResurrector:OnSave()

end

function FreeResurrector:OnLoad(data)
    if data.used then
        self:OnUsed()
        self.inst.AnimState:PlayAnimation("debris")
    end
end

function FreeResurrector:OnUsed()

end

function FreeResurrector:SetOnUsed(fn)
    self.onusedfn = fn
end

return FreeResurrector