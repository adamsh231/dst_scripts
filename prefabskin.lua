require("class")
require("prefabs")


--tuck_torso = "full" - torso goes behind pelvis slot
--tuck_torso = "none" - torso goes above the skirt
--tuck_torso = "skirt" - torso goes betwen the skirt and pelvis (the default)
BASE_TORSO_TUCK = {}

BASE_ALTERNATE_FOR_BODY = {}
BASE_ALTERNATE_FOR_SKIRT = {}

BASE_LEGS_SIZE = {}
BASE_FEET_SIZE = {}

SKIN_FX_PREFAB = {}



--------------------------------------------------------------------------
--[[ Basic skin functions ]]
--------------------------------------------------------------------------
function basic_init_fn(inst, build_name, def_build)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, def_build)
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
    end
end
function basic_clear_fn(inst, def_build)
    inst.AnimState:SetBuild(def_build)
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem:ChangeImageName()
    end
end

backpack_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "swap_backpack" ) end
backpack_clear_fn = function(inst) basic_clear_fn(inst, "swap_backpack" ) end

krampus_sack_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "swap_krampus_sack" ) end
krampus_sack_clear_fn = function(inst) basic_clear_fn(inst, "swap_krampus_sack" ) end

piggyback_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "swap_piggyback" ) end
piggyback_clear_fn = function(inst) basic_clear_fn(inst, "swap_piggyback" ) end

ruins_bat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "swap_ruins_bat" ) end
ruins_bat_clear_fn = function(inst) basic_clear_fn(inst, "swap_ruins_bat" ) end

hambat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "ham_bat" ) end
hambat_clear_fn = function(inst) basic_clear_fn(inst, "ham_bat" ) end

batbat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "batbat" ) end
batbat_clear_fn = function(inst) basic_clear_fn(inst, "batbat" ) end

boomerang_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "boomerang" ) end
boomerang_clear_fn = function(inst) basic_clear_fn(inst, "boomerang" ) end

hammer_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "swap_hammer" ) end
hammer_clear_fn = function(inst) basic_clear_fn(inst, "swap_hammer" ) end

torch_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "swap_torch" ) end
torch_clear_fn = function(inst) basic_clear_fn(inst, "swap_torch" ) end

lighter_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "lighter" ) end
lighter_clear_fn = function(inst) basic_clear_fn(inst, "lighter" ) end

spear_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "swap_spear" ) end
spear_clear_fn = function(inst) basic_clear_fn(inst, "swap_spear" ) end

spear_wathgrithr_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "swap_spear_wathgrithr" ) end
spear_wathgrithr_clear_fn = function(inst) basic_clear_fn(inst, "swap_spear_wathgrithr" ) end

axe_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "axe" ) end
axe_clear_fn = function(inst) basic_clear_fn(inst, "axe" ) end

goldenaxe_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "goldenaxe" ) end
goldenaxe_clear_fn = function(inst) basic_clear_fn(inst, "goldenaxe" ) end

pickaxe_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "pickaxe" ) end
pickaxe_clear_fn = function(inst) basic_clear_fn(inst, "pickaxe" ) end

goldenpickaxe_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "goldenpickaxe" ) end
goldenpickaxe_clear_fn = function(inst) basic_clear_fn(inst, "goldenpickaxe" ) end

shovel_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "shovel" ) end
shovel_clear_fn = function(inst) basic_clear_fn(inst, "shovel" ) end

goldenshovel_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "goldenshovel" ) end
goldenshovel_clear_fn = function(inst) basic_clear_fn(inst, "goldenshovel" ) end

umbrella_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "umbrella" ) end
umbrella_clear_fn = function(inst) basic_clear_fn(inst, "umbrella" ) end

oceanfishingrod_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "fishingrod_ocean" ) end
oceanfishingrod_clear_fn = function(inst) basic_clear_fn(inst, "fishingrod_ocean" ) end

amulet_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "amulets" ) end
amulet_clear_fn = function(inst) basic_clear_fn(inst, "amulets" ) end

book_brimstone_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "books" ) end
book_brimstone_clear_fn = function(inst) basic_clear_fn(inst, "books" ) end

bedroll_furry_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "swap_bedroll_furry" ) end
bedroll_furry_clear_fn = function(inst) basic_clear_fn(inst, "swap_bedroll_furry" ) end

featherfan_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "fan" ) end
featherfan_clear_fn = function(inst) basic_clear_fn(inst, "fan" ) end

armordragonfly_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "torso_dragonfly" ) end
armordragonfly_clear_fn = function(inst) basic_clear_fn(inst, "torso_dragonfly" ) end

armorgrass_init_fn =  function(inst, build_name) basic_init_fn(inst, build_name, "armor_grass" ) end
armorgrass_clear_fn = function(inst) basic_clear_fn(inst, "armor_grass" ) end

armormarble_init_fn =  function(inst, build_name) basic_init_fn(inst, build_name, "armor_marble" ) end
armormarble_clear_fn = function(inst) basic_clear_fn(inst, "armor_marble" ) end

armorwood_init_fn =  function(inst, build_name) basic_init_fn(inst, build_name, "armor_wood") end
armorwood_clear_fn = function(inst) basic_clear_fn(inst, "armor_wood" ) end

armorruins_init_fn =  function(inst, build_name) basic_init_fn(inst, build_name, "armor_ruins" ) end
armorruins_clear_fn = function(inst) basic_clear_fn(inst, "armor_ruins" ) end

armor_sanity_init_fn =  function(inst, build_name) basic_init_fn(inst, build_name, "armor_sanity" ) end
armor_sanity_clear_fn = function(inst) basic_clear_fn(inst, "armor_sanity" ) end

tophat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_top" ) end
tophat_clear_fn = function(inst) basic_clear_fn(inst, "hat_top" ) end

flowerhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_flower" ) end
flowerhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_flower" ) end

strawhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_straw" ) end
strawhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_straw" ) end

walrushat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_walrus" ) end
walrushat_clear_fn = function(inst) basic_clear_fn(inst, "hat_walrus" ) end

winterhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_winter" ) end
winterhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_winter" ) end

catcoonhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_catcoon" ) end
catcoonhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_catcoon" ) end

rainhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_rain" ) end
rainhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_rain" ) end

minerhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_miner" ) end
minerhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_miner" ) end

footballhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_football" ) end
footballhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_football" ) end

featherhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_feather" ) end
featherhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_feather" ) end

beehat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_bee" ) end
beehat_clear_fn = function(inst) basic_clear_fn(inst, "hat_bee" ) end

watermelonhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_watermelon" ) end
watermelonhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_watermelon" ) end

wathgrithrhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_wathgrithr" ) end
wathgrithrhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_wathgrithr" ) end

beefalohat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_beefalo" ) end
beefalohat_clear_fn = function(inst) basic_clear_fn(inst, "hat_beefalo" ) end

eyebrellahat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_eyebrella" ) end
eyebrellahat_clear_fn = function(inst) basic_clear_fn(inst, "hat_eyebrella" ) end

earmuffshat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_earmuffs" ) end
earmuffshat_clear_fn = function(inst) basic_clear_fn(inst, "hat_earmuffs" ) end

ruinshat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_ruins" ) end
ruinshat_clear_fn = function(inst) basic_clear_fn(inst, "hat_ruins" ) end

walterhat_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "hat_walter" ) end
walterhat_clear_fn = function(inst) basic_clear_fn(inst, "hat_walter" ) end

researchlab3_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "researchlab3" ) end
researchlab3_clear_fn = function(inst) basic_clear_fn(inst, "researchlab3" ) end

mushroom_light_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "mushroom_light" ) end
mushroom_light_clear_fn = function(inst) basic_clear_fn(inst, "mushroom_light" ) end

mushroom_light2_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "mushroom_light2" ) end
mushroom_light2_clear_fn = function(inst) basic_clear_fn(inst, "mushroom_light2" ) end

tent_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "tent" ) end
tent_clear_fn = function(inst) basic_clear_fn(inst, "tent" ) end

rainometer_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "rain_meter" ) end
rainometer_clear_fn = function(inst) basic_clear_fn(inst, "rain_meter" ) end

winterometer_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "winter_meter" ) end
winterometer_clear_fn = function(inst) basic_clear_fn(inst, "winter_meter" ) end

lightning_rod_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "lightning_rod" ) end
lightning_rod_clear_fn = function(inst) basic_clear_fn(inst, "lightning_rod" ) end

arrowsign_post_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "sign_arrow_post" ) end
arrowsign_post_clear_fn = function(inst) basic_clear_fn(inst, "sign_arrow_post" ) end

treasurechest_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "treasure_chest" ) end
treasurechest_clear_fn = function(inst) basic_clear_fn(inst, "treasure_chest" ) end

wardrobe_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "wardrobe" ) end
wardrobe_clear_fn = function(inst) basic_clear_fn(inst, "wardrobe" ) end

endtable_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "stagehand" ) end
endtable_clear_fn = function(inst) basic_clear_fn(inst, "stagehand" ) end

dragonflyfurnace_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "dragonfly_furnace" ) end
dragonflyfurnace_clear_fn = function(inst) basic_clear_fn(inst, "dragonfly_furnace" ) end

birdcage_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "bird_cage" ) end
birdcage_clear_fn = function(inst) basic_clear_fn(inst, "bird_cage" ) end

meatrack_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "meat_rack" ) end
meatrack_clear_fn = function(inst) basic_clear_fn(inst, "meat_rack" ) end

beebox_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "bee_box" ) end
beebox_clear_fn = function(inst) basic_clear_fn(inst, "bee_box" ) end

rabbithouse_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "rabbit_house" ) end
rabbithouse_clear_fn = function(inst) basic_clear_fn(inst, "rabbit_house" ) end

researchlab3_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "researchlab3" ) end
researchlab3_clear_fn = function(inst) basic_clear_fn(inst, "researchlab3" ) end

beemine_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "bee_mine" ) end
beemine_clear_fn = function(inst) basic_clear_fn(inst, "bee_mine" ) end

trap_teeth_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "trap_teeth" ) end
trap_teeth_clear_fn = function(inst) basic_clear_fn(inst, "trap_teeth" ) end

trap_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "trap" ) end
trap_clear_fn = function(inst) basic_clear_fn(inst, "trap" ) end

birdtrap_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "birdtrap" ) end
birdtrap_clear_fn = function(inst) basic_clear_fn(inst, "birdtrap" ) end

grass_umbrella_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "parasol" ) end
grass_umbrella_clear_fn = function(inst) basic_clear_fn(inst, "parasol" ) end

saltbox_init_fn = function(inst, build_name) basic_init_fn(inst, build_name, "saltbox" ) end
saltbox_clear_fn = function(inst) basic_clear_fn(inst, "saltbox" ) end


--------------------------------------------------------------------------
--[[ Pighouse skin functions ]]
--------------------------------------------------------------------------
pighouse_init_fn = function(inst, build_name)
    basic_init_fn(inst, build_name, "pig_house" )
    if inst._window ~= nil then
        inst._window.AnimState:SetSkin(build_name)
    end
    if inst._windowsnow ~= nil then
        inst._windowsnow.AnimState:SetSkin(build_name)
    end
end
pighouse_clear_fn = function(inst)
    basic_clear_fn(inst, "pig_house" )
    if inst._window ~= nil then
        inst._window.AnimState:SetBuild("pig_house")
    end
    if inst._windowsnow ~= nil then
        inst._windowsnow.AnimState:SetBuild("pig_house")
    end
end



--------------------------------------------------------------------------
--[[ Abigail skin functions ]]
--------------------------------------------------------------------------
function abigail_flower_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end
    inst.flower_skin_id:set(inst.skin_id)
    
    inst.AnimState:SetSkin(build_name, "abigail_flower_rework")
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
    inst.linked_skinname = string.gsub(build_name, "_flower", "")
end
function abigail_flower_clear_fn(inst)
    inst.AnimState:SetBuild("abigail_flower_rework")
    inst.linked_skinname = nil
    inst.components.inventoryitem:ChangeImageName()
end

function abigail_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end
    inst.AnimState:OverrideItemSkinSymbol("ghost_Hat", build_name, "ghost_Hat", inst.GUID, "ghost_abigail_build")
end
function abigail_clear_fn(inst)
    inst.AnimState:ClearOverrideSymbol("ghost_Hat")
end

--------------------------------------------------------------------------
--[[ Bug Net skin functions ]]
--------------------------------------------------------------------------
function bugnet_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "swap_bugnet")
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
    
    local skin_data = GetSkinData(inst:GetSkinName())
    inst.overridebugnetsound = skin_data.skin_sound
end
function bugnet_clear_fn(inst)
    inst.AnimState:SetBuild("swap_bugnet")
    inst.components.inventoryitem:ChangeImageName()
    inst.overridebugnetsound = nil
end

--------------------------------------------------------------------------
--[[ Crockpot skin functions ]]
--------------------------------------------------------------------------
function cookpot_init_fn(inst, build_name)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end
    inst.AnimState:SetSkin(build_name, "cook_pot")
