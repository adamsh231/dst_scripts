local containers = require("containers")

local function oncanbeopened(self, canbeopened)
    self.inst.replica.container:SetCanBeOpened(canbeopened)
end

local function onopener(self, opener)
    self.inst.replica.container:SetOpener(opener)
end

local Container = Class(function(self, inst)
    self.inst = inst
    self.slots = {}
    self.numslots = 0
    self.canbeopened = true
    self.acceptsstacks = true
    self.usespecificslotsforitems = false
    self.issidewidget = false
    self.type = nil
    self.widget = nil
    self.itemtestfn = nil
    self.opener = nil

    --Hacky flags for altering behaviour when moving items between containers
    self.ignoresound = false
end,
nil,
{
    canbeopened = oncanbeopened,
    opener = onopener,
})

local widgetprops =
{
    "numslots",
    "acceptsstacks",
    "usespecificslotsforitems",
    "issidewidget",
    "type",
    "widget",
    "itemtestfn",
}

function Container:WidgetSetup(prefab, data)
    for i, v in ipairs(widgetprops) do
        removesetter(self, v)
    end

    containers.widgetsetup(self, prefab, data)
    self.inst.replica.container:WidgetSetup(prefab, data)

    for i, v in ipairs(widgetprops) do
        makereadonly(self, v)
    end
end

function Container:GetWidget()
    return self.widget
end

function Container:NumItems()
    local num = 0
    for k,v in pairs(self.slots) do
        num = num + 1
    end

    return num
end

function Container:IsFull()
    local items = 0
    for k, v in pairs(self.slots) do
        items = items + 1
    end

    return items >= self.numslots
end

function Container:IsEmpty()
    return next(self.slots) == nil
end

function Container:SetNumSlots(numslots)
    assert(numslots >= self.numslots)
    self.numslots = numslots
end

function Container:DropItemBySlot(slot)
    local item = self:RemoveItemBySlot(slot)
    if item ~= nil then
        item.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
        if item.components.inventoryitem ~= nil then
            item.components.inventoryitem:OnDropped(true)
        end
        item.prevcontainer = nil
        item.prevslot = nil
        self.inst:PushEvent("dropitem", { item = item })
    end
end

function Container:DropEverythingWithTag(tag)
    local containers = {}

    for i = 1, self.numslots do
        local item = self.slots[i]
        if item ~= nil then
            if item:HasTag(tag) then
                self:DropItemBySlot(i)
            elseif item.components.container ~= nil then
                table.insert(containers, item)
            end
        end
    end

    for i, v in ipairs(containers) do
        v.components.container:DropEverythingWithTag(tag)
    end
end

function Container:DropEverything()
    for i = 1, self.numslots do
        self:DropItemBySlot(i)
    end
end

function Container:DropItem(itemtodrop)
    local item = self:RemoveItem(itemtodrop)
    if item then 
        local pos = Vector3(self.inst.Transform:GetWorldPosition())
        item.Transform:SetPosition(pos:Get())
        if item.components.inventoryitem then
            item.components.inventoryitem:OnDropped(true)
        end
        item.prevcontainer = nil
        item.prevslot = nil
        self.inst:PushEvent("dropitem", {item = item})
    end
end

function Container:CanTakeItemInSlot(item, slot)
    return item ~= nil
        and item.components.inventoryitem ~= nil
        and item.components.inventoryitem.cangoincontainer
        and not item.components.inventoryitem.canonlygoinpocket
        and (slot == nil or (slot >= 1 and slot <= self.numslots))
        and not (GetGameModeProperty("non_item_equips") and item.components.equippable ~= nil)
        and (self.itemtestfn == nil or self:itemtestfn(item, slot))
end

function Container:GetSpecificSlotForItem(item)
    if self.usespecificslotsforitems and self.itemtestfn ~= nil then
        for i = 1, self:GetNumSlots() do
            if self:itemtestfn(item, i) then
                return i
            end
        end
    end
end

