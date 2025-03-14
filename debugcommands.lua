function d_decodedata(path)
    print("DECODING",path)
    TheSim:GetPersistentString(path, function(load_success, str)
        if load_success then
            print("LOADED...")
            TheSim:SetPersistentString(path.."_decoded", str, false, function()
                print("SAVED!")
            end)
        else
            print("ERROR LOADING FILE! (wrong path?)")
        end
    end)
end

function d_domesticatedbeefalo(tendency, saddle)
    local beef = c_spawn('beefalo')
    beef.components.domesticatable:DeltaDomestication(1)
    beef.components.domesticatable:DeltaObedience(0.5)
    beef.components.domesticatable:DeltaTendency(TENDENCY[tendency] or TENDENCY.DEFAULT, 1)
    beef:SetTendency()
    beef.components.domesticatable:BecomeDomesticated()
    beef.components.rideable:SetSaddle(nil, SpawnPrefab(saddle or "saddle_basic"))
end

function d_domestication(domestication, obedience)
    if c_sel().components.domesticatable == nil then
        print("Selected ent not domesticatable")
    end
    if domestication ~= nil then
        c_sel().components.domesticatable:DeltaDomestication(domestication - c_sel().components.domesticatable:GetDomestication())
    end
    if obedience ~= nil then
        c_sel().components.domesticatable:DeltaObedience(obedience - c_sel().components.domesticatable:GetObedience())
    end
end

function d_testwalls()
    local walls = {
        "stone",
        "wood",
        "hay",
        "ruins",
        "moonrock",
    }
    local sx,sy,sz = ConsoleCommandPlayer().Transform:GetWorldPosition()
    for i,mat in ipairs(walls) do
        for j = 0,4 do
            local wall = SpawnPrefab("wall_"..mat)
            wall.Transform:SetPosition(sx + (i*6), sy, sz + j)
            wall.components.health:SetPercent(j*0.25)
        end
        for j = 5,15 do
            local wall = SpawnPrefab("wall_"..mat)
            wall.Transform:SetPosition(sx + (i*6), sy, sz + j)
            wall.components.health:SetPercent(j <= 11 and 1 or 0.5)
        end
    end
end


function d_testruins()
    ConsoleCommandPlayer().components.builder:UnlockRecipesForTech({SCIENCE = 2, MAGIC = 2})
    c_give("log", 20)
    c_give("flint", 20)
    c_give("twigs", 20)
    c_give("cutgrass", 20)
    c_give("lightbulb", 5)
    c_give("healingsalve", 5)
    c_give("batbat")
    c_give("icestaff")
    c_give("firestaff")
    c_give("tentaclespike")
    c_give("slurtlehat")
    c_give("armorwood")
    c_give("minerhat")
    c_give("lantern")
    c_give("backpack")
end

function d_combatgear()
    c_give("armorwood")
    c_give("footballhat")
    c_give("spear")
end

function d_teststate(state)
    c_sel().sg:GoToState(state)
end

function d_anim(animname, loop)
    if GetDebugEntity() then
        GetDebugEntity().AnimState:PlayAnimation(animname, loop or false)
    else
        print("No DebugEntity selected")
    end
end

function d_light(c1, c2, c3)
    TheSim:SetAmbientColour(c1, c2 or c1, c3 or c1)
end

local COMBAT_TAGS = {"_combat"}
function d_combatsimulator(prefab, count, force)
    count = count or 1

    local x,y,z = ConsoleWorldPosition():Get()
    local MakeBattle = nil
    MakeBattle = function()
        local creature = DebugSpawn(prefab)
        creature:ListenForEvent("onremove", MakeBattle)
        creature.Transform:SetPosition(x,y,z)
        if creature.components.knownlocations then
            creature.components.knownlocations:RememberLocation("home", {x=x,y=y,z=z})
        end
        if force then
            local target = FindEntity(creature, 20, nil, COMBAT_TAGS)
            if target then
                creature.components.combat:SetTarget(target)
            end
            creature:ListenForEvent("droppedtarget", function()
                local target = FindEntity(creature, 20, nil, COMBAT_TAGS)
                if target then
                    creature.components.combat:SetTarget(target)
                end
            end)
        end
    end

    for i=1,count do
        MakeBattle()
    end
end