end
function cookpot_clear_fn(inst, build_name)
    inst.AnimState:SetBuild("cook_pot")
end

function portablecookpot_item_init_fn(inst, build_name)
    inst.linked_skinname = string.gsub(build_name, "cookpot", "portablecookpot")
    inst.AnimState:SetSkin(build_name, "portable_cook_pot") --same hack is used here by the deployable code in player controller
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
end
function portablecookpot_item_clear_fn(inst, build_name)
    inst.linked_skinname = nil
    inst.AnimState:SetBuild("portable_cook_pot")
end
function portablecookpot_init_fn(inst, build_name)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end
    inst.linked_skinname = string.gsub(build_name, "cookpot", "portablecookpot") .. "_item"
    inst.AnimState:SetSkin(build_name, "portable_cook_pot")
end
function portablecookpot_clear_fn(inst, build_name)
    inst.linked_skinname = nil
    inst.AnimState:SetBuild("portable_cook_pot")
end


--------------------------------------------------------------------------
--[[ Firesuppressor skin functions ]]
--------------------------------------------------------------------------
function firesuppressor_init_fn(inst, build_name)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end

    if inst.prefab == "firesuppressor_placer" then
        for _, v in pairs(inst.components.placer.linked) do
            v.AnimState:SetSkin(build_name, "firefighter")
        end
    else
        inst.AnimState:SetSkin(build_name, "firefighter")
        if inst._fuellevel ~= nil then
            inst.AnimState:OverrideItemSkinSymbol("swap_meter", build_name, tostring(inst._fuellevel), inst.GUID, "firefighter_meter")
        else
            inst.AnimState:OverrideItemSkinSymbol("swap_meter", build_name, "10", inst.GUID, "firefighter_meter")
        end
    end
end
function firesuppressor_clear_fn(inst)
    inst.AnimState:SetBuild("firefighter")
    inst.AnimState:ClearOverrideSymbol("swap_meter")

    if inst._fuellevel ~= nil then
        inst.AnimState:OverrideSymbol("swap_meter", "firefighter_meter", tostring(inst._fuellevel))
    end
end

--------------------------------------------------------------------------
--[[ Firepit skin functions ]]
--------------------------------------------------------------------------
function firepit_init_fn(inst, build_name, fxoffset)
    if inst.components.placer ~= nil then
        --Placers can run this on clients as well as servers
        inst.AnimState:SetSkin(build_name, "firepit")
        return
    elseif not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "firepit")
    inst.components.burnable:SetFXOffset(fxoffset)

    local skin_fx = SKIN_FX_PREFAB[build_name]
    if skin_fx ~= nil and skin_fx[1] ~= nil then
        inst._takefuel_fn = function(inst, data)
            local fuelvalue = data ~= nil and data.fuelvalue or 0
            if fuelvalue > 0 then
                local fx = SpawnPrefab(skin_fx[1])
                fx.entity:SetParent(inst.entity)
                fx.level:set(
                    (fuelvalue >= TUNING.LARGE_FUEL and 3) or
                    (fuelvalue >= TUNING.MED_FUEL and 2) or
                    1
                )
            end
        end
        inst:ListenForEvent("takefuel", inst._takefuel_fn)
    end
    
    if inst.restart_firepit ~= nil then
        inst:restart_firepit() --restart any fire after getting skinned to reposition
    end
end
function firepit_clear_fn(inst)
    inst.AnimState:SetBuild("firepit")
    inst.components.burnable.fxoffset = nil
    if inst._takefuel_fn ~= nil then
        inst:RemoveEventCallback("takefuel", inst._takefuel_fn )
        inst._takefuel_fn = nil
    end

    if inst.restart_firepit ~= nil then
        inst:restart_firepit() --restart any fire after getting cleared of a skin to reposition
    end
end

--------------------------------------------------------------------------
--[[ Campfire skin functions ]]
--------------------------------------------------------------------------
function campfire_init_fn(inst, build_name, fxoffset)
    if inst.components.placer ~= nil then
        --Placers can run this on clients as well as servers
        inst.AnimState:SetSkin(build_name, "campfire")
        return
    elseif not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "campfire")
    if inst.components.burnable.fxchildren[1] ~= nil then
        inst.components.burnable.fxchildren[1].Transform:SetPosition(fxoffset.x, fxoffset.y, fxoffset.z)
    end
end
function campfire_clear_fn(inst)
    inst.AnimState:SetBuild("campfire")
    if inst.components.burnable.fxchildren[1] ~= nil then
        inst.components.burnable.fxchildren[1].Transform:SetPosition(0, 0, 0)
    end
end


--------------------------------------------------------------------------
--[[ Endothermic Firepit skin functions ]]
--------------------------------------------------------------------------
function coldfirepit_init_fn(inst, build_name, fxoffset)
    if inst.components.placer ~= nil then
        --Placers can run this on clients as well as servers
        inst.AnimState:SetSkin(build_name, "coldfirepit")
        return
    elseif not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "coldfirepit")
    inst.components.burnable:SetFXOffset(fxoffset)

    if inst.restart_firepit ~= nil then
        inst:restart_firepit() --restart any fire after getting skinned to reposition
    end
end
function coldfirepit_clear_fn(inst)
    inst.AnimState:SetBuild("coldfirepit")
    inst.components.burnable.fxoffset = nil

    if inst.restart_firepit ~= nil then
        inst:restart_firepit() --restart any fire after getting cleared of a skin to reposition
    end
end


--------------------------------------------------------------------------
--[[ Pet skin functions ]]
--------------------------------------------------------------------------
function critter_builder_init_fn(inst, build_name)
    inst.linked_skinname = build_name --hack that relies on the build name to match the linked skinname
end

function pet_init_fn(inst, build_name, default_build)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, default_build)
end

function perdling_init_fn(inst, build_name, default_build, hungry_sound)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, default_build)
    inst.skin_hungry_sound = hungry_sound
end

function glomling_init_fn(inst, build_name, default_build, skin_sound)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, default_build)
    inst.skin_sound = skin_sound   
end


function critter_dragonling_clear_fn(inst)
    inst.AnimState:SetBuild("dragonling_build")
end
function critter_dragonling_builder_clear_fn(inst)
    inst.linked_skinname = nil
end

function critter_glomling_clear_fn(inst)
    inst.AnimState:SetBuild("glomling_build")
    inst.skin_sound = nil
end
function critter_glomling_builder_clear_fn(inst)
    inst.linked_skinname = nil
end

function critter_kitten_clear_fn(inst)
    inst.AnimState:SetBuild("kittington_build")