function Container:AcceptsStacks()
    return self.acceptsstacks
end

function Container:IsSideWidget()
    return self.issidewidget
end

function Container:DestroyContents()
    for k = 1, self.numslots do
        local item = self:RemoveItemBySlot(k)
        if item ~= nil then
            item:Remove()
        end
    end
end

function Container:GiveItem(item, slot, src_pos, drop_on_fail)
    if item == nil then
        return false
    elseif item.components.inventoryitem ~= nil and self:CanTakeItemInSlot(item, slot) then
        if slot == nil then
            slot = self:GetSpecificSlotForItem(item)
        end

        --try to burn off stacks if we're just dumping it in there
        if item.components.stackable ~= nil and self.acceptsstacks then
            --Added this for when we want to dump a stack back into a
            --specific spot (e.g. moving half a stack failed, so we
            --need to dump the leftovers back into the original stack)
            if slot ~= nil and slot <= self.numslots then
                local other_item = self.slots[slot]
                if other_item ~= nil and other_item.prefab == item.prefab and other_item.skinname == item.skinname and not other_item.components.stackable:IsFull() then
                    if self.inst.components.inventoryitem ~= nil and self.inst.components.inventoryitem.owner ~= nil then
                        self.inst.components.inventoryitem.owner:PushEvent("gotnewitem", { item = item, slot = slot })
                    end

                    item = other_item.components.stackable:Put(item, src_pos)
                    if item == nil then
                        return true
                    end

                    slot = self:GetSpecificSlotForItem(item)
                end
            end

            if slot == nil then
                for k = 1, self.numslots do
                    local other_item = self.slots[k]
                    if other_item and other_item.prefab == item.prefab and other_item.skinname == item.skinname and not other_item.components.stackable:IsFull() then
                        if self.inst.components.inventoryitem ~= nil and self.inst.components.inventoryitem.owner ~= nil then
                            self.inst.components.inventoryitem.owner:PushEvent("gotnewitem", { item = item, slot = k })
                        end

                        item = other_item.components.stackable:Put(item, src_pos)
                        if item == nil then
                            return true
                        end
                    end
                end
            end
        end

        local in_slot = nil
        if slot ~= nil and slot <= self.numslots and not self.slots[slot] then
            in_slot = slot
        elseif not self.usespecificslotsforitems and self.numslots > 0 then
            for i = 1, self.numslots do
                if not self.slots[i] then
                    in_slot = i
                    break
                end
            end
        end

        if in_slot then
            --weird case where we are trying to force a stack into a non-stacking container. this should probably have been handled earlier, but this is a failsafe        
            if not self.acceptsstacks and item.components.stackable and item.components.stackable:StackSize() > 1 then
                item = item.components.stackable:Get()
                self.slots[in_slot] = item
                item.components.inventoryitem:OnPutInInventory(self.inst)
                self.inst:PushEvent("itemget", { slot = in_slot, item = item, src_pos = src_pos })
                return false
            end

            self.slots[in_slot] = item
            item.components.inventoryitem:OnPutInInventory(self.inst)
            self.inst:PushEvent("itemget", { slot = in_slot, item = item, src_pos = src_pos })

            if not self.ignoresound and self.inst.components.inventoryitem ~= nil and self.inst.components.inventoryitem.owner ~= nil then
                self.inst.components.inventoryitem.owner:PushEvent("gotnewitem", { item = item, slot = in_slot })
            end

            return true
        end
    end

    --default to true if nil
    if drop_on_fail ~= false then
        item.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
        if item.components.inventoryitem ~= nil then
            item.components.inventoryitem:OnDropped(true)
        end
    end
    return false
end

function Container:RemoveItemBySlot(slot)
    if slot and self.slots[slot] then
        local item = self.slots[slot]
        if item then
            self.slots[slot] = nil
            if item.components.inventoryitem then
                item.components.inventoryitem:OnRemoved()
            end

            self.inst:PushEvent("itemlose", {slot = slot, prev_item = item})
        end
        item.prevcontainer = self
        item.prevslot = slot
        return item
    end
