local function onpercent(self)
    local percent = self:GetPercent()
    if percent >= 0.5 then
        if not self.inst:HasTag("fresh") then
            self.inst:RemoveTag("stale")
            self.inst:RemoveTag("spoiled")
            self.inst:AddTag("fresh")
            self.inst:PushEvent("forceperishchange")
        end
    elseif percent > 0.2 then
        if not self.inst:HasTag("stale") then
            self.inst:RemoveTag("fresh")
            self.inst:RemoveTag("spoiled")
            self.inst:AddTag("stale")
            self.inst:PushEvent("forceperishchange")
        end
    elseif not self.inst:HasTag("spoiled") then
        self.inst:RemoveTag("fresh")
        self.inst:RemoveTag("stale")
        self.inst:AddTag("spoiled")
        self.inst:PushEvent("forceperishchange")
    end
    --V2C: force clients to refresh spoilage icons when tags change,
    --     since the percent value may not change enough to be dirty
end

local Perishable = Class(function(self, inst)
    self.inst = inst
    self.perishfn = nil
    self.perishtime = nil

    self.frozenfiremult = false
    
    self.targettime = nil
    self.perishremainingtime = nil
    self.updatetask = nil
    self.dt = nil
    self.onperishreplacement = nil

    self.localPerishMultiplyer = 1
end,
nil,
{
    perishtime = onpercent,
    perishremainingtime = onpercent,
})

function Perishable:OnRemoveFromEntity()
    self.inst:RemoveTag("fresh")
    self.inst:RemoveTag("stale")
    self.inst:RemoveTag("spoiled")
end

function Perishable:OnRemoveEntity()
	self:StopPerishing()
end

local function Update(inst, dt)
	local self = inst.components.perishable
    if self ~= nil then
		dt = self.start_dt or dt
		self.start_dt = nil

		local modifier = 1
		local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner or nil
        if not owner and inst.components.occupier then
            owner = inst.components.occupier:GetOwner()
        end

		if owner then
			if owner.components.preserver ~= nil then
				modifier = owner.components.preserver:GetPerishRateMultiplier(inst) or modifier
			elseif owner:HasTag("fridge") then
				if inst:HasTag("frozen") and not owner:HasTag("nocool") and not owner:HasTag("lowcool") then
					modifier = TUNING.PERISH_COLD_FROZEN_MULT
				else
					modifier = TUNING.PERISH_FRIDGE_MULT
				end
            elseif owner:HasTag("foodpreserver") then
                modifier = TUNING.PERISH_FOOD_PRESERVER_MULT
			elseif owner:HasTag("cage") and inst:HasTag("small_livestock") then
                modifier = TUNING.PERISH_CAGE_MULT
            end

			if owner:HasTag("spoiler") then
				modifier = modifier * TUNING.PERISH_GROUND_MULT
			end
		else
			modifier = TUNING.PERISH_GROUND_MULT
		end

		if inst:GetIsWet() and not self.ignorewentness then
			modifier = modifier * TUNING.PERISH_WET_MULT
		end

		if TheWorld.state.temperature < 0 then
			if inst:HasTag("frozen") and not self.frozenfiremult then
				modifier = TUNING.PERISH_COLD_FROZEN_MULT
			else
				modifier = modifier * TUNING.PERISH_WINTER_MULT
			end
		end

		if self.frozenfiremult then
			modifier = modifier * TUNING.PERISH_FROZEN_FIRE_MULT
		end

		if TheWorld.state.temperature > TUNING.OVERHEAT_TEMP then
			modifier = modifier * TUNING.PERISH_SUMMER_MULT
		end

        modifier = modifier * self.localPerishMultiplyer

		modifier = modifier * TUNING.PERISH_GLOBAL_MULT
		
		local old_val = self.perishremainingtime
		local delta = dt or (10 + math.random()*FRAMES*8)
		if self.perishremainingtime then 
			self.perishremainingtime = math.min(self.perishtime, self.perishremainingtime - delta*modifier)
	        if math.floor(old_val*100) ~= math.floor(self.perishremainingtime*100) then
		        inst:PushEvent("perishchange", {percent = self:GetPercent()})
		    end
		end

        --Cool off hot foods over time (faster if in a fridge)
        --Skip and retain heat in containers with "nocool" tag
        if inst.components.edible ~= nil and inst.components.edible.temperaturedelta ~= nil and inst.components.edible.temperaturedelta > 0 and not (owner ~= nil and owner:HasTag("nocool")) then
            if owner ~= nil and owner:HasTag("fridge") then
                inst.components.edible:AddChill(1)
            elseif TheWorld.state.temperature < TUNING.OVERHEAT_TEMP - 5 then
                inst.components.edible:AddChill(.25)
            end
        end

        --trigger the next callback
        if self.perishremainingtime and self.perishremainingtime <= 0 then
			self:Perish()
        end
    end