end
function critter_kitten_builder_clear_fn(inst)
    inst.linked_skinname = nil
end

function critter_lamb_clear_fn(inst)
    inst.AnimState:SetBuild("sheepington_build")
end
function critter_lamb_builder_clear_fn(inst)
    inst.linked_skinname = nil
end

function critter_perdling_clear_fn(inst)
    inst.AnimState:SetBuild("perdling_build")
    inst.skin_hungry_sound = nil
end
function critter_perdling_builder_clear_fn(inst)
    inst.linked_skinname = nil
end

function critter_puppy_clear_fn(inst)
    inst.AnimState:SetBuild("pupington_build")
end
function critter_puppy_builder_clear_fn(inst)
    inst.linked_skinname = nil
end


--------------------------------------------------------------------------
--[[ Mini Sign skin functions ]]
--------------------------------------------------------------------------
function minisign_item_init_fn(inst, build_name)
    inst.linked_skinname = build_name --hack that relies on the build name to match the linked skinname
    inst.AnimState:SetSkin(build_name, "sign_mini") --same hack is used here by the deployable code in player controller
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
end
function minisign_item_clear_fn(inst)
    inst.linked_skinname = nil
    inst.AnimState:SetBuild("sign_mini")
    inst.components.inventoryitem:ChangeImageName()
end
function minisign_drawn_init_fn(inst, build_name)
    inst.linked_skinname = build_name --hack that relies on the build name to match the linked skinname
    inst.AnimState:SetSkin(build_name, "sign_mini") --same hack is used here by the deployable code in player controller
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
end
function minisign_drawn_clear_fn(inst)
    inst.linked_skinname = nil
    inst.AnimState:SetBuild("sign_mini")
    inst.components.inventoryitem:ChangeImageName()
end
function minisign_init_fn(inst, build_name)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end
    inst.AnimState:SetSkin(build_name, "sign_mini")
    inst.linked_skinname = build_name.."_item" --hack that relies on the build name to match the linked skinname, plus addition for the _item
    inst.linked_skinname_drawn = build_name.."_drawn" --hack that relies on the build name to match the linked skinname, plus addition for the _item
end
function minisign_clear_fn(inst)
    inst.linked_skinname = nil
    inst.linked_skinname_drawn = nil
    inst.AnimState:SetBuild("sign_mini")
end

--------------------------------------------------------------------------
--[[ Fence skin functions ]]
--------------------------------------------------------------------------
function fence_item_init_fn(inst, build_name)
    inst.linked_skinname = build_name --hack that relies on the build name to match the linked skinname
    inst.AnimState:SetSkin(build_name, "fence") --same hack is used here by the deployable code in player controller
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
end
function fence_item_clear_fn(inst)
    inst.linked_skinname = nil
    inst.AnimState:SetBuild("fence")
    inst.components.inventoryitem:ChangeImageName()
end
function fence_init_fn(inst, build_name)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end
    inst.AnimState:SetSkin(build_name, "fence")
end
function fence_clear_fn(inst)
    inst.AnimState:SetBuild("fence")
end

--------------------------------------------------------------------------
--[[ Fence gate skin functions ]]
--------------------------------------------------------------------------
function fence_gate_item_init_fn(inst, build_name)
    inst.linked_skinname = build_name --hack that relies on the build name to match the linked skinname
    inst.AnimState:SetSkin(build_name, "fence_gate") --same hack is used here by the deployable code in player controller
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
end
function fence_gate_item_clear_fn(inst)
    inst.linked_skinname = nil
    inst.AnimState:SetBuild("fence_gate")
    inst.components.inventoryitem:ChangeImageName()
end
function fence_gate_init_fn(inst, build_name)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end
    inst.dooranim.skin_id = inst.skin_id
    inst.dooranim.AnimState:SetSkin(build_name, "fence_gate")
end
function fence_gate_clear_fn(inst)
    inst.dooranim.skin_id = nil
    inst.dooranim.AnimState:SetBuild("fence_gate")
end



--------------------------------------------------------------------------
--[[ Mast skin functions ]]
--------------------------------------------------------------------------
function mast_item_init_fn(inst, build_name)
    inst.linked_skinname = build_name --hack that relies on the build name to match the linked skinname
    inst.AnimState:SetSkin(build_name, "seafarer_mast") --same hack is used here by the deployable code in player controller
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
end
function mast_init_fn(inst, build_name)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end
    inst.AnimState:SetSkin(build_name, "boat_mast2")
    inst.components.inventoryitem:ChangeImageName()
end
function mast_item_clear_fn(inst, build_name)
    inst.linked_skinname = nil
    inst.AnimState:SetBuild("seafarer_mast")
end
function mast_init_fn(inst, build_name)
    if inst.components.placer == nil and not TheWorld.ismastersim then
        return
    end
    inst.AnimState:SetSkin(build_name, "boat_mast2")
end
function mast_clear_fn(inst, build_name)
    inst.AnimState:SetBuild("boat_mast2")
end


--------------------------------------------------------------------------
--[[ Bernie skin functions ]]
--------------------------------------------------------------------------
function bernie_inactive_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end
    inst.AnimState:SetSkin(build_name, "bernie_build")
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
end
function bernie_inactive_clear_fn(inst)
    inst.AnimState:SetBuild("bernie_build")
    inst.components.inventoryitem:ChangeImageName()
end

function bernie_active_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end
    inst.AnimState:SetSkin(build_name, "bernie_build")
end
function bernie_active_clear_fn(inst)
    inst.AnimState:SetBuild("bernie_build")
end

function bernie_big_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end
    inst.AnimState:SetSkin(build_name, "bernie_build")
end
function bernie_big_clear_fn(inst)
    inst.AnimState:SetBuild("bernie_build")
end

--------------------------------------------------------------------------
--[[ ResearchLab4 skin functions ]]
--------------------------------------------------------------------------
function researchlab4_init_fn(inst, build_name)
    if inst.components.placer ~= nil then
        --Placers can run this on clients as well as servers
        inst.AnimState:OverrideItemSkinSymbol("machine_hat", build_name, "machine_hat", inst.GUID, "researchlab4")
        return
    elseif not TheWorld.ismastersim then
        return
    end

    inst.AnimState:OverrideItemSkinSymbol("machine_hat", build_name, "machine_hat", inst.GUID, "researchlab4")
end
function researchlab4_clear_fn(inst)
    inst.AnimState:ClearOverrideSymbol("machine_hat")
end


--------------------------------------------------------------------------
--[[ Reviver skin functions ]]
--------------------------------------------------------------------------
local function reviver_playbeatanimation(inst)
    inst.AnimState:PlayAnimation("idle")
    inst.highlightchildren[1].AnimState:PlayAnimation("idle")