end

function Container:RemoveAllItems()
    local collected_items = {}
    for i = 1, self.numslots do
        local item = self:RemoveItemBySlot(i)
        table.insert(collected_items, item)
    end

    return collected_items
end

function Container:GetNumSlots()
    return self.numslots
end

function Container:GetItemInSlot(slot)
    if slot and self.slots[slot] then
        return self.slots[slot]
    end
end

function Container:GetItemSlot(item)
    for k,v in pairs(self.slots) do
        if item == v then
            return k
        end
    end
end

function Container:GetAllItems()
    local collected_items = {}
    for k,v in pairs(self.slots) do
        if v ~= nil then
            table.insert(collected_items, v)
        end
    end 

    return collected_items
end

function Container:Open(doer)
    if self.opener == nil and doer ~= nil then
        self.inst:StartUpdatingComponent(self)

        local inventory = doer.components.inventory
        if inventory ~= nil then
            for k, v in pairs(inventory.opencontainers) do
                if k.prefab == self.inst.prefab or k.components.container.type == self.type then
                    k.components.container:Close()
                end
            end

            inventory.opencontainers[self.inst] = true
        end

        self.opener = doer

        if doer.HUD ~= nil then
            doer.HUD:OpenContainer(self.inst, self:IsSideWidget())
            if self:IsSideWidget() then
                TheFocalPoint.SoundEmitter:PlaySound("dontstarve/wilson/backpack_open")
            else
                if not self.skipopensnd then
                    TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/Together_HUD/container_open")
                end
            end
        elseif self.widget ~= nil
            and self.widget.buttoninfo ~= nil
            and doer.components.playeractionpicker ~= nil then
            doer.components.playeractionpicker:RegisterContainer(self.inst)
        end

        self.inst:PushEvent("onopen", { doer = doer })

        if self.onopenfn ~= nil then
            self.onopenfn(self.inst, { doer = doer })
        end
    end
end

function Container:Close()
    if self.opener ~= nil then
        self.inst:StopUpdatingComponent(self)

        local doer = self.opener
        self.opener = nil

        if doer.HUD ~= nil then
            doer.HUD:CloseContainer(self.inst, self:IsSideWidget())
            if self:IsSideWidget() then
                TheFocalPoint.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close")
            else
                if not self.skipclosesnd then
                    TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/Together_HUD/container_close")
                end
            end
        elseif doer.components.playeractionpicker ~= nil then
            doer.components.playeractionpicker:UnregisterContainer(self.inst)
        end

        if doer.components.inventory ~= nil then
            doer.components.inventory.opencontainers[self.inst] = nil
        end

        if self.onclosefn ~= nil then
            self.onclosefn(self.inst, doer)
        end

        self.inst:PushEvent("onclose", { doer = doer })
    end
end

function Container:IsOpen()
    return self.opener ~= nil
end

function Container:IsOpenedBy(guy)
    return self.opener == guy
end

local function CheckItem(item, target, checkcontainer)
    return target ~= nil
        and (item == target
            or (checkcontainer and
                target.replica.container ~= nil and
                target.replica.container:IsHolding(item, checkcontainer)))
end

function Container:IsHolding(item, checkcontainer)
    for k, v in pairs(self.slots) do
        if CheckItem(item, v, checkcontainer) then
            return true
        end
    end
end

function Container:FindItem(fn)
    for k,v in pairs(self.slots) do
        if fn(v) then
            return v
        end
    end
end

function Container:FindItems(fn)
    local items = {}

    for k,v in pairs(self.slots) do
        if fn(v) then
            table.insert(items, v)
        end
    end

    return items
end

function Container:Has(item, amount)
    local num_found = 0
    for k,v in pairs(self.slots) do
        if v and v.prefab == item then
            if v.components.stackable ~= nil then
                num_found = num_found + v.components.stackable:StackSize()
            else
                num_found = num_found + 1
            end
        end
    end

    return num_found >= amount, num_found
