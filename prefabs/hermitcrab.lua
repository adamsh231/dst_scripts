local assets =
{
    Asset("ANIM", "anim/player_basic.zip"),
    Asset("ANIM", "anim/player_idles_shiver.zip"),
    Asset("ANIM", "anim/player_idles_lunacy.zip"),
    Asset("ANIM", "anim/player_actions.zip"),
    Asset("ANIM", "anim/player_actions_axe.zip"),
    Asset("ANIM", "anim/player_actions_pickaxe.zip"),
    Asset("ANIM", "anim/player_actions_shovel.zip"),
    Asset("ANIM", "anim/player_actions_blowdart.zip"),
    Asset("ANIM", "anim/player_actions_eat.zip"),
    Asset("ANIM", "anim/player_actions_item.zip"),
    Asset("ANIM", "anim/player_cave_enter.zip"),
    Asset("ANIM", "anim/player_actions_uniqueitem.zip"),
    Asset("ANIM", "anim/player_actions_bugnet.zip"),
    Asset("ANIM", "anim/player_actions_unsaddle.zip"),
    Asset("ANIM", "anim/player_actions_fishing.zip"),
    Asset("ANIM", "anim/player_actions_fishing_ocean.zip"),
    Asset("ANIM", "anim/player_actions_fishing_ocean_new.zip"),
    Asset("ANIM", "anim/player_actions_pocket_scale.zip"),
    Asset("ANIM", "anim/player_actions_boomerang.zip"),
    Asset("ANIM", "anim/player_actions_whip.zip"),
    Asset("ANIM", "anim/player_actions_till.zip"),
    Asset("ANIM", "anim/player_boat.zip"),
    Asset("ANIM", "anim/player_boat_plank.zip"),
    Asset("ANIM", "anim/player_oar.zip"),
    Asset("ANIM", "anim/player_boat_hook.zip"),
    Asset("ANIM", "anim/player_boat_net.zip"),
    Asset("ANIM", "anim/player_boat_sink.zip"),
    Asset("ANIM", "anim/player_boat_jump.zip"),
    Asset("ANIM", "anim/player_boat_channel.zip"),
    Asset("ANIM", "anim/player_bush_hat.zip"),
    Asset("ANIM", "anim/player_attacks.zip"),

    Asset("ANIM", "anim/player_rebirth.zip"),
    Asset("ANIM", "anim/player_jump.zip"),
    Asset("ANIM", "anim/player_amulet_resurrect.zip"),
    Asset("ANIM", "anim/player_teleport.zip"),
    Asset("ANIM", "anim/wilson_fx.zip"),
    Asset("ANIM", "anim/player_one_man_band.zip"),
    Asset("ANIM", "anim/player_slurtle_armor.zip"),
    Asset("ANIM", "anim/player_staff.zip"),
    Asset("ANIM", "anim/player_cointoss.zip"),
    Asset("ANIM", "anim/player_hit_darkness.zip"),
    Asset("ANIM", "anim/player_hit_spike.zip"),
    Asset("ANIM", "anim/player_lunge.zip"),
    Asset("ANIM", "anim/player_multithrust.zip"),
    Asset("ANIM", "anim/player_superjump.zip"),
    Asset("ANIM", "anim/player_attack_leap.zip"),
    Asset("ANIM", "anim/player_book_attack.zip"),
    Asset("ANIM", "anim/player_parryblock.zip"),
    Asset("ANIM", "anim/player_attack_prop.zip"),
    Asset("ANIM", "anim/player_peruse.zip"),
    Asset("ANIM", "anim/player_strum.zip"),

    Asset("ANIM", "anim/player_frozen.zip"),
    Asset("ANIM", "anim/player_shock.zip"),
    Asset("ANIM", "anim/player_tornado.zip"),

    Asset("ANIM", "anim/player_wrap_bundle.zip"),
    Asset("ANIM", "anim/player_wardrobe.zip"),
    Asset("ANIM", "anim/player_skin_change.zip"),
    Asset("ANIM", "anim/player_receive_gift.zip"),
    Asset("ANIM", "anim/shadow_skinchangefx.zip"),
    Asset("ANIM", "anim/player_townportal.zip"),
    Asset("ANIM", "anim/player_channel.zip"),
    Asset("ANIM", "anim/player_construct.zip"),

    Asset("SOUND", "sound/sfx.fsb"),
    Asset("SOUND", "sound/wilson.fsb"),

    Asset("ANIM", "anim/player_revive_ghosthat.zip"),
    Asset("ANIM", "anim/player_revive_to_character.zip"),
    Asset("ANIM", "anim/player_revive_from_corpse.zip"),
    Asset("ANIM", "anim/player_knockedout.zip"),
    Asset("ANIM", "anim/player_emotesxl.zip"),
    Asset("ANIM", "anim/player_emotes_dance0.zip"),
    Asset("ANIM", "anim/player_emotes_sit.zip"),
    Asset("ANIM", "anim/player_emotes.zip"), -- item emotes
    Asset("ANIM", "anim/player_emote_extra.zip"), -- item emotes
    Asset("ANIM", "anim/player_emotes_dance2.zip"), -- item emotes
    Asset("ANIM", "anim/player_mount_emotes_extra.zip"), -- item emotes
    Asset("ANIM", "anim/player_mount_emotes_dance2.zip"), -- item emotes
    Asset("ANIM", "anim/player_hatdance.zip"),
    Asset("ANIM", "anim/player_bow.zip"),
    Asset("ANIM", "anim/tears.zip"),
    Asset("ANIM", "anim/puff_spawning.zip"),
    Asset("ANIM", "anim/attune_fx.zip"),

    Asset("ANIM", "anim/player_idles_groggy.zip"),
    Asset("ANIM", "anim/player_groggy.zip"),

    Asset("ANIM", "anim/player_encumbered.zip"),
    Asset("ANIM", "anim/player_encumbered_jump.zip"),

    Asset("ANIM", "anim/player_sandstorm.zip"),
    Asset("ANIM", "anim/player_tiptoe.zip"),

    Asset("ANIM", "anim/player_hermitcrab_idle.zip"),
    Asset("ANIM", "anim/player_hermitcrab_walk.zip"),
    Asset("ANIM", "anim/player_hermitcrab_look.zip"),
    

    Asset("ANIM", "anim/hermitcrab_build.zip"),
}

local prefabs =
{
    "hermitcrab_marker",
    "hermit_bundle",
    "beebox_hermit",
    "meatrack_hermit",
    "hermit_pearl",
    "hermit_bundle_shells",
    "moon_fissure_plugged",
}

local SHOP_LEVELS =
{
    "HERMITCRABSHOP_L1",
    "HERMITCRABSHOP_L2",
    "HERMITCRABSHOP_L3",
    "HERMITCRABSHOP_L4",
    "HERMITCRABSHOP_L4",
}

local TASKS = {
    FIX_HOUSE_1 = 1,
    FIX_HOUSE_2 = 2,
    FIX_HOUSE_3 = 3,
    PLANT_FLOWERS = 4,
    REMOVE_JUNK = 5,
    PLANT_BERRIES = 6,
    FILL_MEATRACKS = 7,
    GIVE_HEAVY_FISH = 8,
    REMOVE_LUREPLANT = 9,
    GIVE_UMBRELLA = 10,
    GIVE_PUFFY_VEST =11,
    GIVE_FLOWER_SALAD = 12,

    GIVE_BIG_WINTER = 14,
    GIVE_BIG_SUMMER =15,
    GIVE_BIG_SPRING = 16,
    GIVE_BIG_AUTUM = 17,
}

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30