end

function reviver_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "bloodpump")
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())

    local skin_fx = SKIN_FX_PREFAB[build_name]
    if skin_fx ~= nil then
        inst.reviver_beat_fx = skin_fx[1]

        if skin_fx[2] ~= nil then
            local fx = SpawnPrefab(skin_fx[2])
            fx.entity:SetParent(inst.entity)
            fx.AnimState:OverrideItemSkinSymbol("bloodpump01", build_name, "bloodpumpglow", inst.GUID, "bloodpump")
            inst.highlightchildren = { fx }
            inst.PlayBeatAnimation = reviver_playbeatanimation
        end
    end
    
    inst:skin_switched()
end
function reviver_clear_fn(inst)
    inst.AnimState:SetBuild("bloodpump")
    inst.components.inventoryitem:ChangeImageName()

    inst.reviver_beat_fx = nil
    for _,v in pairs( inst.highlightchildren ) do
        v:Remove()
    end
    inst.PlayBeatAnimation = inst.DefaultPlayBeatAnimation
    inst.highlightchildren = nil

    inst:skin_switched()
end

--------------------------------------------------------------------------
--[[ Cane skin functions ]]
--------------------------------------------------------------------------
local TRAIL_FLAGS = { "shadowtrail" }
local function cane_do_trail(inst)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    if not owner.entity:IsVisible() then
        return
    end

    local x, y, z = owner.Transform:GetWorldPosition()
    if owner.sg ~= nil and owner.sg:HasStateTag("moving") then
        local theta = -owner.Transform:GetRotation() * DEGREES
        local speed = owner.components.locomotor:GetRunSpeed() * .1
        x = x + speed * math.cos(theta)
        z = z + speed * math.sin(theta)
    end
    local mounted = owner.components.rider ~= nil and owner.components.rider:IsRiding()
    local map = TheWorld.Map
    local offset = FindValidPositionByFan(
        math.random() * 2 * PI,
        (mounted and 1 or .5) + math.random() * .5,
        4,
        function(offset)
            local pt = Vector3(x + offset.x, 0, z + offset.z)
            return map:IsPassableAtPoint(pt:Get())
                and not map:IsPointNearHole(pt)
                and #TheSim:FindEntities(pt.x, 0, pt.z, .7, TRAIL_FLAGS) <= 0
        end
    )

    if offset ~= nil then
        SpawnPrefab(inst.trail_fx).Transform:SetPosition(x + offset.x, 0, z + offset.z)
    end
end

local function cane_equipped(inst, data)
    if inst.vfx_fx ~= nil then
        if inst._vfx_fx_inst == nil then
            inst._vfx_fx_inst = SpawnPrefab(inst.vfx_fx)
            inst._vfx_fx_inst.entity:AddFollower()
        end
        inst._vfx_fx_inst.entity:SetParent(data.owner.entity)
        inst._vfx_fx_inst.Follower:FollowSymbol(data.owner.GUID, "swap_object", 0, inst.vfx_fx_offset or 0, 0)
    end
    if inst.trail_fx ~= nil and inst._trailtask == nil then
        inst._trailtask = inst:DoPeriodicTask(6 * FRAMES, cane_do_trail, 2 * FRAMES)
    end
end

local function cane_unequipped(inst, owner)
    if inst._vfx_fx_inst ~= nil then
        inst._vfx_fx_inst:Remove()
        inst._vfx_fx_inst = nil
    end
    if inst._trailtask ~= nil then
        inst._trailtask:Cancel()
        inst._trailtask = nil
    end
end

function cane_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "swap_cane")
    inst.AnimState:OverrideSymbol("grass", "swap_cane", "grass")
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())

    local skin_fx = SKIN_FX_PREFAB[build_name] --build_name is prefab name for canes
    if skin_fx ~= nil then
        inst.vfx_fx = skin_fx[1] ~= nil and skin_fx[1]:len() > 0 and skin_fx[1] or nil
        inst.trail_fx = skin_fx[2]
        if inst.vfx_fx ~= nil or inst.trail_fx ~= nil then
            inst:ListenForEvent("equipped", cane_equipped)
            inst:ListenForEvent("unequipped", cane_unequipped)
            if inst.vfx_fx ~= nil then
                inst.vfx_fx_offset = -105
                inst:ListenForEvent("onremove", cane_unequipped)
            end
        end
    end
end
function cane_clear_fn(inst)
    inst.AnimState:SetBuild("swap_cane")
    inst.AnimState:ClearOverrideSymbol("grass")
    inst.components.inventoryitem:ChangeImageName()

    inst:RemoveEventCallback("equipped", cane_equipped)
    inst:RemoveEventCallback("unequipped", cane_unequipped)
    inst:RemoveEventCallback("onremove", cane_unequipped)
end


local function nightsword_equipped(inst, data)
    if inst.vfx_fx ~= nil then
        if inst._vfx_fx_inst == nil then
            inst._vfx_fx_inst = SpawnPrefab(inst.vfx_fx)
            inst._vfx_fx_inst.entity:AddFollower()
        end
        inst._vfx_fx_inst.entity:SetParent(data.owner.entity)
        inst._vfx_fx_inst.Follower:FollowSymbol(data.owner.GUID, "swap_object", 0, -100, 0)
    end
end

local function nightsword_unequipped(inst, owner)
    if inst._vfx_fx_inst ~= nil then
        inst._vfx_fx_inst:Remove()
        inst._vfx_fx_inst = nil
    end
end

function nightsword_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "nightmaresword")
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())

    local skin_fx = SKIN_FX_PREFAB[build_name] --build_name is prefab name for nightsword
    if skin_fx ~= nil then
        inst.vfx_fx = skin_fx[1] ~= nil and skin_fx[1]:len() > 0 and skin_fx[1] or nil
        if inst.vfx_fx ~= nil then
            inst:ListenForEvent("equipped", nightsword_equipped)
            inst:ListenForEvent("unequipped", nightsword_unequipped)
            inst:ListenForEvent("onremove", nightsword_unequipped)
        end
    end
end
function nightsword_clear_fn(inst)
    inst.AnimState:SetBuild("nightmaresword")
    inst.components.inventoryitem:ChangeImageName()
    
    inst:RemoveEventCallback("equipped", nightsword_equipped)
    inst:RemoveEventCallback("unequipped", nightsword_unequipped)
    inst:RemoveEventCallback("onremove", nightsword_unequipped)