end

function Container:HasItemWithTag(tag, amount)
    local num_found = 0
    for k,v in pairs(self.slots) do
        if v and v:HasTag(tag) then
            if v.components.stackable ~= nil then
                num_found = num_found + v.components.stackable:StackSize()
            else
                num_found = num_found + 1
            end
        end
    end

    return num_found >= amount, num_found
end

function Container:GetItemByName(item, amount)
    local total_num_found = 0
    local items = {}

    local function tryfind(v)
        local num_found = 0
        if v and v.prefab == item then
            local num_left_to_find = amount - total_num_found
            if v.components.stackable then
                if v.components.stackable.stacksize > num_left_to_find then
                    items[v] = num_left_to_find
                    num_found = amount
                else
                    items[v] = v.components.stackable.stacksize
                    num_found = num_found + v.components.stackable.stacksize
                end
            else
                items[v] = 1
                num_found = num_found + 1
            end
        end
        return num_found
    end

    for k,v in pairs(self.slots) do
        total_num_found = total_num_found + tryfind(v)
        
        if total_num_found >= amount then
            break
        end
    end

    return items
end

local function tryconsume(self, v, amount)
    if v.components.stackable == nil then
        self:RemoveItem(v):Remove()
        return 1
    elseif v.components.stackable.stacksize > amount then
        v.components.stackable:SetStackSize(v.components.stackable.stacksize - amount)
        return amount
    else
        amount = v.components.stackable.stacksize
        self:RemoveItem(v, true):Remove()
        return amount
    end
    --shouldn't be possible?
    return 0
end

function Container:ConsumeByName(item, amount)
    if amount <= 0 then
        return
    end

    for k, v in pairs(self.slots) do
        if v.prefab == item then
            amount = amount - tryconsume(self, v, amount)
            if amount <= 0 then
                return
            end
        end
    end
end

function Container:OnSave()
    local data = {items= {}}
    local references = {}
    local refs = {}
    for k,v in pairs(self.slots) do
        if v:IsValid() and v.persists then --only save the valid items
            data.items[k], refs = v:GetSaveRecord()
            if refs then
                for k,v in pairs(refs) do
                    table.insert(references, v)
                end
            end
        end
    end
    return data, references
end

function Container:OnLoad(data, newents)
    if data.items then
        for k,v in pairs(data.items) do
            local inst = SpawnSaveRecord(v, newents)
            if inst then
                self:GiveItem(inst, k)
            end
        end
    end
end

function Container:RemoveItem(item, wholestack)
    if item == nil then
        return
    end

    local prevslot = self:GetItemSlot(item)

    if not wholestack and item.components.stackable ~= nil and item.components.stackable:IsStack() then
        local dec = item.components.stackable:Get()
        dec.prevslot = prevslot
        dec.prevcontainer = self
        return dec
    end

    for k, v in pairs(self.slots) do
        if v == item then
            self.slots[k] = nil
            self.inst:PushEvent("itemlose", { slot = k, prev_item = item })
            item.components.inventoryitem:OnRemoved()
            item.prevslot = prevslot
            item.prevcontainer = self
            return item
        end
    end

    return item
end

--------------------------------------------------------------------------
--Check for auto-closing conditions
--------------------------------------------------------------------------

function Container:OnUpdate(dt)
    if self.opener == nil then
        self.inst:StopUpdatingComponent(self)
    elseif not (self.inst.components.inventoryitem ~= nil and
                self.inst.components.inventoryitem:IsHeldBy(self.opener))
        and ((self.opener.components.rider ~= nil and self.opener.components.rider:IsRiding())
            or not (self.opener:IsNear(self.inst, 3) and
                    CanEntitySeeTarget(self.opener, self.inst))) then
        self:Close()
    end
end

Container.OnRemoveEntity = Container.Close
Container.OnRemoveFromEntity = Container.Close


--------------------------------------------------------------------------
--InvSlot click action handlers
--------------------------------------------------------------------------