local MEET_PLAYERS_RANGE_SQ = 20*20
local MEET_PLAYERS_FREQUENCY = 1.5

local function displaynamefn(inst)    

    return inst:HasTag("highfriendlevel") and STRINGS.NAMES.HERMITCRAB_NAME or STRINGS.NAMES.HERMITCRAB
end

local function dotalkingtimers(inst)
    inst.components.timer:StartTimer("speak_time",TUNING.HERMITCRAB.SPEAKTIME)

    if inst.components.timer:TimerExists("complain_time") then
        local time = inst.components.timer:GetTimeLeft("complain_time")
        inst.components.timer:SetTimeLeft("complain_time", time + 10)
    else
        inst.components.timer:StartTimer("complain_time",10 + (math.random()*30))
    end  
end

local function settextcolor(inst)
    local gfl = inst.getgeneralfriendlevel(inst) 
    if gfl == "HIGH" then
        inst.components.talker.colour = Vector3(194/255, 149/255, 216/255)
    elseif gfl == "MED" then
        inst.components.talker.colour = Vector3(228/255, 163/255, 212/255)        
    else
        inst.components.talker.colour = Vector3(241/255, 198/255, 211/255)
    end
end

local function ontalk(inst, script)
    if inst.components.friendlevels.level > 0 then
        settextcolor(inst)
    end    
    inst.SoundEmitter:PlaySound("hookline_2/characters/hermit/talk")
end

local function iscoat(item)
    return item.components.insulator and 
           item.components.insulator:GetInsulation() >= TUNING.INSULATION_SMALL and 
           item.components.insulator:GetType() == SEASONS.WINTER and 
           item.components.equippable and 
           item.components.equippable.equipslot == EQUIPSLOTS.BODY                           
end

local function ShouldAcceptItem(inst, item)
    local handequipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    local hasumbrella = inst.components.inventory:FindItem(function(testitem) return testitem:HasTag("umbrella") end) or (handequipped and handequipped:HasTag("umbrella") and handequipped )

    local bodyequipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    local hascoat = inst.components.inventory:FindItem(function(testitem) return iscoat(testitem) end) or (bodyequipped and iscoat(bodyequipped) and bodyequipped )

    if item:HasTag("oceanfish") or
       ( item:HasTag("umbrella") and TheWorld.state.israining and not hasumbrella ) or
       ( iscoat(item) and TheWorld.state.issnowing and not hascoat ) or    
       ( item.prefab == "flowersalad" and not inst.components.timer:TimerExists("salad")) or
       item.prefab == "hermit_cracked_pearl"
        then
        return true
    end
end

local function OnGetItemFromPlayer(inst, giver, item)
    --inst.components.inventory:GiveItem(item)
end