end
--------------------------------------------------------------------------
--[[ Staff skin functions ]]
--------------------------------------------------------------------------
local function staff_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "staffs")
    inst.AnimState:OverrideSymbol("grass", "staffs", "grass")
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName())
end
local function staff_clear_fn(inst)
    inst.AnimState:SetBuild("staffs")
    inst.AnimState:ClearOverrideSymbol("grass")
    inst.components.inventoryitem:ChangeImageName()
end

function orangestaff_init_fn(inst, build_name)
    staff_init_fn(inst, build_name)

    if not TheWorld.ismastersim then
        return
    end

    local skin_fx = SKIN_FX_PREFAB[build_name] --build_name is prefab name for orangestaff
    if skin_fx ~= nil then
        inst.vfx_fx = skin_fx[1] ~= nil and skin_fx[1]:len() > 0 and skin_fx[1] or nil
        inst.trail_fx = skin_fx[2] ~= nil and skin_fx[2]:len() > 0 and skin_fx[2] or nil
        if inst.vfx_fx ~= nil or inst.trail_fx ~= nil then
            inst:ListenForEvent("equipped", cane_equipped)
            inst:ListenForEvent("unequipped", cane_unequipped)
            if inst.vfx_fx ~= nil then
                inst.vfx_fx_offset = -120
                inst:ListenForEvent("onremove", cane_unequipped)
            end
        end

        if skin_fx[3] ~= nil then
            inst.components.blinkstaff:SetFX(skin_fx[3], skin_fx[4])
        end
    end
end
function orangestaff_clear_fn(inst)
    staff_clear_fn(inst)

    inst:RemoveEventCallback("equipped", cane_equipped)
    inst:RemoveEventCallback("unequipped", cane_unequipped)
    inst:RemoveEventCallback("onremove", cane_unequipped)

    inst.components.blinkstaff:SetFX(nil, nil)
end

function yellowstaff_init_fn(inst, build_name)
    staff_init_fn(inst, build_name)

    local skin_data = GetSkinData( build_name ) --build_name is skin name for yellowstaff
    inst.morph_skin = skin_data.granted_items[1]
end
function yellowstaff_clear_fn(inst)
    staff_clear_fn(inst)
    inst.morph_skin = nil
end

opalstaff_init_fn = staff_init_fn
opalstaff_clear_fn = staff_clear_fn
firestaff_init_fn = staff_init_fn
firestaff_clear_fn = staff_clear_fn
icestaff_init_fn = staff_init_fn
icestaff_clear_fn = staff_clear_fn
greenstaff_init_fn = staff_init_fn
greenstaff_clear_fn = staff_clear_fn


--------------------------------------------------------------------------
--[[ Thermal Stone skin functions ]]
--------------------------------------------------------------------------
function heatrock_init_fn(inst, build_name)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "heat_rock")
    inst.components.inventoryitem:ChangeImageName(inst:GetSkinName()..tostring(inst.currentTempRange))
end
function heatrock_clear_fn(inst)
    inst.AnimState:SetBuild("heat_rock")
    inst.components.inventoryitem:ChangeImageName("heat_rock"..tostring(inst.currentTempRange))
end


--------------------------------------------------------------------------
--[[ Lantern skin functions ]]
--------------------------------------------------------------------------
local function lantern_onremovefx(fx)
    fx._lantern._lit_fx_inst = nil
end

local function lantern_enterlimbo(inst)
    --V2C: wow! superhacks!
    --     we want to drop the FX behind when the item is picked up, but the transform
    --     is cleared before lantern_off is reached, so we need to figure out where we
    --     were just before.
    if inst._lit_fx_inst ~= nil then
        inst._lit_fx_inst._lastpos = inst._lit_fx_inst:GetPosition()
        local parent = inst.entity:GetParent()
        if parent ~= nil then
            local x, y, z = parent.Transform:GetWorldPosition()
            local angle = (360 - parent.Transform:GetRotation()) * DEGREES
            local dx = inst._lit_fx_inst._lastpos.x - x
            local dz = inst._lit_fx_inst._lastpos.z - z
            local sinangle, cosangle = math.sin(angle), math.cos(angle)
            inst._lit_fx_inst._lastpos.x = dx * cosangle + dz * sinangle
            inst._lit_fx_inst._lastpos.y = inst._lit_fx_inst._lastpos.y - y
            inst._lit_fx_inst._lastpos.z = dz * cosangle - dx * sinangle
        end
    end
end

local function lantern_off(inst)
    local fx = inst._lit_fx_inst
    if fx ~= nil then
        if fx.KillFX ~= nil then
            inst._lit_fx_inst = nil
            inst:RemoveEventCallback("onremove", lantern_onremovefx, fx)
            fx:RemoveEventCallback("enterlimbo", lantern_enterlimbo, inst)
            fx._lastpos = fx._lastpos or fx:GetPosition()
            fx.entity:SetParent(nil)
            if fx.Follower ~= nil then
                fx.Follower:FollowSymbol(0, "", 0, 0, 0)
            end
            fx.Transform:SetPosition(fx._lastpos:Get())
            fx:KillFX()
        else
            fx:Remove()
        end
    end
end

local function lantern_on(inst)
    local owner = inst.components.inventoryitem.owner
    if owner ~= nil then
        if inst._lit_fx_inst ~= nil and inst._lit_fx_inst.prefab ~= inst._heldfx then
            lantern_off(inst)
        end
        if inst._heldfx ~= nil then
            if inst._lit_fx_inst == nil then
                inst._lit_fx_inst = SpawnPrefab(inst._heldfx)
                inst._lit_fx_inst._lantern = inst
                if inst._overridesymbols ~= nil and inst._lit_fx_inst.AnimState ~= nil then
                    for i, v in ipairs(inst._overridesymbols) do
                        inst._lit_fx_inst.AnimState:OverrideItemSkinSymbol(v, inst:GetSkinBuild(), v, inst.GUID, "lantern")
                    end
                end
                inst._lit_fx_inst.entity:AddFollower()
                inst:ListenForEvent("onremove", lantern_onremovefx, inst._lit_fx_inst)
            end
            inst._lit_fx_inst.entity:SetParent(owner.entity)
            inst._lit_fx_inst.Follower:FollowSymbol(owner.GUID, "swap_object", inst._followoffset ~= nil and inst._followoffset.x or 0, inst._followoffset ~= nil and inst._followoffset.y or 0, inst._followoffset ~= nil and inst._followoffset.z or 0)
        end
    else
        if inst._lit_fx_inst ~= nil and inst._lit_fx_inst.prefab ~= inst._groundfx then
            lantern_off(inst)
        end
        if inst._groundfx ~= nil then
            if inst._lit_fx_inst == nil then
                inst._lit_fx_inst = SpawnPrefab(inst._groundfx)
                inst._lit_fx_inst._lantern = inst
                if inst._overridesymbols ~= nil and inst._lit_fx_inst.AnimState ~= nil then
                    for i, v in ipairs(inst._overridesymbols) do
                        inst._lit_fx_inst.AnimState:OverrideItemSkinSymbol(v, inst:GetSkinBuild(), v, inst.GUID, "lantern")
                    end
                end
                inst:ListenForEvent("onremove", lantern_onremovefx, inst._lit_fx_inst)
                if inst._lit_fx_inst.KillFX ~= nil then
                    inst._lit_fx_inst:ListenForEvent("enterlimbo", lantern_enterlimbo, inst)
                end
            end
            inst._lit_fx_inst.entity:SetParent(inst.entity)
        end
    end
