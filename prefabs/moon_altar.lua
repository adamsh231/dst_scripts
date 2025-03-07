require "prefabutil"

local shared_assets =
{
    Asset("ANIM", "anim/moon_fissure.zip"),
}

local shared_prefabs =
{
	"moon_fissure",
	"collapse_small",
}

local moon_altar_prefabs =
{
    "moon_altar_idol",
    "moon_altar_glass",
    "moon_altar_seed",
}
local moon_altar_crown_prefabs =
{
    "moon_altar_crown",
}

local sounds =
{
    moon_altar =
    {
        place =
        {
            "hookline_2/common/moon_alter/idol/place1",
            "hookline_2/common/moon_alter/idol/place2",
            "hookline_2/common/moon_alter/idol/place3",
        },
        prototyper_on = "hookline_2/common/moon_alter/idol/prox_pre",
        prototyper_off = "hookline_2/common/moon_alter/idol/prox_pst",
        prototyper_loop = "hookline_2/common/moon_alter/idol/LP",
        hit = "dontstarve/wilson/chest_close",
    },
    moon_altar_cosmic =
    {
        place = "hookline_2/common/moon_alter/cosmic_crown/place",
        prototyper_on = "hookline_2/common/moon_alter/cosmic_crown/prox_pre",
        prototyper_off = "hookline_2/common/moon_alter/cosmic_crown/prox_pst",
        prototyper_loop = "hookline_2/common/moon_alter/cosmic_crown/LP",
        hit = "dontstarve/wilson/chest_close",
    },
}

local LIGHT_RADIUS = 0.9
local LIGHT_INTENSITY = .6
local LIGHT_FALLOFF = .65

local function OnUpdateFlicker(inst, starttime)
    local time = (GetTime() - starttime) * 15
    local flicker = math.sin(time * 0.7 + math.sin(time * 6.28)) -- range = [-1 , 1]
    flicker = (1 + flicker) * .5 -- range = 0:1
    inst.Light:SetIntensity(LIGHT_INTENSITY + .05 * flicker)
end

local function GetStageAnim(inst, anim)
    return anim..(inst._stage ~= nil and inst._stage or "")
end

local function StartPrototyperSound(inst)
    inst.SoundEmitter:PlaySound(inst._sounds.prototyper_on)
    inst.SoundEmitter:PlaySound(inst._sounds.prototyper_loop, "prototyper_loop")

    if inst._activetask ~= nil then
        inst._activetask:Cancel()
    end
    inst._activetask = nil
end

local function onturnon(inst)
    if inst._stage == nil or inst._stage == 3 then
        if inst.AnimState:IsCurrentAnimation("proximity_pre") or
            inst.AnimState:IsCurrentAnimation("proximity_loop") or
            inst.AnimState:IsCurrentAnimation(GetStageAnim(inst, "place")) then
            
            --NOTE: push again even if already playing, in case an idle was also pushed
            inst.AnimState:PushAnimation("proximity_pre")

            if inst._activetask ~= nil then
                inst._activetask:Cancel()
            end
            inst._activetask = inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() - inst.AnimState:GetCurrentAnimationTime(), StartPrototyperSound)
        else
            inst.AnimState:PlayAnimation("proximity_pre")

            StartPrototyperSound(inst)
        end

        inst.AnimState:PushAnimation("proximity_loop", true)
    end
end

local function onturnoff(inst)
    if inst._stage == nil or inst._stage == 3 then
        inst.AnimState:PlayAnimation("proximity_pst")
        inst.AnimState:PushAnimation(GetStageAnim(inst, "idle"), false)
    end

    inst.SoundEmitter:KillSound("prototyper_loop")
    inst.SoundEmitter:PlaySound(inst._sounds.prototyper_off)
end