local function OnRefuseItem(inst, giver, item)
    if item.prefab == "flowersalad" and inst.components.timer:TimerExists("salad") then
        inst.components.npc_talker:Say(STRINGS.HERMITCRAB_REFUSE_SALAD[math.random(#STRINGS.HERMITCRAB_REFUSE_SALAD)])
    end

    if iscoat(item) then
        local bodyequipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
        local coat = inst.components.inventory:FindItem(function(testitem) return iscoat(testitem) end) or (bodyequipped and  iscoat(bodyequipped) and bodyequipped )

        if coat then
            inst.components.npc_talker:Say(STRINGS.HERMITCRAB_REFUSE_COAT_HASONE[math.random(#STRINGS.HERMITCRAB_REFUSE_COAT_HASONE)])            
        elseif not TheWorld.state.issnowing then            
            inst.components.npc_talker:Say(STRINGS.HERMITCRAB_REFUSE_COAT[math.random(#STRINGS.HERMITCRAB_REFUSE_COAT)])            
        end
    end

    if item:HasTag("umbrella") then
        local handequipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        local umbrella = inst.components.inventory:FindItem(function(testitem) return testitem:HasTag("umbrella") end) or (handequipped and  handequipped:HasTag("umbrella") and handequipped )

        if umbrella then
            inst.components.npc_talker:Say(STRINGS.HERMITCRAB_REFUSE_UMBRELLA_HASONE[math.random(#STRINGS.HERMITCRAB_REFUSE_UMBRELLA_HASONE)])            
        elseif not TheWorld.state.israining then
            inst.components.npc_talker:Say(STRINGS.HERMITCRAB_REFUSE_UMBRELLA[math.random(#STRINGS.HERMITCRAB_REFUSE_UMBRELLA)])            
        end
    end      
    if item.components.insulator and item.components.insulator:GetInsulation() >= TUNING.INSULATION_LARGE and item.components.insulator:GetType() == SEASONS.WINTER and item.components.equippable.equipslot == EQUIPSLOTS.BODY and not TheWorld.state.issnowing then
        inst.components.npc_talker:Say(STRINGS.HERMITCRAB_REFUSE_VEST[math.random(#STRINGS.HERMITCRAB_REFUSE_VEST)])
    end                
    inst.sg:GoToState("refuse")
end

local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "playerghost", "INLIMBO" }
local function NormalRetargetFn(inst)
    return not inst:IsInLimbo()
        and FindEntity(
                inst,
                TUNING.PIG_TARGET_DIST,
                function(guy)
                    return (guy.LightWatcher == nil or guy.LightWatcher:IsInLight())
                        and inst.components.combat:CanTarget(guy)
                end,
                RETARGET_MUST_TAGS, -- see entityreplica.lua
                RETARGET_CANT_TAGS                
            )
        or nil
end

local function NormalKeepTargetFn(inst, target)
    --give up on dead guys, or guys in the dark, or werepigs
    return inst.components.combat:CanTarget(target)
        and (target.LightWatcher == nil or target.LightWatcher:IsInLight())
end

local FIRE_TAGS = { "campfire", "fire" }
local function NormalShouldSleep(inst)
    return DefaultSleepTest(inst)
        and (inst.components.follower == nil or inst.components.follower.leader == nil
            or (FindEntity(inst, 6, nil, FIRE_TAGS) ~= nil and
                (inst.LightWatcher == nil or inst.LightWatcher:IsInLight())))
end

local normalbrain = require "brains/hermitcrabbrain"

local function OnActivatePrototyper(inst, doer, recipe)
    local gfl = inst.getgeneralfriendlevel(inst)
    inst.components.npc_talker:Say(STRINGS.HERMITCRAB_TALK_ONPURCHASE[gfl][math.random(#STRINGS.HERMITCRAB_TALK_ONPURCHASE[gfl])])
end

local function EnableShop(inst, shop_level)
    if inst.components.prototyper == nil then
        inst:AddComponent("prototyper")
        inst.components.prototyper.onactivate = OnActivatePrototyper
    end

    inst._shop_level = shop_level or inst._shop_level or 1
    inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES[SHOP_LEVELS[inst._shop_level]]
end

local function DisableShop(inst)
    if inst.components.prototyper ~= nil then
        inst:RemoveComponent("prototyper")
    end
end

local function GetStatus(inst)
    return nil
end

local function OnSave(inst, data)
    data.shop_level = inst._shop_level
    data.heavyfish = inst.heavyfish
    data.introduced = inst.introduced
    data.pearlgiven = inst.pearlgiven
    if inst.storelevelunlocktask then
        data.storelevelunlocked = true
    end
    data.highfriendlevel = inst:HasTag("highfriendlevel")
end

local function OnLoad(inst, data)
    if data ~= nil then
        if data.shop_level ~= nil and data.shop_level > 0 then
            inst._shop_level = data.shop_level
            EnableShop(inst, inst._shop_level)
        end
        if data.heavyfish then
            inst.heavyfish = data.heavyfish
        end
        if data.storelevelunlocked then
            inst.storelevelunlocked(inst)
        end
        if data.introduced then
            inst.introduced = data.introduced
        end
        if data.pearlgiven then
            inst.pearlgiven = data.pearlgiven
        end
        if data.highfriendlevel then
            inst:AddTag("highfriendlevel")
        end
    end
end

local function OnLoadPostPass(inst, new_ents, data)
	if inst._shop_level ~= nil and inst._shop_level >= 5 then
		-- This is only done for retrofitting, it is not normally needed, do not copy/paste this
		inst.components.craftingstation:LearnItem("supertacklecontainer", "hermitshop_supertacklecontainer")
	end
end

local function RegisterToBottleManager(inst)
    if TheWorld.components.messagebottlemanager ~= nil then
        TheWorld.components.messagebottlemanager.hermitcrab = inst
    end
end

local function getgeneralfriendlevel(inst)
    local gfl = "LOW"
    if inst.components.friendlevels.level > 3 and inst.components.friendlevels.level < 8 then
        gfl = "MED"
    elseif inst.components.friendlevels.level > 7 then
        gfl = "HIGH"
    end
    return gfl
end

-- FRIENDLEVELS content
local function complain(inst)    
    local problems = inst.components.friendlevels.friendlytasks
    local list = {}
    for i, problem in ipairs(problems) do
        if problem.complain and not problem.complete and ( not problem.complaintest or problem.complaintest(inst) ) then
            table.insert(list,problem.complianstrings)
        end
    end

    local random = nil
    if #list > 1 then
        random = math.random(1,#list)
    elseif #list == 1 then
        random = 1
    end

    if random then
        local gfl = getgeneralfriendlevel(inst)
        inst.components.npc_talker:Say(list[random][gfl][math.random(#list[random][gfl])])

        if inst.components.timer:TimerExists("speak_time") then
            inst.components.timer:StopTimer("speak_time")        
        end
        inst.components.timer:StartTimer("speak_time",TUNING.HERMITCRAB.SPEAKTIME)
    end

    inst.components.timer:StartTimer("complain_time",10 + (math.random()*30))
end

local function rewardcheck(inst)
    if #inst.components.friendlevels.queuedrewards > 0 then

        local task = 0
        local queue = deepcopy(inst.components.friendlevels.queuedrewards)
        local task = nil
        local default = nil
        local group = nil
        for i,reward in ipairs(inst.components.friendlevels.queuedrewards)do
            if reward.task ~= "default" then
                if task == nil then
                    task = reward.task
                else
                    group = true
                    break
                end
            else
                default = true
            end
        end
        local str = nil
        local gfl = inst.getgeneralfriendlevel(inst)
        if gfl == "HIGH" and not inst.introduced then
            inst.introduced = true
            str = STRINGS.HERMITCRAB_INTRODUCE[math.random(1,#STRINGS.HERMITCRAB_INTRODUCE)]
        elseif group then
            str = STRINGS.HERMITCRAB_GROUP_REWARD[gfl][math.random(1,#STRINGS.HERMITCRAB_GROUP_REWARD[gfl])]
        elseif task then
            local problems = inst.components.friendlevels.friendlytasks

            str = problems[task].completestrings[gfl][math.random(1,#problems[task].completestrings[gfl])]
        else
            str = STRINGS.HERMITCRAB_DEFAULT_REWARD[gfl][math.random(1,#STRINGS.HERMITCRAB_DEFAULT_REWARD[gfl])]
        end                
        local gifts = inst.components.friendlevels:DoRewards()

        if #gifts > 0 then
            inst.itemstotoss = gifts
            for i,gift in ipairs(gifts)do
                inst.components.inventory:GiveItem(gift)
            end
        end

        --[[
        for i,gift in ipairs(gifts)do
            if target and target.components.inventory then
                target.components.inventory:GiveItem(gift)
            else
                self.inst.components.lootdropper:FlingItem(gift)
            end
        end
        ]]

        inst.comment_data = nil  -- overrides the hermit making a comment on a task that's been partially done to reward the player for one that is done
        return str
    end    
end

local STOP_RUN_DIST = 8

local function onTaskComplete(inst, defaulttask)
    if not inst.giverewardstask then

        inst.giverewardstask = inst:DoPeriodicTask(0.5, function() 
            if not inst.sg:HasStateTag("ishome") then      
                local player = FindClosestPlayerToInst(inst, STOP_RUN_DIST, true)
                if player then -- not inst.components.timer:TimerExists("speak_time") and
                    local str = rewardcheck(inst)
                    if str then
                        inst.components.timer:StartTimer("speak_time",TUNING.HERMITCRAB.SPEAKTIME)

                        if inst.components.timer:TimerExists("complain_time") then
                            local time = inst.components.timer:GetTimeLeft("complain_time")
                            inst.components.timer:SetTimeLeft("complain_time", time + 10)
                        else
                            inst.components.timer:StartTimer("complain_time",10 + (math.random()*30))
                        end
                        local sound = nil
                        if not defaulttask then
                         --   inst.SoundEmitter:PlaySound("hookline_2/characters/hermit/friendship_music/"..inst.components.friendlevels.level)
                            sound = "hookline_2/characters/hermit/friendship_music/"..inst.components.friendlevels.level
                        end
                        inst.components.npc_talker:Say(str,nil,nil,sound)
                    end
                    if inst.giverewardstask then
                        inst.giverewardstask:Cancel()
                        inst.giverewardstask = nil
                    end
                end
            end
        end)
    end

    if inst.getgeneralfriendlevel(inst) == "HIGH" and not inst:HasTag("highfriendlevel")  then
        inst:AddTag("highfriendlevel")
        if inst.components.homeseeker and inst.components.homeseeker.home then
            inst.components.homeseeker.home:AddTag("highfriendlevel")
        end
    end
end


local function storelevelunlocked(inst)
    if not inst.storelevelunlocktask then
        inst.storelevelunlocktask = inst:DoPeriodicTask(0.5, function() 
            if not inst.sg:HasStateTag("ishome") and not inst.giverewardstask and not inst.components.timer:TimerExists("speak_time") then      
                local player = FindClosestPlayerToInst(inst, STOP_RUN_DIST, true)
                if player then
                    
                    local str = STRINGS["HERMITCRAB_STORE_UNLOCK_"..inst._shop_level][ math.random(1,#STRINGS["HERMITCRAB_STORE_UNLOCK_"..inst._shop_level]) ]

                    inst.components.timer:StartTimer("speak_time",TUNING.HERMITCRAB.SPEAKTIME)
                    if inst.components.timer:TimerExists("complain_time") then
                        local time = inst.components.timer:GetTimeLeft("complain_time")
                        inst.components.timer:SetTimeLeft("complain_time", time + 10)
                    else
                        inst.components.timer:StartTimer("complain_time",10 + (math.random()*30))
                    end                
                    inst.components.npc_talker:Say(str)
   
                    if inst.storelevelunlocktask then
                        inst.storelevelunlocktask:Cancel()
                        inst.storelevelunlocktask = nil
                    end
                end
            end
        end)
    end
end

local function extrarewardcheck(inst, gifts)
    if inst.extrareward then
        for i,gift in ipairs(inst.extrareward) do
            table.insert(gifts,SpawnPrefab(gift))
        end
        inst.extrareward = nil
    end
    return gifts
end

local function createbundle(inst,gifts)
    local final = {}
    if #gifts >0 then
        local pouch = SpawnPrefab("hermit_bundle")
        local prize_items = {}
        for _, p in ipairs(gifts) do
            table.insert(prize_items, SpawnPrefab(p))
        end
        pouch.components.unwrappable:WrapItems(prize_items) 
		for i, v in ipairs(prize_items) do
			v:Remove()
		end
        table.insert(final,pouch)
    end
    final = extrarewardcheck(inst, final)


    if inst.components.friendlevels.level >= 10 and not inst.pearlgiven and inst.components.friendlevels.friendlytasks[TASKS.FIX_HOUSE_3].complete then
        if inst.components.friendlevels.friendlytasks[TASKS.FIX_HOUSE_3].complete then
            inst.pearlgiven = true
            table.insert(final,SpawnPrefab("hermit_pearl"))
            inst:DoTaskInTime(0,function()
                inst.components.npc_talker:Say(STRINGS.HERMITCRAB_GIVE_PEARL)
            end)
        else
            inst:DoTaskInTime(0,function()
                inst.components.npc_talker:Say(STRINGS.HERMITCRAB_WANT_HOUSE)
            end)
        end
    end

    return final
end

local hermit_bundle_shell_loots =
{
    singingshell_octave5 = 2,
    singingshell_octave4 = 2,
    singingshell_octave3 = 1,
}

local seasonal_lure =
{
    oceanfishinglure_hermit_rain = 1,
    oceanfishinglure_hermit_snow = 1,
    oceanfishinglure_hermit_drowsy = 1,
    oceanfishinglure_hermit_heavy = 1,
}

local function honeycheck(inst,gifts)
    if inst.components.friendlevels.friendlytasks[TASKS.PLANT_FLOWERS].complete then
        table.insert(gifts,"honey")        
    end
    return gifts
end

local function defaultfriendrewards(inst,winner)
    local gifts = {}
    for i=1,3 do
        table.insert(gifts, weighted_random_choice(hermit_bundle_shell_loots))
    end
    gifts = honeycheck(inst,gifts)
    return createbundle(inst,gifts)
end

local function friendlevel_1_reward(inst,winner)
    EnableShop(inst, 1)
    storelevelunlocked(inst)
    return createbundle(inst,{})
end

local function friendlevel_2_reward(inst,winner)
    local gifts = {}

    table.insert(gifts, weighted_random_choice(seasonal_lure))

    gifts = honeycheck(inst,gifts)
    return createbundle(inst,gifts)
end

local function friendlevel_3_reward(inst,winner)
    EnableShop(inst, 2)
    storelevelunlocked(inst)
    return createbundle(inst,{})
end

local function friendlevel_4_reward(inst,winner)
    local gifts = {}
    for i=1,3 do
        table.insert(gifts, weighted_random_choice(hermit_bundle_shell_loots))
    end   
    table.insert(gifts, weighted_random_choice(seasonal_lure))

    gifts = honeycheck(inst,gifts)

    return createbundle(inst,gifts)
end

local function friendlevel_5_reward(inst,winner)
    local gifts = {}
    for i=1,3 do
        table.insert(gifts, weighted_random_choice(hermit_bundle_shell_loots))
    end   
    table.insert(gifts, weighted_random_choice(seasonal_lure))

    gifts = honeycheck(inst,gifts)
    return createbundle(inst,gifts)
end

local function friendlevel_6_reward(inst,winner)
    EnableShop(inst,3)
    storelevelunlocked(inst)
    return createbundle(inst,{})
end

local function friendlevel_7_reward(inst,winner)
    local gifts = {}
    for i=1,3 do
        table.insert(gifts, weighted_random_choice(hermit_bundle_shell_loots))
    end   
    table.insert(gifts, weighted_random_choice(seasonal_lure))

    gifts = honeycheck(inst,gifts)
    return createbundle(inst,gifts)
end

local function friendlevel_8_reward(inst,winner)
    EnableShop(inst,4)
    storelevelunlocked(inst)
    return createbundle(inst,{})
end

local function friendlevel_9_reward(inst,winner)
	inst.components.craftingstation:LearnItem("supertacklecontainer", "hermitshop_supertacklecontainer")
    inst._shop_level = 5
    storelevelunlocked(inst)
    return createbundle(inst,{})
end

local function friendlevel_10_reward(inst,winner)
    local gifts = {}
    gifts = createbundle(inst,gifts)

    return gifts
end

local ISLAND_RADIUS = 32

local friendlevelrewards = {
    friendlevel_1_reward, --1
    friendlevel_2_reward, --2
    friendlevel_3_reward, --3
    friendlevel_4_reward, --4
    friendlevel_5_reward, --5
    friendlevel_6_reward, --6
    friendlevel_7_reward, --7
    friendlevel_8_reward, --8
    friendlevel_9_reward, --9
    friendlevel_10_reward, --10
}


local FIND_LUREPLANT_TAGS = {"lureplant"}
local FIND_FLOWER_TAGS = {"flower"}
local FIND_PLANT_TAGS = {"bush","plant"}
local FIND_STRUCTURE_TAGS = {"structure"}
local FIND_HEAVY_TAGS = {"heavy"}
local FIND_HERMITCRAB_LURE_MARKER_TAGS = {"hermitcrab_lure_marker"}

local function lureplantcomplainfn(inst)
    local source = inst.CHEVO_marker
    if source then
        local pos = Vector3(source.Transform:GetWorldPosition())
        local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, ISLAND_RADIUS, FIND_LUREPLANT_TAGS)
        if #ents > 0 then
            return true
        end
    end
end
local function plantflowerscomplainfn(inst)
    local source = inst.CHEVO_marker
    if source then
        local pos = Vector3(source.Transform:GetWorldPosition())
        local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, ISLAND_RADIUS, FIND_FLOWER_TAGS)
        if #ents < 10 then
            return true
        end           
    end 
end

local function berriescomplainfn(inst)
    local source = inst.CHEVO_marker
    if source then
        local pos = Vector3(source.Transform:GetWorldPosition())
        local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, ISLAND_RADIUS, FIND_PLANT_TAGS)
        for i=#ents,1,-1 do
            if not ents[i].components.pickable or ents[i].components.pickable:IsBarren() then
                table.remove(ents,i)
            end
        end
        if #ents < 8 then
            return true
        end
    end
end

local function meatcomplainfn(inst)
    local source = inst.CHEVO_marker
    if source then
        local pos = Vector3(source.Transform:GetWorldPosition())
        local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, ISLAND_RADIUS, FIND_STRUCTURE_TAGS)
        for i=#ents,1,-1 do
            if not ents[i].components.dryer or not ents[i].components.dryer.product then
                table.remove(ents,i)
            end
        end
        if #ents <= 0 then
            return true
        end
    end
end

local function umbrellacomplainfn(inst)
    if TheWorld.state.israining then
        return true
    end
end
local function puffycomplainfn(inst)
    if TheWorld.state.issnowing then
        return true
    end
end
local function saladcomplainfn(inst)
   if TheWorld.state.issummer then
        return true
    end
end

local function fishautumfn(inst)
   if TheWorld.state.isautumn then
        return true
    end
end

local function fishspringfn(inst)
    if TheWorld.state.isspring then
        return true
    end
end

local function fishsummerfn(inst)
    if TheWorld.state.issummer then
        return true
    end    
end

local function fishwinterfn(inst)
    if TheWorld.state.iswinter then
        return true
    end    
end

local friendlytasks ={
    [TASKS.FIX_HOUSE_1] =       {completestrings=STRINGS.HERMITCRAB_REWARD.FIX_HOUSE_1},
    [TASKS.FIX_HOUSE_2] =       {completestrings=STRINGS.HERMITCRAB_REWARD.FIX_HOUSE_2},
    [TASKS.FIX_HOUSE_3] =       {completestrings=STRINGS.HERMITCRAB_REWARD.FIX_HOUSE_3},
    [TASKS.PLANT_FLOWERS] =     {completestrings=STRINGS.HERMITCRAB_REWARD.PLANT_FLOWERS,     complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.PLANT_FLOWERS,      complaintest=plantflowerscomplainfn,   onetime = true},
    [TASKS.REMOVE_JUNK] =       {completestrings=STRINGS.HERMITCRAB_REWARD.REMOVE_JUNK,       complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.REMOVE_JUNK},
    [TASKS.PLANT_BERRIES] =     {completestrings=STRINGS.HERMITCRAB_REWARD.PLANT_BERRIES,     complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.PLANT_BERRIES,      complaintest=berriescomplainfn,        onetime = true},
    [TASKS.FILL_MEATRACKS] =    {completestrings=STRINGS.HERMITCRAB_REWARD.FILL_MEATRACKS,    complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.FILL_MEATRACKS,     complaintest=meatcomplainfn},
    [TASKS.GIVE_HEAVY_FISH] =   {completestrings=STRINGS.HERMITCRAB_REWARD.GIVE_HEAVY_FISH,   complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.GIVE_HEAVY_FISH},
    [TASKS.REMOVE_LUREPLANT] =  {completestrings=STRINGS.HERMITCRAB_REWARD.REMOVE_LUREPLANT,  complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.REMOVE_LUREPLANT,   complaintest=lureplantcomplainfn},
    [TASKS.GIVE_UMBRELLA] =     {completestrings=STRINGS.HERMITCRAB_REWARD.GIVE_UMBRELLA,     complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.GIVE_UMBRELLA,      complaintest=umbrellacomplainfn},
    [TASKS.GIVE_PUFFY_VEST] =   {completestrings=STRINGS.HERMITCRAB_REWARD.GIVE_PUFFY_VEST,   complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.GIVE_PUFFY_VEST,    complaintest=puffycomplainfn},
    [TASKS.GIVE_FLOWER_SALAD] = {completestrings=STRINGS.HERMITCRAB_REWARD.GIVE_FLOWER_SALAD, complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.GIVE_FLOWER_SALAD,  complaintest=saladcomplainfn},

    [TASKS.GIVE_BIG_WINTER] = {completestrings=STRINGS.HERMITCRAB_REWARD.GIVE_FISH_WINTER,    complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.GIVE_FISH_WINTER,  complaintest=fishwinterfn}, -- oceanfish_medium_8
    [TASKS.GIVE_BIG_SUMMER] = {completestrings=STRINGS.HERMITCRAB_REWARD.GIVE_FISH_SUMMER,    complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.GIVE_FISH_SUMMER,  complaintest=fishsummerfn}, -- oceanfish_small_8
    [TASKS.GIVE_BIG_SPRING] = {completestrings=STRINGS.HERMITCRAB_REWARD.GIVE_FISH_SPRING,    complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.GIVE_FISH_SPRING,  complaintest=fishspringfn}, -- oceanfish_small_7
    [TASKS.GIVE_BIG_AUTUM]  = {completestrings=STRINGS.HERMITCRAB_REWARD.GIVE_FISH_AUTUM,     complain=true, complianstrings=STRINGS.HERMITCRAB_COMPLAIN.GIVE_FISH_AUTUM,   complaintest=fishautumfn},  -- oceanfish_small_6

}

local function initfriendlevellisteners(inst)
    -- FIX_HOUSE_1, FIX_HOUSE_2, FIX_HOUSE_3
    inst:ListenForEvent("home_upgraded", function(inst,data) 
        if data.house.prefab == "hermithouse_construction2" then
            inst.components.friendlevels:CompleteTask(TASKS.FIX_HOUSE_1, data.doer) 
        elseif data.house.prefab == "hermithouse_construction3" then
            inst.components.friendlevels:CompleteTask(TASKS.FIX_HOUSE_2, data.doer) 
        else
            inst.components.friendlevels:CompleteTask(TASKS.FIX_HOUSE_3, data.doer) 
        end
    end)

    --PLANT_FLOWERS
    inst:ListenForEvent("CHEVO_growfrombutterfly", function(world,data) 
        local source = inst.CHEVO_marker
        if source and data.target:GetDistanceSqToInst(source) < ISLAND_RADIUS * ISLAND_RADIUS then
            local pos = Vector3(source.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, ISLAND_RADIUS, FIND_FLOWER_TAGS)

            -- INVESTIGATE
            local gfl = inst.getgeneralfriendlevel(inst)
            if not inst.comment_data then
                inst.comment_data= {
                    pos = Vector3(data.target.Transform:GetWorldPosition()),
                    speech = STRINGS.HERMITCRAB_INVESTIGATE.PLANT_FLOWERS[gfl][math.random(1,#STRINGS.HERMITCRAB_INVESTIGATE.PLANT_FLOWERS[gfl])],
                }
            end

            if #ents >= 10 then
                inst.components.friendlevels:CompleteTask(TASKS.PLANT_FLOWERS, data.doer)
            end            

        end
    end, TheWorld) 

    --FILL_MEATRACKS
    inst:ListenForEvent("CHEVO_starteddrying", function(world,data) 
        local source = inst.CHEVO_marker
        if source and data.target:GetDistanceSqToInst(source) < ISLAND_RADIUS * ISLAND_RADIUS then
            local pos = Vector3(source.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, ISLAND_RADIUS, FIND_STRUCTURE_TAGS)
            for i=#ents,1,-1 do
                if not ents[i].components.dryer or not ents[i].components.dryer.product then
                    table.remove(ents,i)
                end
            end
            
            -- INVESTIGATE
            local gfl = inst.getgeneralfriendlevel(inst)
            if not inst.comment_data then
                inst.comment_data= {
                    pos = Vector3(data.target.Transform:GetWorldPosition()),
                    speech = STRINGS.HERMITCRAB_INVESTIGATE.FILL_MEATRACKS[gfl][math.random(1,#STRINGS.HERMITCRAB_INVESTIGATE.FILL_MEATRACKS[gfl])],
                }
            end

            if #ents >= 6 and not inst.driedthings then
                inst.driedthings = 0
                inst.components.friendlevels:CompleteTask(TASKS.FILL_MEATRACKS, data.doer)         
            end 
        end
    end, TheWorld)     

    --PLANT_BERRIES
    inst:ListenForEvent("CHEVO_fertilized", function(world,data) 
        local source = inst.CHEVO_marker
        if source and data.target:GetDistanceSqToInst(source) < ISLAND_RADIUS * ISLAND_RADIUS then
            local pos = Vector3(source.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, ISLAND_RADIUS, FIND_PLANT_TAGS)
            for i=#ents,1,-1 do
                if not ents[i].components.pickable or ents[i].components.pickable:IsBarren() then
                    table.remove(ents,i)
                end
            end

            -- INVESTIGATE
            local gfl = inst.getgeneralfriendlevel(inst)
            if not inst.comment_data then
                inst.comment_data= {
                    pos = Vector3(data.target.Transform:GetWorldPosition()),
                    speech = STRINGS.HERMITCRAB_INVESTIGATE.PLANT_BERRIES[gfl][math.random(1,#STRINGS.HERMITCRAB_INVESTIGATE.PLANT_BERRIES[gfl])],                
                }
            end

            if #ents >= 8 then
                inst.components.friendlevels:CompleteTask(TASKS.PLANT_BERRIES, data.doer)     
            end                        
        end
    end, TheWorld) 

    --REMOVE_JUNK
    local function checkforclearwaters(inst,data)
        local source = inst.CHEVO_marker
        local range = ISLAND_RADIUS +10
        if source and data.target:GetDistanceSqToInst(source) < range * range then
            local pos = Vector3(source.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, range, FIND_HEAVY_TAGS)
            for i=#ents,1,-1 do
                local testpos = Vector3(ents[i].Transform:GetWorldPosition())
                if TheWorld.Map:IsVisualGroundAtPoint(testpos.x,testpos.y,testpos.z) or TheWorld.Map:GetPlatformAtPoint(testpos.x,testpos.z) then
                    table.remove(ents,i)
                end
            end            
            for i=#ents,1,-1 do
                local pos = Vector3(ents[i].Transform:GetWorldPosition())               
            end
            if #ents <= 0 then                
                inst.components.friendlevels:CompleteTask(TASKS.REMOVE_JUNK, data.doer) 
            end            
        end
    end

    inst:ListenForEvent("CHEVO_heavyobject_winched", function(world,data) 
        checkforclearwaters(inst,data)
    end, TheWorld) 

    --REMOVE_LUREPLANT
    local function checklureplant(inst,data)
        local source = inst.CHEVO_marker
        local range = ISLAND_RADIUS +10
        if source and source:GetDistanceSqToPoint(data.pt) < range * range then
            local pos = Vector3(source.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, range, FIND_LUREPLANT_TAGS) 
            for i=#ents,1,-1 do
                if ents[i].components.health:IsDead() then
                    table.remove(ents,i)
                end
            end       

            -- INVESTIGATE
            local gfl = inst.getgeneralfriendlevel(inst)
            if not inst.comment_data then
                inst.comment_data= {
                    pos = Vector3(data.target.Transform:GetWorldPosition()),
                    speech = STRINGS.HERMITCRAB_INVESTIGATE.REMOVE_LUREPLANT[gfl][math.random(1,#STRINGS.HERMITCRAB_INVESTIGATE.REMOVE_LUREPLANT[gfl])],
                }
            end

            if #ents <= 0 then                
                inst.components.friendlevels:CompleteTask(TASKS.REMOVE_LUREPLANT) 
            end            
        end
    end    
    inst:ListenForEvent("CHEVO_lureplantdied", function(world,data) 
        if data.target and data.target:HasTag("planted") then
            -- INVESTIGATE
            local gfl = inst.getgeneralfriendlevel(inst)
            if not inst.comment_data then
                inst.comment_data= {
                    pos = Vector3(data.target.Transform:GetWorldPosition()),
                    speech = STRINGS.HERMITCRAB_PLANTED_LUREPLANT_DIED[gfl][math.random(1,#STRINGS.HERMITCRAB_PLANTED_LUREPLANT_DIED[gfl])],
                }
            end
        else
            checklureplant(inst,data)
        end
    end, TheWorld)  

    -- ITEMS
    inst:ListenForEvent("itemget", function(world,data) 

        if data.item:HasTag("oceanfish") then

            local str = nil
            local completetask = nil
            local keepitem = false
             -- IN CASE OF PREVIOUS ERROR
            
            if inst.itemstotoss then
                for i,gift in ipairs(inst.itemstotoss)do
                    inst.components.inventory:DropItem(gift)
                    inst.components.lootdropper:FlingItem(gift)
                end
                inst.itemstotoss = nil
            end

            if data.item.components.weighable:GetWeightPercent() >= TUNING.HERMITCRAB.HEAVY_FISH_THRESHHOLD then

                local is_special_fish = false

                local dospecialfish = function(task, tacklesketch)
                    is_special_fish = true
                    completetask = task
                    if not inst.extrareward then
                        inst.extrareward = {}
                    end 
                    table.insert(inst.extrareward,tacklesketch)
                    --local sketch=SpawnPrefab(tacklesketch)
                    --inst.components.inventory:GiveItem(sketch)
                    --inst.components.entitytracker:TrackEntity("tossitem", sketch)
                end

                if data.item.prefab == "oceanfish_small_6_inv"  then
                    dospecialfish(TASKS.GIVE_BIG_AUTUM, "oceanfishinglure_hermit_drowsy_tacklesketch")
                elseif data.item.prefab == "oceanfish_small_7_inv" then
                    dospecialfish(TASKS.GIVE_BIG_SPRING, "oceanfishinglure_hermit_rain_tacklesketch")
                elseif data.item.prefab == "oceanfish_small_8_inv" then
                    dospecialfish(TASKS.GIVE_BIG_SUMMER, "oceanfishinglure_hermit_heavy_tacklesketch")
                elseif data.item.prefab == "oceanfish_medium_8_inv" then
                    dospecialfish(TASKS.GIVE_BIG_WINTER, "oceanfishinglure_hermit_snow_tacklesketch")
                end

                if not is_special_fish then
                    if not inst.heavyfish then
                        inst.heavyfish = 0 
                    end
                    inst.heavyfish = inst.heavyfish + 1
                    if inst.heavyfish == 5 then
                        completetask = TASKS.GIVE_HEAVY_FISH
                        inst.heavyfish = nil
                    end
                end

				str = STRINGS.HERMITCRAB_GETFISH_BIG[math.random(1,#STRINGS.HERMITCRAB_GETFISH_BIG)]
            else
                local weight = data.item.components.weighable:GetWeight()
                str = subfmt(STRINGS.HERMITCRAB_REFUSE_SMALL_FISH[math.random(1,#STRINGS.HERMITCRAB_REFUSE_SMALL_FISH)], {weight = string.format("%0.2f", weight)})

                inst.itemstotoss = {data.item}
                keepitem = true
                --inst.components.entitytracker:TrackEntity("tossitem", data.item)
            end
            if str then
                inst:PushEvent("use_pocket_scale",{str=str, target=data.item})
            end

            if completetask then
                inst.delayfriendtask = completetask
            end

            if not keepitem then
                data.item:Remove()
            end            
        elseif data.item:HasTag("umbrella") and TheWorld.state.israining then
            inst.components.inventory:Equip(data.item)
            inst.components.friendlevels:CompleteTask(TASKS.GIVE_UMBRELLA)
            
        elseif iscoat(data.item) and TheWorld.state.issnowing then
            inst.components.inventory:Equip(data.item)
            inst.components.friendlevels:CompleteTask(TASKS.GIVE_PUFFY_VEST)
        elseif data.item.prefab == "flowersalad" then
            inst.components.friendlevels:CompleteTask(TASKS.GIVE_FLOWER_SALAD)
            inst.components.timer:StartTimer("salad", TUNING.TOTAL_DAY_TIME * 10 )
            inst:PushEvent("eat_food")
            data.item:Remove()
        elseif data.item.prefab == "hermit_cracked_pearl" then
            inst.components.npc_talker:Say(STRINGS.HERMITCRAB_GOT_PEARL)
            data.item:RemoveTag("irreplaceable")
            data.item:Remove()            
        elseif data.item.components.edible then            
            if inst.driedthings then                
                inst.driedthings = inst.driedthings + 1
                if inst.driedthings == 6 then
                    inst.driedthings = nil
                end
            end
            inst:PushEvent("eat_food")
            data.item:Remove()
        end
    end)    
end
-- END FRIEND LEVELS
local function restocklures(inst)
    local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)   
    local fishingrod = inst.components.inventory:FindItem(function(item) return item.prefab == "oceanfishingrod" end) or (equipped and  equipped.prefab == "oceanfishingrod" and equipped )

    if fishingrod and not fishingrod.components.container:GetItemInSlot(1) then
        fishingrod.components.container:GiveItem(SpawnPrefab("oceanfishingbobber_ball"),1)
    end
 
    if fishingrod and not fishingrod.components.container:GetItemInSlot(2) then
        if math.random() < 0.5 then
            fishingrod.components.container:GiveItem(SpawnPrefab("oceanfishinglure_hermit_drowsy"),2)
        else
            fishingrod.components.container:GiveItem(SpawnPrefab("oceanfishinglure_hermit_heavy"),2)
        end
    end    
end


local function startfishing(inst)
    local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)   
    local fishingrod = inst.components.inventory:FindItem(function(item) return item.prefab == "oceanfishingrod" end) or (equipped and  equipped.prefab == "oceanfishingrod" and equipped )
    if not fishingrod then
        fishingrod = SpawnPrefab("oceanfishingrod")
        inst.components.inventory:GiveItem(fishingrod)        
    end

    if not fishingrod.components.equippable.isequipped then
        inst.components.inventory:Equip(fishingrod)
    end

    if inst.putawayrod then 
        inst.putawayrod:Cancel()
        inst.putawayrod = nil
    end
    inst:ListenForEvent("timerdone", function(inst, data) 
        if data.name == "fishingtime" then
            inst.sg:GoToState("oceanfishing_stop")
            inst.stopfishing(inst)            
        end
    end)

    inst:ListenForEvent("newfishingtarget", function(inst, data)         
        if data.target:HasTag("oceanfish") then
            inst.hookfish = true
        end        
    end)
end

local function stopfishing(inst)    
    inst.hookfish = nil
    inst:RemoveEventCallback("timerdone", function(inst, data) 
        if data.name == "fishingtime" then
            inst.sg:GoToState("oceanfishing_stop")
            inst.stopfishing(inst)            
        end
    end)
    if inst.components.timer:TimerExists("fishingtime") then
        inst.components.timer:StopTimer("fishingtime")
    end
    -- remove the fishing rod
    inst.putawayrod = inst:DoTaskInTime(2,function()
        local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if item and item.components.oceanfishingrod then
            inst.components.inventory:Unequip(EQUIPSLOTS.HANDS)
        end
    end)
end

local function onplayerdance(inst,player)
    if inst.getgeneralfriendlevel(inst) == "HIGH" then
        if inst:GetDistanceSqToInst(player) < TUNING.HERMITCRAB.DANCE_RANGE * TUNING.HERMITCRAB.DANCE_RANGE then
            inst:PushEvent("dance")
        end
    end
end
local function onmoonvent(inst,doer)
    if math.random() < 0.3  then
    local source = inst.CHEVO_marker
        if source and not inst.comment_data and source:GetDistanceSqToInst(doer) < ISLAND_RADIUS * ISLAND_RADIUS then
            local gfl = inst.getgeneralfriendlevel(inst)
        
            inst.comment_data= {
                pos = Vector3(doer.Transform:GetWorldPosition()),
                speech = STRINGS.HERMITCRAB_MOON_FISSURE_VENT[gfl][math.random(1,#STRINGS.HERMITCRAB_MOON_FISSURE_VENT[gfl])],
            }
        end
    end
end

local function OnSpringChange(inst)
    -- if task not complete, spawn lure plant at location. 
    if not inst.components.friendlevels.friendlytasks[TASKS.REMOVE_LUREPLANT].complete then
        --look for lureplant?
        local source = inst.CHEVO_marker
        if source then
            local pos = Vector3(source.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, ISLAND_RADIUS, FIND_LUREPLANT_TAGS)
            if #ents <= 0 then
                -- spawnlureplant
                local markerents = TheSim:FindEntities(pos.x,pos.y,pos.z, ISLAND_RADIUS, FIND_HERMITCRAB_LURE_MARKER_TAGS)
                if #markerents > 0 then
                    local markerpos = Vector3(markerents[1].Transform:GetWorldPosition())
                    local plant = SpawnPrefab("lureplant")
                    plant.Transform:SetPosition(markerpos.x,markerpos.y,markerpos.z)
                    plant.sg:GoToState("spawn")
                end
            end
        end
    end
end

local function MeetPlayers(inst)
    if TheWorld.components.messagebottlemanager ~= nil then
        local x, y, z = inst.Transform:GetWorldPosition()
        
        for i, v in ipairs(FindPlayersInRangeSq(x, y, z, MEET_PLAYERS_RANGE_SQ, true)) do
            TheWorld.components.messagebottlemanager:SetPlayerHasFoundHermit(v)
        end
    end
end

local function StopMeetPlayersTask(inst)
    if inst._meet_players_task ~= nil then
        inst._meet_players_task:Cancel()
        inst._meet_players_task = nil
    end
end

local function StartMeetPlayersTask(inst)
    StopMeetPlayersTask(inst)
    inst._meet_players_task = inst:DoPeriodicTask(MEET_PLAYERS_FREQUENCY, MeetPlayers)
end

local function retrofitconstuctiontasks(inst, house_prefab)
    if house_prefab == "hermithouse_construction2" then
        inst.components.friendlevels.friendlytasks[TASKS.FIX_HOUSE_1].complete = true
		print("Retrofitting for Return Of Them: Turn of Tides - completed hermit house 1 friendship task.")
    elseif house_prefab == "hermithouse_construction3" then
        inst.components.friendlevels.friendlytasks[TASKS.FIX_HOUSE_1].complete = true
        inst.components.friendlevels.friendlytasks[TASKS.FIX_HOUSE_2].complete = true
		print("Retrofitting for Return Of Them: Turn of Tides - completed hermit house 1, 2 friendship tasks.")
    elseif house_prefab == "hermithouse" then
        inst.components.friendlevels.friendlytasks[TASKS.FIX_HOUSE_1].complete = true
        inst.components.friendlevels.friendlytasks[TASKS.FIX_HOUSE_2].complete = true
        inst.components.friendlevels.friendlytasks[TASKS.FIX_HOUSE_3].complete = true
		print("Retrofitting for Return Of Them: Turn of Tides - completed hermit house 1, 2, 3 friendship tasks.")
    end
end

local function teleport_override_fn(inst)
	local target = inst.components.homeseeker and inst.components.homeseeker.home
					or inst.CHEVO_marker
					or inst

    local pt = target:GetPosition()
    local offset = FindWalkableOffset(pt, math.random() * 2 * PI, 4, 8, true, false) or
					FindWalkableOffset(pt, math.random() * 2 * PI, 8, 8, true, false)
    if offset ~= nil then
		pt = pt + offset
    end

	return pt 
end

local HERMITCRAB_MARKER_TAG = {"hermitcrab_marker"}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddLightWatcher()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 50, .5)

    inst.DynamicShadow:SetSize(1.5, .75)
    inst.Transform:SetFourFaced()

    inst:AddTag("character")
    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("hermitcrab_build")
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Hide("HAT")
    inst.AnimState:Hide("HAIR_HAT")
    inst.AnimState:Show("HAIR_NOHAT")
    inst.AnimState:Show("HAIR")
    inst.AnimState:Show("HEAD")
    inst.AnimState:Hide("HEAD_HAT")

    inst.AnimState:OverrideSymbol("fx_wipe", "wilson_fx", "fx_wipe")
    inst.AnimState:OverrideSymbol("fx_liquid", "wilson_fx", "fx_liquid")
    inst.AnimState:OverrideSymbol("shadow_hands", "shadow_hands", "shadow_hands")
    inst.AnimState:OverrideSymbol("snap_fx", "player_actions_fishing_ocean_new", "snap_fx")

    --Additional effects symbols for hit_darkness animation
    inst.AnimState:AddOverrideBuild("player_hit_darkness")
    inst.AnimState:AddOverrideBuild("player_receive_gift")
    inst.AnimState:AddOverrideBuild("player_actions_uniqueitem")
    inst.AnimState:AddOverrideBuild("player_wrap_bundle")
    inst.AnimState:AddOverrideBuild("player_lunge")
    inst.AnimState:AddOverrideBuild("player_attack_leap")
    inst.AnimState:AddOverrideBuild("player_superjump")
    inst.AnimState:AddOverrideBuild("player_multithrust")
    inst.AnimState:AddOverrideBuild("player_parryblock")
    inst.AnimState:AddOverrideBuild("player_emote_extra")
    inst.AnimState:AddOverrideBuild("player_boat")
    inst.AnimState:AddOverrideBuild("player_boat_plank")
    inst.AnimState:AddOverrideBuild("player_boat_net")        
    inst.AnimState:AddOverrideBuild("player_boat_sink")
    inst.AnimState:AddOverrideBuild("player_oar")
    inst.AnimState:AddOverrideBuild("player_peruse")

    inst.AnimState:AddOverrideBuild("player_actions_fishing_ocean_new")

    --Sneak these into pristine state for optimization

    --trader (from trader component) added to pristine state for optimization
    inst:AddTag("trader")

    inst:AddComponent("talker")        
    inst.components.talker.colour = Vector3(252/255, 226/255, 219/255)
    inst.components.talker.offset = Vector3(0, -400, 0)
    inst.components.talker:MakeChatter()
    inst.components.talker.lineduration = TUNING.HERMITCRAB.SPEAKTIME -0.5  -- it's minus one here to create a buffer between text.

    if LOC.GetTextScale() == 1 then
        --Note(Peter): if statement is hack/guess to make the talker not resize for users that are likely to be speaking using the fallback font.
        --Doesn't work for users across multiple languages or if they speak in english despite having a UI set to something else, but it's more likely to be correct, and is safer than modifying the talker
        inst.components.talker.fontsize = 40
    end
    inst.components.talker.font = TALKINGFONT_HERMIT

    inst:AddComponent("npc_talker")

    inst.displaynamefn = displaynamefn

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.talker.ontalk = ontalk

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.runspeed = TUNING.HERMITCRAB.RUNSPEED
    inst.components.locomotor.walkspeed = TUNING.HERMITCRAB.WALKSPEED

    inst:AddComponent("bloomer")

    ------------------------------------------
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetCanEatRaw()
    inst.components.eater.strongstomach = true -- can eat monster meat!

    ------------------------------------------
   -- inst:AddComponent("health")
   -- inst:AddComponent("combat")
   -- inst.components.combat.hiteffectsymbol = "torso"

   -- MakeMediumBurnableCharacter(inst, "torso")

    inst:AddComponent("named")

    ------------------------------------------
    MakeHauntablePanic(inst)

    -----------------------StopActionMeter-------------------

    inst:AddComponent("inventory")

    ------------------------------------------

    inst:AddComponent("lootdropper")

    ------------------------------------------

    inst:AddComponent("friendlevels")
    inst.components.friendlevels:SetDefaultRewards(defaultfriendrewards)
    inst.components.friendlevels:SetLeveltRewards(friendlevelrewards)
    inst.components.friendlevels:SetFriendlyTasks(friendlytasks)
    initfriendlevellisteners(inst)
    inst.complain = complain
    inst.rewardcheck = rewardcheck
    inst.getgeneralfriendlevel = getgeneralfriendlevel
    inst.storelevelunlocked = storelevelunlocked    

    inst:ListenForEvent("friend_task_complete", onTaskComplete)

    ------------------------------------------

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = false

    ------------------------------------------

	inst:AddComponent("teleportedoverride")
	inst.components.teleportedoverride:SetDestPositionFn(teleport_override_fn)

    ------------------------------------------

    inst:AddComponent("entitytracker")

    ------------------------------------------    

    inst:AddComponent("timer")

    ------------------------------------------
    MakeMediumFreezableCharacter(inst, "torso")

    ------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    ------------------------------------------

    inst:AddComponent("craftingstation")
    
    ------------------------------------------

    inst:SetStateGraph("SGhermitcrab")

    ------------------------------------------

    inst:SetBrain(normalbrain)

    inst.startfishing = startfishing
    inst.stopfishing = stopfishing
    inst.restocklures = restocklures
    inst.island_radius = ISLAND_RADIUS
    inst.dotalkingtimers = dotalkingtimers    
    inst.iscoat = iscoat
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    inst.OnLoadPostPass = OnLoadPostPass

    inst:WatchWorldState("isspring", OnSpringChange)

    inst:ListenForEvent("enterlimbo",  function() 
        inst.components.timer:StopTimer("complain_time")
    end)
    inst:ListenForEvent("exitlimbo",  function() 
        if inst.entity:IsAwake() then
            inst.components.timer:StartTimer("complain_time",10 + (math.random()*30))
            inst.components.npc_talker:resetqueue()
        end
    end)

    inst.OnEntitySleep = function(inst)
        inst.components.timer:StopTimer("complain_time")

        StopMeetPlayersTask(inst)
    end
    inst.OnEntityWake = function(inst)
        if not inst:HasTag("INLIMBO") then
            inst.components.timer:StartTimer("complain_time",10 + (math.random()*30))
            inst.components.npc_talker:resetqueue()
        end

        StartMeetPlayersTask(inst)
    end

    inst:ListenForEvent("dancingplayer",  function(world,data) onplayerdance(inst,data) end, TheWorld)
    inst:ListenForEvent("moonfissurevent",  function(world,data) onmoonvent(inst,data) end, TheWorld)
    inst:DoTaskInTime(0,function()
        inst.CHEVO_marker = FindEntity(inst, ISLAND_RADIUS, nil, HERMITCRAB_MARKER_TAG)
        if inst.CHEVO_marker then        
            inst:ListenForEvent("onremove",  function() inst.CHEVO_marker = nil end, inst.CHEVO_marker)
        end
    end)    

    inst:ListenForEvent("clocksegschanged", function(world, data)
        inst.segs = data
    end, TheWorld)
    
    inst:DoTaskInTime(0, RegisterToBottleManager) 

	inst.retrofitconstuctiontasks = retrofitconstuctiontasks

    return inst
end

local function markerfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("NOBLOCK")   
    inst:AddTag("NOCLICK")   
    inst:AddTag("hermitcrab_marker")

    return inst
end

local function markerfishingfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("NOBLOCK")   
    inst:AddTag("NOCLICK")   
    inst:AddTag("hermitcrab_marker_fishing")

    return inst
end

local function luremarkerfn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("NOBLOCK")
    inst:AddTag("NOCLICK")
    inst:AddTag("hermitcrab_lure_marker")

    return inst
end

return Prefab("hermitcrab", fn, assets, prefabs),
       Prefab("hermitcrab_marker", markerfn, {}, {}),
       Prefab("hermitcrab_lure_marker", luremarkerfn, {}, {}),
       Prefab("hermitcrab_marker_fishing", markerfishingfn, {}, {})