end

function Perishable:IsFresh()
	return self.inst:HasTag("fresh")
end

function Perishable:IsStale()
	return self.inst:HasTag("stale")
end

function Perishable:IsSpoiled()
	return self.inst:HasTag("spoiled")
end

function Perishable:Dilute(number, timeleft)
	if self.inst.components.stackable then
        if self.perishremainingtime or self.perishtime then
            local perishtime = self.perishremainingtime or self.perishtime
            self.perishremainingtime = (self.inst.components.stackable.stacksize * perishtime + number * timeleft) / ( number + self.inst.components.stackable.stacksize )
        else
            self.perishremainingtime = timeleft
        end
		self.inst:PushEvent("perishchange", {percent = self:GetPercent()})
	end
end

function Perishable:SetPerishTime(time)
	self.perishtime = time
	self.perishremainingtime = time
    if self.updatetask ~= nil then
        self:StartPerishing()
    end
end

function Perishable:SetLocalMultiplier(newMult)
    self.localPerishMultiplyer = newMult
end

function Perishable:GetLocalMultiplier()
    return self.localPerishMultiplyer
end

function Perishable:SetNewMaxPerishTime(newtime)
    local percent = self:GetPercent()
    self.perishtime = newtime
    self:SetPercent(percent)
end

function Perishable:SetOnPerishFn(fn)
	self.perishfn = fn
end


function Perishable:GetPercent()
	if self.perishremainingtime and self.perishtime and self.perishtime > 0 then
		return math.min(1, self.perishremainingtime / self.perishtime)
	else
		return 0
	end
end

function Perishable:SetPercent(percent)
	if self.perishtime then 
		if percent < 0 then percent = 0 end
		if percent > 1 then percent = 1 end
		self.perishremainingtime = percent*self.perishtime
	    self.inst:PushEvent("perishchange", {percent = self.inst.components.perishable:GetPercent()})
	end

    if self.updatetask ~= nil then
        self:StartPerishing()
    end
end

function Perishable:ReducePercent(amount)
	local cur = self:GetPercent()
	self:SetPercent(cur - amount)
end

function Perishable:GetDebugString()
	if self.perishremainingtime and  self.perishremainingtime > 0 then
        return string.format("%s %2.2fs %s",
            self.updatetask and "Perishing" or "Paused",
            self.perishremainingtime,
            self.frozenfiremult and "frozenfiremult" or "")
	else
		return "perished"
	end
end

function Perishable:LongUpdate(dt)
    if self.updatetask ~= nil then
        Update(self.inst, dt or 0)
    end
end

function Perishable:StartPerishing()
    if self.updatetask ~= nil then
        self.updatetask:Cancel()
        self.updatetask = nil
    end

    local dt = 10 + math.random()*FRAMES*8
	self.start_dt = math.random()*2
    self.updatetask = self.inst:DoPeriodicTask(dt, Update, self.start_dt, dt)
end

function Perishable:Perish()
    if self.updatetask ~= nil then
        self.updatetask:Cancel()
        self.updatetask = nil
    end

    if self.perishfn ~= nil then
        self.perishfn(self.inst)
    end

    if self.inst:IsValid() then
        self.inst:PushEvent("perished")
    end

    --NOTE: callbacks may have removed this inst!

    if self.inst:IsValid() and self.onperishreplacement ~= nil then
        local goop = SpawnPrefab(self.onperishreplacement)
        if goop ~= nil then
            if goop.components.stackable ~= nil and self.inst.components.stackable ~= nil then
                goop.components.stackable:SetStackSize(self.inst.components.stackable.stacksize)
            end
            local owner = self.inst.components.inventoryitem ~= nil and self.inst.components.inventoryitem.owner or nil
            local holder = owner ~= nil and (owner.components.inventory or owner.components.container) or nil
            if holder ~= nil then
                local slot = holder:GetItemSlot(self.inst)
                self.inst:Remove()
                holder:GiveItem(goop, slot)
            else
                local x, y, z = self.inst.Transform:GetWorldPosition()
                self.inst:Remove()
                goop.Transform:SetPosition(x, y, z)
            end
        end
    end
end

function Perishable:StopPerishing()
    if self.updatetask ~= nil then
        self.updatetask:Cancel()
        self.updatetask = nil
    end
end

function Perishable:OnSave()
    return
    {
        paused = self.updatetask == nil or nil,
        time = self.perishremainingtime,
    }
end

function Perishable:OnLoad(data)
    if data ~= nil then
		if data.time ~= nil then
	        self.perishremainingtime = data.time
		end

        if data.paused then
            self:StopPerishing()
		elseif data.time ~= nil then
            self:StartPerishing()
        end
    end
end

return Perishable