function d_spawn_ds(prefab, scenario)
    local inst = c_spawn(prefab)
    if not inst then
        print("Need to select an entity to apply the scenario to.")
        return
    end

    if inst.components.scenariorunner then
        inst.components.scenariorunner:ClearScenario()
    end

    -- force reload the script -- this is for testing after all!
    package.loaded["scenarios/"..scenario] = nil

    inst:AddComponent("scenariorunner")
    inst.components.scenariorunner:SetScript(scenario)
    inst.components.scenariorunner:Run()
end



---------------------------------------------------
------------ skins functions --------------------
---------------------------------------------------

--For testing legacy skin DLC popup
--AddNewSkinDLCEntitlement("pack_oni_gift") MakeSkinDLCPopup()

local TEST_ITEM_NAME = "birdcage_pirate"
function d_test_thank_you(param)
	local ThankYouPopup = require "screens/thankyoupopup"
	local SkinGifts = require("skin_gifts")
	TheFrontEnd:PushScreen(ThankYouPopup({{ item = param or TEST_ITEM_NAME, item_id = 0, gifttype = SkinGifts.types[param or TEST_ITEM_NAME] or "DEFAULT" }}))
end
function d_test_skins_popup(param)
	local SkinsItemPopUp = require "screens/skinsitempopup"
	TheFrontEnd:PushScreen( SkinsItemPopUp(param or TEST_ITEM_NAME, "Peter", {1.0, 0.2, 0.6, 1.0}) )
end
function d_test_skins_announce(param)
	ThePlayer.HUD.eventannouncer:ShowSkinAnnouncement("Peter", {1.0, 0.2, 0.6, 1.0}, param or TEST_ITEM_NAME)
end
function d_test_skins_gift(param)
	local GiftItemPopUp = require "screens/giftitempopup"
	TheFrontEnd:PushScreen( GiftItemPopUp(ThePlayer, { param or TEST_ITEM_NAME }, { 0 }) )
end

function d_print_skin_info()
	
	print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

    local a = {
        "campfire_cabin",
        "armor_wood_roman",
        "spear_northern",
        "pickaxe_northern"
    }

    for _,v in pairs(a) do
        print( GetSkinName(v), GetSkinUsableOnString(v) )
	end
	
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
end

function d_skin_mode(mode)
    ConsoleCommandPlayer().components.skinner:SetSkinMode(mode)
end

function d_skin_name(name)
    ConsoleCommandPlayer().components.skinner:SetSkinName(name)
end

function d_clothing(name)
    ConsoleCommandPlayer().components.skinner:SetClothing(name)
end
function d_clothing_clear(type)
    ConsoleCommandPlayer().components.skinner:ClearClothing(type)
end