local function QueryActiveItem(self)
    local inventory = self.opener ~= nil and self.opener.components.inventory or nil
    return inventory, inventory ~= nil and inventory:GetActiveItem() or nil
end

function Container:PutOneOfActiveItemInSlot(slot)
    local inventory, active_item = QueryActiveItem(self)
    if active_item ~= nil and
        self:GetItemInSlot(slot) == nil and
        self:CanTakeItemInSlot(active_item, slot) and
        active_item.components.stackable ~= nil and
        active_item.components.stackable:IsStack() then

        self.ignoresound = true
        self:GiveItem(active_item.components.stackable:Get(1), slot)
        self.ignoresound = false
    end
end

function Container:PutAllOfActiveItemInSlot(slot)
    local inventory, active_item = QueryActiveItem(self)
    if active_item ~= nil and
        self:GetItemInSlot(slot) == nil and
        self:CanTakeItemInSlot(active_item, slot) and
        (self:AcceptsStacks() or
        active_item.components.stackable == nil or
        not active_item.components.stackable:IsStack()) then

        inventory:RemoveItem(active_item, true)
        self.ignoresound = true
        self:GiveItem(active_item, slot)
        self.ignoresound = false
    end
end

function Container:TakeActiveItemFromHalfOfSlot(slot)
    local inventory, active_item = QueryActiveItem(self)
    local item = self:GetItemInSlot(slot)
    if item ~= nil and
        active_item == nil and
        inventory ~= nil and
        item.components.stackable ~= nil and
        item.components.stackable:IsStack() then

        local halfstack = item.components.stackable:Get(math.floor(item.components.stackable:StackSize() / 2))
        halfstack.prevslot = slot
        halfstack.prevcontainer = self
        inventory:GiveActiveItem(halfstack)
    end
end

function Container:TakeActiveItemFromAllOfSlot(slot)
    local inventory, active_item = QueryActiveItem(self)
    local item = self:GetItemInSlot(slot)
    if item ~= nil and
        active_item == nil and
        inventory ~= nil then

        self:RemoveItemBySlot(slot)
        inventory:GiveActiveItem(item)
    end
end

function Container:AddOneOfActiveItemToSlot(slot)
    local inventory, active_item = QueryActiveItem(self)
    local item = self:GetItemInSlot(slot)
    if active_item ~= nil and
        item ~= nil and
        self:CanTakeItemInSlot(active_item, slot) and
        item.prefab == active_item.prefab and item.skinname == active_item.skinname and 
        item.components.stackable ~= nil and
        self:AcceptsStacks() and
        active_item.components.stackable ~= nil and
        active_item.components.stackable:IsStack() and
        not item.components.stackable:IsFull() then

        item.components.stackable:Put(active_item.components.stackable:Get(1))
    end
end

function Container:AddAllOfActiveItemToSlot(slot)
    local inventory, active_item = QueryActiveItem(self)
    local item = self:GetItemInSlot(slot)
    if active_item ~= nil and
        item ~= nil and
        self:CanTakeItemInSlot(active_item, slot) and
        item.prefab == active_item.prefab and item.skinname == active_item.skinname and
        item.components.stackable ~= nil and
        self:AcceptsStacks() then

        local leftovers = item.components.stackable:Put(active_item)
        inventory:SetActiveItem(leftovers)
    end
end

function Container:SwapActiveItemWithSlot(slot)
    local inventory, active_item = QueryActiveItem(self)
    local item = self:GetItemInSlot(slot)
    if active_item ~= nil and
        item ~= nil and
        self:CanTakeItemInSlot(active_item, slot) and
        not (item.prefab == active_item.prefab and item.skinname == active_item.skinname and
            item.components.stackable ~= nil and
            self:AcceptsStacks()) and
        not (active_item.components.stackable ~= nil and
            active_item.components.stackable:IsStack() and
            not self:AcceptsStacks()) then

        inventory:RemoveItem(active_item, true)
        self:RemoveItemBySlot(slot)
        self:GiveItem(active_item, slot)
        inventory:GiveActiveItem(item)
    end