end

function lantern_init_fn(inst, build_name, overridesymbols, followoffset)
    if not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "lantern")

    local skin_fx = SKIN_FX_PREFAB[build_name] --build_name is prefab name for lanterns
    if skin_fx ~= nil then
        inst._heldfx = skin_fx[1]
        inst._groundfx = skin_fx[2]
        if inst._heldfx ~= nil or inst._groundfx ~= nil then
            inst._overridesymbols = overridesymbols
            inst._followoffset = followoffset
            inst:ListenForEvent("lantern_on", lantern_on)
            inst:ListenForEvent("lantern_off", lantern_off)
            inst:ListenForEvent("unequipped", lantern_off)
            inst:ListenForEvent("onremove", lantern_off)
        end
    end

    if inst.components.machine.ison then
        lantern_on(inst)
    end
end

function lantern_clear_fn(inst)
    inst.AnimState:SetBuild("lantern")

    lantern_off(inst)

    inst._heldfx = nil
    inst._groundfx = nil
    inst._overridesymbols = nil
    inst._followoffset = nil

    inst:RemoveEventCallback("lantern_on", lantern_on)
    inst:RemoveEventCallback("lantern_off", lantern_off)
    inst:RemoveEventCallback("unequipped", lantern_off)
    inst:RemoveEventCallback("onremove", lantern_off)
end

--------------------------------------------------------------------------
--[[ ResearchLab2 skin functions ]]
--------------------------------------------------------------------------
local function researchlab2_cancelflash(inst)
    if inst.flashtasks ~= nil then
        for i = 1, #inst.flashtasks do
            table.remove(inst.flashtasks):Cancel()
        end
    end
end

local function researchlab2_applyflash(inst, intensity)
    inst.AnimState:SetLightOverride(intensity * .6)
    if inst.highlightchildren ~= nil then
        inst.highlightchildren[1].AnimState:SetLightOverride(intensity)
    end
end

local function researchlab2_flashupdate(inst, intensity, totalframes)
    inst.flashframe = inst.flashframe + 1
    if inst.flashframe < totalframes then
        local k = inst.flashframe / totalframes
        researchlab2_applyflash(inst, (1 - k * k) * intensity)
    else
        inst.flashfadetask:Cancel()
        inst.flashfadetask = nil
        inst.flashframe = nil
        researchlab2_applyflash(inst, 0)
    end
end

local function researchlab2_flash(inst, intensity, frames)
    if not inst.AnimState:IsCurrentAnimation("proximity_loop") and not inst.AnimState:IsCurrentAnimation("proximity_gift_loop") then
        researchlab2_cancelflash(inst)
        return
    end
    if inst.flashfadetask ~= nil then
        inst.flashfadetask:Cancel()
    end
    inst.flashfadetask = inst:DoPeriodicTask(0, researchlab2_flashupdate, nil, intensity, frames)
    inst.flashframe = -1
    researchlab2_applyflash(inst, intensity * .5)
end

local function researchlab2_checkflashing(inst, anim, offset)
    if inst.checkanimtask ~= nil then
        inst.checkanimtask:Cancel()
        inst.checkanimtask = nil
    end
    researchlab2_cancelflash(inst)
    if anim == "proximity_loop" or anim == "proximity_gift_loop" then
        local period = 49 * FRAMES
        table.insert(inst.flashtasks, inst:DoPeriodicTask(period, researchlab2_flash, 18 * FRAMES, .2, 8))
        table.insert(inst.flashtasks, inst:DoPeriodicTask(period, researchlab2_flash, 24 * FRAMES, .2, 10))
    end
end

local function researchlab2_checkanim(inst)
    if inst.AnimState:IsCurrentAnimation("proximity_loop") or inst.AnimState:IsCurrentAnimation("proximity_gift_loop") then
        inst.checkanimtask = nil
        researchlab2_checkflashing(inst, "proximity_loop", inst.AnimState:GetCurrentAnimationTime())
    else
        inst.checkanimtask = inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() - inst.AnimState:GetCurrentAnimationTime() + FRAMES, researchlab2_checkanim)
    end
end

local function researchlab2_playanimation(inst, anim, loop)
    inst.AnimState:PlayAnimation(anim, loop)
    inst.highlightchildren[1].AnimState:PlayAnimation(anim, loop)
    researchlab2_checkflashing(inst, anim, 0)
end

local function researchlab2_pushanimation(inst, anim, loop)
    local wasplaying = inst.AnimState:IsCurrentAnimation(anim)
    inst.AnimState:PushAnimation(anim, loop)
    inst.highlightchildren[1].AnimState:PushAnimation(anim, loop)
    if not wasplaying and inst.AnimState:IsCurrentAnimation(anim) then
        researchlab2_checkflashing(inst, anim, 0)
    elseif (anim == "proximity_gift_loop" or anim == "proximity_loop") and inst.checkanimtask == nil then
        inst.checkanimtask = inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() - inst.AnimState:GetCurrentAnimationTime() + FRAMES, researchlab2_checkanim)
    end
end

function researchlab2_init_fn(inst, build_name)
    if inst.components.placer ~= nil then
        --Placers can run this on clients as well as servers
        inst.AnimState:SetSkin(build_name, "researchlab2")
        return
    elseif not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "researchlab2")
    inst.AnimState:OverrideSymbol("shadow_plume", "researchlab2", "shadow_plume")
    inst.AnimState:OverrideSymbol("shadow_wisp", "researchlab2", "shadow_wisp")

    local skin_fx = SKIN_FX_PREFAB[build_name]
    if skin_fx ~= nil and skin_fx[1] ~= nil then
        local fx = SpawnPrefab(skin_fx[1])
        fx.entity:SetParent(inst.entity)
        for i = 1, 4 do
            local symbol = "newfx"..tostring(i)
            fx.AnimState:OverrideItemSkinSymbol(symbol, build_name, symbol, inst.GUID, "researchlab2")
        end
        inst.highlightchildren = { fx }
        inst.flashtasks = {}
        inst._PlayAnimation = researchlab2_playanimation
        inst._PushAnimation = researchlab2_pushanimation
    end

    if inst.AnimState:IsCurrentAnimation("proximity_loop") then
        researchlab2_playanimation(inst, "proximity_loop", true)
    end
    if inst.AnimState:IsCurrentAnimation("proximity_gift_loop") then
        researchlab2_playanimation(inst, "proximity_gift_loop", true)
    end