function d_cycle_clothing()
    local skinslist = TheInventory:GetFullInventory()

    local idx = 1
    local task = nil

    ConsoleCommandPlayer().cycle_clothing_task = ConsoleCommandPlayer():DoPeriodicTask(10, 
        function() 
            local type, name = GetTypeForItem(skinslist[idx].item_type)
            --print("showing clothing idx ", idx, name, type, #skinslist) 
            if (type ~= "base" and type ~= "item") then 
                c_clothing(name) 
            end

            if idx < #skinslist then 
                idx = idx + 1 
            else
                print("Ending cycle")
                ConsoleCommandPlayer().cycle_clothing_task:Cancel()
            end
        end)

end

function d_sinkhole()
	c_spawn("antlion_sinkhole"):PushEvent("startcollapse")
end

function d_stalkersetup()
	local mound = c_spawn("fossil_stalker")
	--mound.components.workable:SetWorkLeft(mound.components.workable.maxwork - 1)
	for i = 1, (mound.components.workable.maxwork - 1) do
		mound.form = 1
		mound.components.repairable.onrepaired(mound)
	end
	
	c_give "shadowheart"
	c_give "atrium_key"
end

function d_resetruins()
	TheWorld:PushEvent("resetruins")
end

-- Get the widget selected by the debug widget editor (WidgetDebug).
-- Try d_getwidget():ScaleTo(3,1,.7)
function d_getwidget()
    return TheFrontEnd.widget_editor.debug_widget_target
end

function d_halloween()
	local spacing = 2
	local num_wide = math.ceil(math.sqrt(NUM_TRINKETS))

	for y = 0, num_wide-1 do
		for x = 0, num_wide-1 do
			local inst = SpawnPrefab("trinket_"..(y*num_wide + x + 1))
			if inst ~= nil then
				print(x*spacing,  y*spacing)
				inst.Transform:SetPosition((ConsoleWorldPosition() + Vector3(x*spacing, 0, y*spacing)):Get())
			end
		end
	end

	local candy_wide = math.ceil(math.sqrt(NUM_HALLOWEENCANDY))
	for y = 0, candy_wide-1 do
		for x = 0, candy_wide-1 do
			local inst = SpawnPrefab("halloweencandy_"..(y*candy_wide + x + 1))
			if inst ~= nil then
				print(x*spacing,  y*spacing)
				inst.Transform:SetPosition((ConsoleWorldPosition() + Vector3((x + num_wide)*spacing, 0, (y+num_wide)*spacing)):Get())
			end
		end
	end
end

function d_potions()
	local all_potions = {"halloweenpotion_bravery_small", "halloweenpotion_bravery_large", "halloweenpotion_health_small",  "halloweenpotion_health_large",
						 "halloweenpotion_sanity_small", "halloweenpotion_sanity_large", "halloweenpotion_embers",  "halloweenpotion_sparks",  "livingtree_root"}

	local spacing = 2
	local num_wide = math.ceil(math.sqrt(#all_potions))

	for y = 0, num_wide-1 do
		for x = 0, num_wide-1 do
			local inst = SpawnPrefab(all_potions[(y*num_wide + x + 1)])
			if inst ~= nil then
				inst.Transform:SetPosition((ConsoleWorldPosition() + Vector3(x*spacing, 0, y*spacing)):Get())
			end
		end
	end
end

function d_weirdfloaters()
    local weird_float_items =
    {
        "abigail flower",   "axe",              "batbat",       "blowdart_fire",    "blowdart_pipe",    "blowdart_sleep",
        "blowdart_walrus",  "blowdart_yellow",  "boomerang",    "brush",            "bugnet",           "cane",
        "firestaff",        "fishingrod",       "glasscutter",  "goldenaxe",        "goldenpickaxe",
        "goldenshovel",     "grass_umbrella",   "greenstaff",   "hambat",           "hammer",           "houndstooth",
        "houndwhistle",     "icestaff",         "lucy",         "miniflare",        "moonglassaxe",     "multitool_axe_pickaxe",
        "nightstick",       "nightsword",       "opalstaff",    "orangestaff",      "panflute",         "perdfan",
        "pickaxe",          "pitchfork",        "razor",        "redlantern",       "shovel",           "spear",
        "spear_wathgrithr", "staff_tornado",    "telestaff",    "tentaclespike",    "trap",             "umbrella",
        "yellowstaff",      "yotp_food3",
    }

    local spacing = 2
    local num_wide = math.ceil(math.sqrt(#weird_float_items))

    for y = 0, num_wide - 1 do
        for x = 0, num_wide - 1 do
            local inst = SpawnPrefab(weird_float_items[y*num_wide + x + 1])
            if inst ~= nil then
                inst.Transform:SetPosition((ConsoleWorldPosition() + Vector3(x*spacing, 0, y*spacing)):Get())
            end
        end
    end
end

function d_wintersfeast()
	local all_items = GetAllWinterOrnamentPrefabs()
	local spacing = 2
	local num_wide = math.ceil(math.sqrt(#all_items))

	for y = 0, num_wide-1 do
		for x = 0, num_wide-1 do
			local inst = SpawnPrefab(all_items[(y*num_wide + x + 1)])
			if inst ~= nil then
				inst.Transform:SetPosition((ConsoleWorldPosition() + Vector3(x*spacing, 0, y*spacing)):Get())
			end
		end
	end
end

function d_wintersfood()
    local spacing = 2
    local num_wide = math.ceil(math.sqrt(NUM_WINTERFOOD))

    for y = 0, num_wide-1 do
        for x = 0, num_wide-1 do
            local inst = SpawnPrefab("winter_food"..(y*num_wide + x + 1))
            if inst ~= nil then
                inst.Transform:SetPosition((ConsoleWorldPosition() + Vector3(x*spacing, 0, y*spacing)):Get())
            end
        end
    end
end

function d_madsciencemats()
	c_mat("halloween_experiment_bravery")
	c_mat("halloween_experiment_health")
	c_mat("halloween_experiment_hunger") 
	c_mat("halloween_experiment_sanity") 
	c_mat("halloween_experiment_volatile")
	c_mat("halloween_experiment_root")
end

function d_showalleventservers()
	TheFrontEnd._showalleventservers = not TheFrontEnd._showalleventservers
end

function d_lavaarena_skip()
	TheWorld:PushEvent("ms_lavaarena_endofstage", {reason="debug triggered"})
end

function d_lavaarena_speech(dialog, banter_line)
	local is_banter = string.find(string.upper(dialog), "BANTER", 1) ~= nil
	dialog = STRINGS[string.upper(dialog)]
	if dialog ~= nil then
		if is_banter then
			dialog = { dialog[banter_line or math.random(#dialog)] }
		end
		
		local lines = {}
		for i,v in ipairs(dialog) do
			table.insert(lines, {message=v, duration=3.5, noanim=true})
		end	

		local target = TheWorld.components.lavaarenaevent:GetBoarlord()
		if target then
			target:PushEvent("lavaarena_talk", {text=lines})
		end
	end
end

function d_unlockallachievements()
	local achievements = {}
	for k, _ in pairs(EventAchievements:GetActiveAchievementsIdList()) do
		table.insert(achievements, k)
	end
	
	TheItems:ReportEventProgress(json.encode_compliant(
		{
			WorldID = "dev_"..tostring(math.random(9999999))..tostring(math.random(9999999)),
			Teams =
			{
				{
					Won=true,
					Points=5,
					PlayerStats=
					{
						{KU = TheNet:GetUserID(), PlaytimeMs = 100000, Custom = { UnlockAchievements = achievements }},
					}
				},
			}
		}), function(ku_tbl, success) print( "Report event:", success) dumptable(ku_tbl) end )

end

function d_unlockfoodachievements()
	local achievements = {
    	"food_001", "food_002", "food_003", "food_004", "food_005", "food_006", "food_007", "food_008", "food_009",
	    "food_010", "food_011", "food_012", "food_013", "food_014", "food_015", "food_016", "food_017", "food_018", "food_019",
	    "food_020", "food_021", "food_022", "food_023", "food_024", "food_025", "food_026", "food_027", "food_028", "food_029",
	    "food_030", "food_031", "food_032", "food_033", "food_034", "food_035", "food_036", "food_037", "food_038", "food_039",
	    "food_040", "food_041", "food_042", "food_043", "food_044", "food_045", "food_046", "food_047", "food_048", "food_049",
	    "food_050", "food_051", "food_052", "food_053", "food_054", "food_055", "food_056", "food_057", "food_058", "food_059",
		"food_060",	"food_061", "food_062", "food_063", "food_064", "food_065", "food_066", "food_067", "food_068", "food_069",
	    "food_syrup",
    }
	
	TheItems:ReportEventProgress(json.encode_compliant(
		{
			WorldID = "dev_"..tostring(math.random(9999999))..tostring(math.random(9999999)),
			Teams =
			{
				{
					Won=true,
					Points=5,
					PlayerStats=
					{
						{KU = TheNet:GetUserID(), PlaytimeMs = 1000, Custom = { UnlockAchievements = achievements }},
					}
				},
			}
		}), function(ku_tbl, success) print( "Report event:", success) dumptable(ku_tbl) end )

end

function d_reportevent(other_ku)
	TheItems:ReportEventProgress(json.encode_compliant(
		{
			WorldID = "dev_"..tostring(math.random(9999999))..tostring(math.random(9999999)),
			Teams =
			{
				{
					Won=true,
					Points=5,
					PlayerStats=
					{
						{KU = TheNet:GetUserID(), PlaytimeMs = 100000, Custom = { UnlockAchievements = {"scotttestdaily_d1", "wintime_30"} }},
						--{KU = other_ku or "KU_test", PlaytimeMs = 60000}
					}
				},
				--{
				--	Won=false,
				--	Points=2,
				--	PlayerStats=
				--	{
				--		{KU = "KU_test2", PlaytimeMs = 6000}
				--	}
				--}
			}
		}), function(ku_tbl, success) print( "Report event:", success) dumptable(ku_tbl) end )
end

function d_ground(ground)
	ground = ground == nil and GROUND.QUAGMIRE_SOIL or 
			type(ground) == "string" and GROUND[string.upper(ground)] 
			or ground

	local pt = TheInput:GetWorldPosition()
	
    local x, y = TheWorld.Map:GetTileCoordsAtPoint(pt:Get())

    local original_tile_type = TheWorld.Map:GetTileAtPoint(pt:Get())
    TheWorld.Map:SetTile(x, y, ground)
    TheWorld.Map:RebuildLayer(original_tile_type, x, y)
    TheWorld.Map:RebuildLayer(ground, x, y)

    TheWorld.minimap.MiniMap:RebuildLayer(original_tile_type, x, y)
    TheWorld.minimap.MiniMap:RebuildLayer(ground, x, y)
end

function d_portalfx()
	TheWorld:PushEvent("ms_newplayercharacterspawned", { player = ThePlayer})
end

function d_islandstart()
	c_give("log", 12)
	c_give("rocks", 12)
	c_give("smallmeat", 2)
	c_give("meat", 2)
	c_give("rope", 2)
	c_give("cutgrass", 9)
	c_give("backpack")
	c_give("charcoal", 9)
	c_give("carrot", 3)
	c_give("berries", 12)
	c_give("pickaxe")
	c_give("axe")
	c_give(PickSomeWithDups(1, {"strawhat", "minerhat", "flowerhat"})[1])
	c_give(PickSomeWithDups(1, {"spear", "hambat", "trap"})[1])

    local MainCharacter = ConsoleCommandPlayer()
    if MainCharacter ~= nil and MainCharacter.components.sanity ~= nil then
		MainCharacter.components.sanity:SetPercent(math.random() * 0.4 + 0.2)
	end		

end

function d_boatitems()
    c_spawn("boat_item")
    c_spawn("mast_item", 3)
    c_spawn("anchor_item")
    c_spawn("steeringwheel_item")
    c_spawn("oar")
end

function d_giveturfs()
    local GroundTiles = require("worldtiledefs")
    for k, v in pairs(GroundTiles.turf) do
        c_give("turf_"..v.name)
    end
end

function d_spawnlayout(name, offset)
	local obj_layout = require("map/object_layout")
	local entities = {}
	local map_width, map_height = TheWorld.Map:GetSize()
	local add_fn = {
		fn=function(prefab, points_x, points_y, current_pos_idx, entitiesOut, width, height, prefab_list, prefab_data, rand_offset)
		print("adding, ", prefab, points_x[current_pos_idx], points_y[current_pos_idx])
			local x = (points_x[current_pos_idx] - width/2.0)*TILE_SCALE
			local y = (points_y[current_pos_idx] - height/2.0)*TILE_SCALE
			x = math.floor(x*100)/100.0
			y = math.floor(y*100)/100.0
			SpawnPrefab(prefab).Transform:SetPosition(x, 0, y)
		end,
		args={entitiesOut=entities, width=map_width, height=map_height, rand_offset = false, debug_prefab_list=nil}
	}

    local x, y, z = ConsoleWorldPosition():Get()
	x, z = TheWorld.Map:GetTileCoordsAtPoint(x, y, z)
	offset = offset or 3
	obj_layout.Place({math.floor(x) - 3, math.floor(z) - 3}, name, add_fn, nil, TheWorld.Map)
end

function d_allfish()
	
	local fish_defs = require("prefabs/oceanfishdef").fish
	local allfish = {"spoiled_fish", "fishmeat", "fishmeat_cooked", "fishmeat_small", "fishmeat_small_cooked"}

	local pt = ConsoleWorldPosition()
	local pst = TheWorld.Map:IsVisualGroundAtPoint(pt:Get()) and "_inv" or ""
	for k, _ in pairs(fish_defs) do
		table.insert(allfish, k .. pst)
	end

	local spacing = 2
	local num_wide = math.ceil(math.sqrt(#allfish))

	for y = 0, num_wide-1 do
		for x = 0, num_wide-1 do
			local inst = SpawnPrefab(allfish[(y*num_wide + x + 1)])
			if inst ~= nil then
				inst.Transform:SetPosition((pt + Vector3(x*spacing, 0, y*spacing)):Get())
			end
		end
	end
end

function d_fishing()
	local items = {"oceanfishingbobber_ball", "oceanfishingbobber_oval",  "twigs", "trinket_8", 
					 "oceanfishingbobber_crow", "oceanfishingbobber_robin", "oceanfishingbobber_robin_winter",  "oceanfishingbobber_canary", 
					 "oceanfishingbobber_goose", "oceanfishingbobber_malbatross", 
				 	"oceanfishinglure_spinner_red", "oceanfishinglure_spinner_blue", "oceanfishinglure_spinner_green",
				 	"oceanfishinglure_spoon_red", "oceanfishinglure_spoon_blue", "oceanfishinglure_spoon_green",
					"oceanfishinglure_hermit_snow", "oceanfishinglure_hermit_rain", "oceanfishinglure_hermit_drowsy", "oceanfishinglure_hermit_heavy", 
					 "berries", "butterflywings", "oceanfishingrod"}

	local spacing = 2
	local num_wide = math.ceil(math.sqrt(#items))

	local pt = ConsoleWorldPosition()

	for y = 0, num_wide-1 do
		for x = 0, num_wide-1 do
			local inst = SpawnPrefab(items[(y*num_wide + x + 1)])
			if inst ~= nil then
				inst.Transform:SetPosition((pt + Vector3(x*spacing, 0, y*spacing)):Get())
			end
		end
	end
end

function d_tables()
    local items = {"table_winters_feast", "table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast",
                    "table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast",
                    "table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast",
                    "table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast","table_winters_feast",}

    local spacing = 1
    local num_wide = math.ceil(math.sqrt(#items))

    local pt = ConsoleWorldPosition()

    for y = 0, num_wide-1 do
        for x = 0, num_wide-1 do
            local inst = SpawnPrefab(items[(y*num_wide + x + 1)])
            if inst ~= nil then
                inst.Transform:SetPosition((pt + Vector3(x*spacing, 0, y*spacing)):Get())
            end
        end
    end
end

function d_gofishing()
	c_give("oceanfishingrod", 1)
	c_give("oceanfishingbobber_ball", 5)
	c_give("oceanfishingbobber_robin_winter", 5)
	c_give("oceanfishingbobber_malbatross", 5)
	c_give("oceanfishinglure_spinner_red", 5)
	c_give("oceanfishinglure_spinner_green", 5)
end

function d_ratracer(speed, stamina, direction, reaction)
	local rat = DebugSpawn("carrat")
	rat._spread_stats_task:Cancel() rat._spread_stats_task = nil
	rat.components.yotc_racestats.speed = speed or math.random(TUNING.RACE_STATS.MAX_STAT_VALUE + 1) - 1
	rat.components.yotc_racestats.stamina = stamina or math.random(TUNING.RACE_STATS.MAX_STAT_VALUE + 1) - 1
	rat.components.yotc_racestats.direction = direction or math.random(TUNING.RACE_STATS.MAX_STAT_VALUE + 1) - 1
	rat.components.yotc_racestats.reaction = reaction or math.random(TUNING.RACE_STATS.MAX_STAT_VALUE + 1) - 1
	rat:_setcolorfn("RANDOM")
	c_select(rat)
	ConsoleCommandPlayer().components.inventory:GiveItem(rat)
end

function d_ratracers()
    local MainCharacter = ConsoleCommandPlayer()
	local rat 

	rat = DebugSpawn("carrat")
	rat._spread_stats_task:Cancel() rat._spread_stats_task = nil
	rat.components.yotc_racestats.speed = TUNING.RACE_STATS.MAX_STAT_VALUE
	rat:_setcolorfn("white")
	MainCharacter.components.inventory:GiveItem(rat)
	rat = DebugSpawn("carrat")
	rat._spread_stats_task:Cancel() rat._spread_stats_task = nil
	rat.components.yotc_racestats.speed = 0
	rat:_setcolorfn("yellow")
	MainCharacter.components.inventory:GiveItem(rat)

	rat = DebugSpawn("carrat")
	rat._spread_stats_task:Cancel() rat._spread_stats_task = nil
	rat.components.yotc_racestats.stamina = TUNING.RACE_STATS.MAX_STAT_VALUE
	rat:_setcolorfn("green")
	MainCharacter.components.inventory:GiveItem(rat)
	rat = DebugSpawn("carrat")
	rat._spread_stats_task:Cancel() rat._spread_stats_task = nil
	rat.components.yotc_racestats.stamina = 0
	rat:_setcolorfn("brown")
	MainCharacter.components.inventory:GiveItem(rat)

	rat = DebugSpawn("carrat")
	rat._spread_stats_task:Cancel() rat._spread_stats_task = nil
	rat.components.yotc_racestats.direction = TUNING.RACE_STATS.MAX_STAT_VALUE
	rat:_setcolorfn("blue")
	MainCharacter.components.inventory:GiveItem(rat)
	rat = DebugSpawn("carrat")
	rat._spread_stats_task:Cancel() rat._spread_stats_task = nil
	rat.components.yotc_racestats.direction = 0
	rat:_setcolorfn("NEUTRAL")
	MainCharacter.components.inventory:GiveItem(rat)

	rat = DebugSpawn("carrat")
	rat._spread_stats_task:Cancel() rat._spread_stats_task = nil
	rat.components.yotc_racestats.reaction = TUNING.RACE_STATS.MAX_STAT_VALUE
	rat:_setcolorfn("purple")
	MainCharacter.components.inventory:GiveItem(rat)
	rat = DebugSpawn("carrat")
	rat._spread_stats_task:Cancel() rat._spread_stats_task = nil
	rat.components.yotc_racestats.reaction = 0
	rat:_setcolorfn("pink")
	MainCharacter.components.inventory:GiveItem(rat)
end

-- d_setup_placeholders( STRINGS.CHARACTERS.WARLY, "scripts\\speech_warly.lua" )
function d_setup_placeholders( reuse, out_file_name )
	local use_table = nil
	use_table = function( base_speech, reuse_speech )
		for k,v in pairs( base_speech ) do
			if type(v) == "string" then
				if reuse_speech ~= nil and reuse_speech[k] ~= nil then
					--do nothing
				else
					reuse_speech[k] = "TODO"
				end
			else
				--table
				if reuse_speech[k] == nil then
					reuse_speech[k] = {}
				end
				use_table( base_speech[k], reuse_speech[k])
			end
		end
	end
	use_table( STRINGS.CHARACTERS.GENERIC, reuse )
	
	local out_file = io.open( out_file_name, "w")
	
	out_file:write("return {\n")
	
	local write_table = nil
	write_table = function( tbl, tabs )
		for k,v in orderedPairs(tbl) do
			for i=1,tabs do out_file:write("\t") end

			if type(v) == "string" then
				local out_v = string.gsub(v, "\n", "\\n")
				out_v = string.gsub(out_v, "\"", "\\\"")
				if type(k) == "string" then
					out_file:write(k .. " = \"" .. out_v .. "\",\n")
				else
					out_file:write("\"" .. out_v .. "\",\n")
				end
			else
				out_file:write(k .. " =\n")
				for i=1,tabs do out_file:write("\t") end
				out_file:write("{\n")
				
				write_table( tbl[k], tabs + 1 )
				
				for i=1,tabs do out_file:write("\t") end
				out_file:write("},\n")
			end
		end
	end
	
	write_table( reuse, 1 )
	
	out_file:write("}")
	out_file:close()
end

function d_allshells()
	local x, y, z = TheInput:GetWorldPosition():Get() 
	for i=1, 12 do 
		local shell=SpawnPrefab("singingshell_large") 
		shell.Transform:SetPosition(x + i*2, 0, z) 
		shell.components.cyclable:SetStep(i) 
		local shell=SpawnPrefab("singingshell_medium") 
		shell.Transform:SetPosition(x + i*2, 0, z + 6) 
		shell.components.cyclable:SetStep(i) 
		local shell=SpawnPrefab("singingshell_small") 
		shell.Transform:SetPosition(x + i*2, 0, z + 12) 
		shell.components.cyclable:SetStep(i) 
	end 
end


function d_fish(swim, r,g,b)
	local x, y, z = TheInput:GetWorldPosition():Get() 

	local fish
	fish = c_spawn "oceanfish_medium_4"
	if not swim then
		fish:StopBrain()
		fish:SetBrain(nil)
	end
	fish.Transform:SetPosition(x, y, z)
	fish:RemoveTag("NOCLICK")

	fish = c_spawn "oceanfish_medium_3"
	if not swim then
		fish:StopBrain()
		fish:SetBrain(nil)
	end
	fish.Transform:SetPosition(x+2, y, z)
	fish:RemoveTag("NOCLICK")

	fish = c_spawn "oceanfish_medium_8"
	if not swim then
		fish:StopBrain()
		fish:SetBrain(nil)
	end
	fish.Transform:SetPosition(x, y, z+2)
	fish:RemoveTag("NOCLICK")


	fish = c_spawn "oceanfish_medium_3"
	if not swim then
		fish:StopBrain()
		fish:SetBrain(nil)
	end
	fish.Transform:SetPosition(x+2, y, z+2)
	fish:RemoveTag("NOCLICK")
	fish.AnimState:SetAddColour((r or 0)/255, (g or 5)/255, (b or 5)/255, 0)

end