local function set_stage(inst, stage)
    if stage == 3 then
	    if inst._stage == 2 then
            inst.AnimState:PlayAnimation("place3")
            inst.AnimState:PushAnimation("idle3", false)
        else
            inst.AnimState:PlayAnimation("idle3")
        end

		inst:AddComponent("prototyper")
		inst.components.prototyper.onturnon = onturnon
		inst.components.prototyper.onturnoff = onturnoff
        inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.MOON_ALTAR_FULL

        inst.components.lootdropper:SetLoot({ "moon_altar_idol", "moon_altar_glass", "moon_altar_seed" })

        inst:RemoveComponent("repairable")

    elseif stage == 2 then
        if inst._stage == 1 then
            inst.AnimState:PlayAnimation("place2")
            inst.AnimState:PushAnimation("idle2", false)
        else
            inst.AnimState:PlayAnimation("idle2")
        end

        inst.components.lootdropper:SetLoot({ "moon_altar_glass", "moon_altar_seed" })
	end

    inst._stage = stage or 1

    if type(inst._sounds.place) == "table" then
        inst.SoundEmitter:PlaySound(inst._sounds.place[inst._stage ~= nil and inst._stage or 1])
    else
        inst.SoundEmitter:PlaySound(inst._sounds.place)
    end
end

local function on_piece_slotted(inst, slotter, slotted_item)
	set_stage(inst, inst._stage + 1)
end

local function check_piece(inst, piece)
    if (inst._stage == 1 and piece.prefab == "moon_altar_seed") or
            (inst._stage == 2 and piece.prefab == "moon_altar_idol") then
        return true
    else
        return false, "WRONGPIECE"
    end
end

local function AddRepairable(inst)
    if inst.components.repairable == nil then
        inst:AddComponent("repairable")
        inst.components.repairable.repairmaterial = MATERIALS.MOON_ALTAR
        inst.components.repairable.onrepaired = on_piece_slotted
        inst.components.repairable.checkmaterialfn = check_piece
        inst.components.repairable.noannounce = true
    end
end

local function spawn_loot_apart(inst, offset_multiplier)
    local drop_x, drop_y, drop_z = inst.Transform:GetWorldPosition()

    local loot_prefabs = inst.components.lootdropper:GenerateLoot()
    for _, loot_prefab in pairs(loot_prefabs) do
        local spawn_location = Vector3(drop_x + math.random(-1.5, 1.5), drop_y, drop_z + math.random(-1.5, 1.5))
        inst.components.lootdropper:SpawnLootPrefab(loot_prefab, spawn_location)
    end
end

local function onhammered(inst, worker)
	local x, y, z = inst.Transform:GetWorldPosition()

    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(x, y, z)

	local altar = SpawnPrefab("moon_fissure")
	altar.Transform:SetPosition(x, y, z)

    spawn_loot_apart(inst)

	inst:Remove()
end

local function onhit(inst, hitter, work_left, work_done)
    -- If we have no work left, we're going to revert to crack_idle anyway, so don't play any anims.
    if work_left > 0 then
        if inst.components.prototyper ~= nil and inst.components.prototyper.on then
            inst.AnimState:PlayAnimation("hit_proximity")
            inst.AnimState:PushAnimation("proximity_loop", true)
        else
            inst.AnimState:PlayAnimation(GetStageAnim(inst, "hit_inactive"))
            inst.AnimState:PushAnimation(GetStageAnim(inst, "idle"), false)
        end

        if inst._activetask ~= nil then
            inst._activetask:Cancel()
            inst._activetask = nil
        end

        -- inst.SoundEmitter:PlaySound(inst._sounds.hit)
    end
end

local function display_name_fn(inst)
    return (inst:HasTag("prototyper") and STRINGS.NAMES.MOON_ALTAR.MOON_ALTAR) or
            STRINGS.NAMES.MOON_ALTAR.MOON_ALTAR_WIP
end

local function moon_altar_getstatus(inst)
    return inst._stage < 3 and "MOON_ALTAR_WIP" or nil
end