end
function researchlab2_clear_fn(inst)
    inst.AnimState:SetBuild("researchlab2")
    inst.AnimState:ClearOverrideSymbol("shadow_plume")
    inst.AnimState:ClearOverrideSymbol("shadow_wisp")

    for _,v in pairs( inst.highlightchildren ) do
        v:Remove()
    end
    researchlab2_cancelflash(inst)
    inst.flashtasks = nil
    inst._PlayAnimation = Default_PlayAnimation
    inst._PushAnimation = Default_PushAnimation
    inst.highlightchildren = nil
end

--------------------------------------------------------------------------
--[[ Icebox skin functions ]]
--------------------------------------------------------------------------
local function icebox_opened(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    if inst.open_fx ~= nil then
        local t = GetTime()
        if t >= (inst._open_fx_time or 0) then
            inst._open_fx_time = t + 1.3
            SpawnPrefab(inst.open_fx).Transform:SetPosition(x, y, z)
        end
    end
    if inst.frost_fx ~= nil and inst._frostfx == nil then
        inst._frostfx = SpawnPrefab(inst.frost_fx)
        inst._frostfx.Transform:SetPosition(x, y, z)

        --Note(Peter) Set the skin build here instead of overriding specific symbols, but we'd need to assign the id/sig first
        inst._frostfx.AnimState:OverrideItemSkinSymbol("cold_air", inst:GetSkinName(), "cold_air", inst.GUID, "ice_box")
        inst._frostfx.AnimState:OverrideItemSkinSymbol("blink_dot", inst:GetSkinName(), "blink_dot", inst.GUID, "ice_box")
    end
end

local function icebox_closed(inst)
    if inst._frostfx ~= nil then
        inst._frostfx:Kill()
        inst._frostfx = nil
    end
end

function icebox_init_fn(inst, build_name)
    if inst.components.placer ~= nil then
        --Placers can run this on clients as well as servers
        inst.AnimState:SetSkin(build_name, "ice_box")
        return
    elseif not TheWorld.ismastersim then
        return
    end

    inst.AnimState:SetSkin(build_name, "ice_box")

    local skin_fx = SKIN_FX_PREFAB[build_name]
    if skin_fx ~= nil then
        inst.frost_fx = skin_fx[1] ~= nil and skin_fx[1]:len() > 0 and skin_fx[1] or nil
        inst.open_fx = skin_fx[2]
        if inst.frost_fx ~= nil or inst.open_fx ~= nil then
            inst:ListenForEvent("onopen", icebox_opened)
            if inst.frost_fx ~= nil then
                inst:ListenForEvent("onclose", icebox_closed)
                inst:ListenForEvent("onremove", icebox_closed)
            end
        end
    end

    if inst.AnimState:IsCurrentAnimation("open") then
        icebox_opened(inst)
    end
end
function icebox_clear_fn(inst)
    inst.AnimState:SetBuild("ice_box")

    inst:RemoveEventCallback("onopen", icebox_opened)
    inst:RemoveEventCallback("onclose", icebox_closed)
    inst:RemoveEventCallback("onremove", icebox_closed)
    
    icebox_closed(inst)
end


--------------------------------------------------------------------------

function CreatePrefabSkin(name, info)
    local prefab_skin = Prefab(name, nil, info.assets, info.prefabs)
    prefab_skin.is_skin = true

    --Hack to deal with mods with bad data. Type is now required, and who knows how many character mods are missing this field.
    if info.type == nil then
        info.type = "base"
    end


    prefab_skin.base_prefab         = info.base_prefab
    prefab_skin.type                = info.type
    prefab_skin.skin_tags           = info.skin_tags
    prefab_skin.init_fn             = info.init_fn
    prefab_skin.build_name_override = info.build_name_override
    prefab_skin.bigportrait         = info.bigportrait
    prefab_skin.rarity              = info.rarity
    prefab_skin.rarity_modifier     = info.rarity_modifier
    prefab_skin.skins               = info.skins
    prefab_skin.skin_sound          = info.skin_sound
    prefab_skin.is_restricted       = info.is_restricted
    prefab_skin.granted_items       = info.granted_items
	prefab_skin.marketable			= info.marketable
    prefab_skin.release_group       = info.release_group
    prefab_skin.linked_beard        = info.linked_beard

    if info.torso_tuck_builds ~= nil then
        for _,base_skin in pairs(info.torso_tuck_builds) do
            BASE_TORSO_TUCK[base_skin] = "full"
        end
    end

    if info.torso_untuck_builds ~= nil then
        for _,base_skin in pairs(info.torso_untuck_builds) do
            BASE_TORSO_TUCK[base_skin] = "untucked"
        end
    end

    if info.torso_untuck_wide_builds ~= nil then
        for _,base_skin in pairs(info.torso_untuck_wide_builds) do
            BASE_TORSO_TUCK[base_skin] = "untucked_wide"
        end
    end

    if info.has_alternate_for_body ~= nil then
        for _,base_skin in pairs(info.has_alternate_for_body) do
            BASE_ALTERNATE_FOR_BODY[base_skin] = true
        end
    end

    if info.has_alternate_for_skirt ~= nil then
        for _,base_skin in pairs(info.has_alternate_for_skirt) do
            BASE_ALTERNATE_FOR_SKIRT[base_skin] = true
        end
    end

    if info.legs_cuff_size ~= nil then
        for base_skin,size in pairs(info.legs_cuff_size) do
            BASE_LEGS_SIZE[base_skin] = size
        end
    end

    if info.feet_cuff_size ~= nil then
        for base_skin,size in pairs(info.feet_cuff_size) do
            BASE_FEET_SIZE[base_skin] = size
        end
    end

    if info.fx_prefab ~= nil then
        SKIN_FX_PREFAB[name] = info.fx_prefab
    end

    if info.type ~= "base" then
        prefab_skin.clear_fn = _G[prefab_skin.base_prefab.."_clear_fn"]
    end

    return prefab_skin
end