end

function Container:SwapOneOfActiveItemWithSlot(slot)
    local inventory, active_item = QueryActiveItem(self)
    local item = self:GetItemInSlot(slot)

    if active_item ~= nil and
        item ~= nil and
        self:CanTakeItemInSlot(active_item, slot) and
        not (item.prefab == active_item.prefab and item.skinname == active_item.skinname and item.components.stackable ~= nil) and
        (active_item.components.stackable ~= nil and active_item.components.stackable:IsStack()) then

        active_item = inventory:RemoveItem(active_item, false)
        self:RemoveItemBySlot(slot)
        self:GiveItem(active_item, slot)
        inventory:GiveItem(item, nil, self.inst:GetPosition())
    end
end

function Container:MoveItemFromAllOfSlot(slot, container)
    local item = self:GetItemInSlot(slot)
    if item ~= nil and container ~= nil then
        container = container.components.container or container.components.inventory
        if container ~= nil and container:IsOpenedBy(self.opener) then
            local targetslot =
                self.opener.components.constructionbuilderuidata ~= nil and
                self.opener.components.constructionbuilderuidata:GetContainer() == container.inst and
                self.opener.components.constructionbuilderuidata:GetSlotForIngredient(item.prefab) or
                nil

            if container:CanTakeItemInSlot(item, targetslot) then
                item = self:RemoveItemBySlot(slot)
                item.prevcontainer = nil
                item.prevslot = nil

                --Hacks for altering normal inventory:GiveItem() behaviour
                if container.ignoreoverflow ~= nil and container:GetOverflowContainer() == self then
                    container.ignoreoverflow = true
                end
                if container.ignorefull ~= nil then
                    container.ignorefull = true
                end

                if not container:GiveItem(item, targetslot) then
                    self:GiveItem(item, slot, nil, true)
                end

                --Hacks for altering normal inventory:GiveItem() behaviour
                if container.ignoreoverflow then
                    container.ignoreoverflow = false
                end
                if container.ignorefull then
                    container.ignorefull = false
                end
            end
        end
    end
end

function Container:MoveItemFromHalfOfSlot(slot, container)
    local item = self:GetItemInSlot(slot)
    if item ~= nil and container ~= nil then
        container = container.components.container or container.components.inventory
        if container ~= nil and
            container:IsOpenedBy(self.opener) and
            item.components.stackable ~= nil and
            item.components.stackable:IsStack() then

            local targetslot =
                self.opener.components.constructionbuilderuidata ~= nil and
                self.opener.components.constructionbuilderuidata:GetContainer() == container.inst and
                self.opener.components.constructionbuilderuidata:GetSlotForIngredient(item.prefab) or
                nil

            if container:CanTakeItemInSlot(item, targetslot) then
                local halfstack = item.components.stackable:Get(math.floor(item.components.stackable:StackSize() / 2))
                halfstack.prevcontainer = nil
                halfstack.prevslot = nil

                --Hacks for altering normal inventory:GiveItem() behaviour
                if container.ignoreoverflow ~= nil and container:GetOverflowContainer() == self then
                    container.ignoreoverflow = true
                end
                if container.ignorefull ~= nil then
                    container.ignorefull = true
                end

                if not container:GiveItem(halfstack, targetslot) then
                    self.ignoresound = true
                    self:GiveItem(halfstack, slot, nil, true)
                    self.ignoresound = false
                end

                --Hacks for altering normal inventory:GiveItem() behaviour
                if container.ignoreoverflow then
                    container.ignoreoverflow = false
                end
                if container.ignorefull then
                    container.ignorefull = false
                end
            end
        end
    end
end

function Container:ReferenceAllItems()
    local items = {}
    for i=1,self.numslots do
        if self.slots[i] ~= nil then
            table.insert(items, self.slots[i])
        end
    end
    return items
end

return Container