local function OnFissureSocket(inst)
    inst.AnimState:PlayAnimation(GetStageAnim(inst, "place"))
    inst.AnimState:PushAnimation(GetStageAnim(inst, "idle"))

    if type(inst._sounds.place) == "table" then
        inst.SoundEmitter:PlaySound(inst._sounds.place[1])
    else
        inst.SoundEmitter:PlaySound(inst._sounds.place)
    end
end

local function OnEntitySleep(inst)
    if inst._flickertask ~= nil then
        inst._flickertask:Cancel()
		inst._flickertask = nil
    end
end

local function OnEntityWake(inst)
    if inst._flickertask == nil then
	    inst._flickertask = inst:DoPeriodicTask(.1, OnUpdateFlicker, 0, GetTime())
	end
end

local function moon_altar_on_save(inst, data)
    data.stage = inst._stage
end

local function moon_altar_on_load(inst, data)
    if data ~= nil and data.stage ~= nil then
        set_stage(inst, data.stage)
    end
end

local function moon_altar_common_postinit(inst)
    inst.displaynamefn = display_name_fn
end

local function moon_altar_master_postinit(inst)
    inst._stage = 1

    inst.components.lootdropper:SetLoot({ "moon_altar_glass" })

    inst.components.inspectable.getstatus = moon_altar_getstatus

    inst.components.workable.workleft = TUNING.MOON_ALTAR_COMPLETE_WORK / 3

    AddRepairable(inst)

    inst.OnSave = moon_altar_on_save
    inst.OnLoad = moon_altar_on_load
end

local function moon_altar_cosmic_master_postinit(inst)
    inst.components.lootdropper:SetLoot({ "moon_altar_crown" })

	inst:AddComponent("prototyper")
	inst.components.prototyper.onturnon = onturnon
	inst.components.prototyper.onturnoff = onturnoff
    inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.MOON_ALTAR_FULL
end

local function MakeAltar(name, bank, build, anim, common_postinit, master_postinit, prefabs)
    local assets =
    {
        Asset("ANIM", "anim/"..build..".zip"),
	}
    assets = JoinArrays(shared_assets, assets)
    prefabs = prefabs ~= nil and JoinArrays(shared_prefabs, prefabs) or shared_prefabs

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddLight()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeObstaclePhysics(inst, .4)

        inst.MiniMapEntity:SetPriority(5)
        inst.MiniMapEntity:SetIcon(name..".png")

        inst.Light:SetFalloff(LIGHT_FALLOFF)
        inst.Light:SetIntensity(LIGHT_INTENSITY)
        inst.Light:SetRadius(LIGHT_RADIUS)
        inst.Light:SetColour(0.3, 0.45, 0.55)
        inst.Light:EnableClientModulation(true)
        inst._flickertask = inst:DoPeriodicTask(.1, OnUpdateFlicker, 0, GetTime())

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation(anim)

        inst:AddTag("structure")

        if common_postinit ~= nil then
            common_postinit(inst)
        end

        MakeSnowCoveredPristine(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst._sounds = sounds[name]
        -- inst._activetask = nil

        inst:AddComponent("inspectable")

        inst:AddComponent("lootdropper")

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetMaxWork(TUNING.MOON_ALTAR_COMPLETE_WORK)
	    inst.components.workable.workleft = TUNING.MOON_ALTAR_COMPLETE_WORK
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)
        inst.components.workable.savestate = true

        MakeSnowCovered(inst)

        inst:AddComponent("hauntable")
        inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

        inst.OnEntitySleep = OnEntitySleep
        inst.OnEntityWake = OnEntityWake

        inst:ListenForEvent("on_fissure_socket", OnFissureSocket)

        if master_postinit ~= nil then
            master_postinit(inst)
        end

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return MakeAltar("moon_altar", "moon_altar", "moon_altar", "idle1", moon_altar_common_postinit, moon_altar_master_postinit, moon_altar_prefabs),
    MakeAltar("moon_altar_cosmic", "moon_altar_crown", "moon_altar_crown", "idle", nil, moon_altar_cosmic_master_postinit, moon_altar_crown_prefabs)