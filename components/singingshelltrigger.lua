
local SHELL_MUST_TAGS = { "singingshell" }
local SHELL_CANT_TAGS = { "INLIMBO" }
local function findentities(inst, range)
	local x, y, z = inst.Transform:GetWorldPosition()
	return TheSim:FindEntities(x, y, z, range, SHELL_MUST_TAGS, SHELL_CANT_TAGS)
end

local function cleanup(inst, cmp)
	if cmp ~= nil then
		for k, v in pairs(cmp.overlapping) do
			cmp.overlapping[k] = nil
		end
	else
		for k, v in pairs(inst.components.singingshelltrigger.overlapping) do
			inst.components.singingshelltrigger.overlapping[k] = nil
		end
	end
end

local function ondeath(inst)
	inst.components.singingshelltrigger:StopUpdating()
end

local function onresurrect(inst)
	inst.components.singingshelltrigger:StartUpdating()
end

local SingingShellTrigger = Class(function(self, inst)
	self.inst = inst

	self.trigger_range = 4
	self.findentitiesfn = findentities

	self.updating = false
	self.overlapping = {}

	if TheWorld.components.singingshellmanager ~= nil then
		self:StartUpdating()
	end

	self.inst:AddTag("singingshelltrigger")

	self.inst:ListenForEvent("onremove", cleanup)

	self.inst:ListenForEvent("death", ondeath)
	self.inst:ListenForEvent("respawnfromghost", onresurrect)
end)

function SingingShellTrigger:OnRemoveFromEntity()
	self.inst:RemoveTag("singingshelltrigger")

	self.inst:RemoveEventCallback("onremove", cleanup)
	
	cleanup(self.inst, self)
end

function SingingShellTrigger:StartUpdating()
	if not self.updating then
		self.inst:StartUpdatingComponent(self)
		self.updating = true
	end
end

function SingingShellTrigger:StopUpdating()
	if self.updating then
		self.inst:StopUpdatingComponent(self)
		cleanup(self.inst)
		self.updating = false
	end
end

function SingingShellTrigger:OnUpdate()
	for k, v in pairs(self.overlapping) do
		if v == true then
			self.overlapping[k] = false
		else
			self.overlapping[k] = nil
		end
	end

	local x, y, z = self.inst.Transform:GetWorldPosition()
	for i, v in ipairs(TheSim:FindEntities(x, y, z, self.trigger_range, SHELL_MUST_TAGS, SHELL_CANT_TAGS)) do
		if self.overlapping[v] == nil then
			self.overlapping[v] = true
			v:_activatefn()
		elseif self.overlapping[v] == false then
			self.overlapping[v] = true
		end
	end
end

return SingingShellTrigger