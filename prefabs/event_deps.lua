--[[
Use this file for dependencies that are only required during a specific event.
 - Don't move SPECIAL_EVENT.NONE loading screens in here (from global.lua), in case
   of events that don't have their own loading screens.
 - Don't make special event backend prefabs exclusive to the event, since events
   automatically come and go in regular world save files.
--]]

--------------------------------------------------------------------------
--global, used by loadingwidget.lua
LOADING_IMAGES =
{
    [SPECIAL_EVENTS.HALLOWED_NIGHTS] =
    {
        --{ atlas = "images/bg_spiral_fill_halloween1.xml", tex = "bg_image1.tex" },
        --{ atlas = "images/bg_spiral_fill_halloween2.xml", tex = "bg_image2.tex" },
        --{ atlas = "images/bg_spiral_fill_halloween3.xml", tex = "bg_image3.tex" },
        { atlas = "images/bg_spiral_fill_halloween4.xml", tex = "bg_image4.tex" },
        { atlas = "images/bg_spiral_fill_halloween5.xml", tex = "bg_image5.tex" },
    },

    [SPECIAL_EVENTS.WINTERS_FEAST] =
    {
        { atlas = "images/bg_spiral_fill_christmas1.xml", tex = "bg_image1.tex" },
        { atlas = "images/bg_spiral_fill_christmas2.xml", tex = "bg_image2.tex" },
        { atlas = "images/bg_loading_winters_feast.xml", tex = "bg_image1.tex" },
    },

    [SPECIAL_EVENTS.YOTG] =
    {
        { atlas = "images/bg_spiral_fill_yotg1.xml", tex = "bg_image1.tex" },
        { atlas = "images/bg_spiral_fill_yotg2.xml", tex = "bg_image2.tex" },
    },

    [SPECIAL_EVENTS.YOTV] =
    {
        { atlas = "images/bg_loading_yotv1.xml", tex = "bg_image1.tex" },
    },

    [SPECIAL_EVENTS.YOTC] =
    {
        { atlas = "images/bg_loading_yotc.xml", tex = "bg_image1.tex" },
    },

    [SPECIAL_EVENTS.NONE] =
    {
        { atlas = "images/bg_spiral_fill1.xml", tex = "bg_image1.tex", spiral = true },
        { atlas = "images/bg_spiral_fill2.xml", tex = "bg_image2.tex", spiral = true },
        { atlas = "images/bg_spiral_fill3.xml", tex = "bg_image3.tex", spiral = true },
        { atlas = "images/bg_spiral_fill4.xml", tex = "bg_image4.tex", spiral = true },
        { atlas = "images/bg_spiral_fill5.xml", tex = "bg_image5.tex", spiral = true },
        { atlas = "images/bg_spiral_fill6.xml", tex = "bg_image6.tex", spiral = true },
        { atlas = "images/bg_spiral_fill7.xml", tex = "bg_image7.tex", spiral = true },
        { atlas = "images/bg_spiral_fill8.xml", tex = "bg_image8.tex", spiral = true },
    },
}

--------------------------------------------------------------------------
local SPECIAL_EVENT_DEPS =
{
    [SPECIAL_EVENTS.HALLOWED_NIGHTS] =
    {
        frontend =
        {
            assets =
            {
                Asset("PKGREF", "anim/dst_menu_halloween.zip"),
                Asset("PKGREF", "anim/dst_menu_wurt.zip"),  
            },
        },
        backend =
        {
            assets =
            {
                Asset("ANIM", "anim/player_spooked.zip"),
            },
            prefabs =
            {
                "battreefx",
            },
        },
    },

    [SPECIAL_EVENTS.WINTERS_FEAST] =
    {
        frontend =
        {
            assets =
            {
                Asset("PKGREF", "anim/dst_menu_feast.zip"),
                Asset("PKGREF", "anim/dst_menu_feast_bg.zip"),
                Asset("PKGREF", "sound/music_frontend_winters_feast.fsb"),
                Asset("ANIM", "anim/dst_menu_inker_winter.zip"),  
            },
        },
    },

    [SPECIAL_EVENTS.YOTG] =
    {
        frontend =
        {
            assets =
            {
                Asset("DYNAMIC_ANIM", "anim/dynamic/frontend_perd.zip"),
                Asset("PKGREF", "anim/dynamic/frontend_perd.dyn"),
                Asset("PKGREF", "sound/music_frontend_yotg.fsb"),
            },
        },
    },

    [SPECIAL_EVENTS.YOTV] =
    {
        frontend =
        {
            assets =
            {
                Asset("ANIM", "anim/dst_menu_yotv.zip"),
                Asset("PKGREF", "sound/music_frontend_yotg.fsb"),
            },
        },
    },

    [SPECIAL_EVENTS.YOTP] =
    {
        frontend =
        {
            assets =
            {
                Asset("ANIM", "anim/dst_menu_pig_bg.zip"),
                Asset("ANIM", "anim/dst_menu_pigs.zip"),
                Asset("PKGREF", "sound/music_frontend_yotg.fsb"),
            },
        },
        backend =
        {
            assets =
            {
                Asset("ANIM", "anim/pig_king_elite_build.zip"),
            },
        },
    },

    [SPECIAL_EVENTS.YOTC] =
    {
        frontend =
        {
            assets =
            {
                Asset("ANIM", "anim/dst_menu_carrat_bg.zip"),
                Asset("ANIM", "anim/dst_menu_carrat.zip"),
                Asset("ANIM", "anim/dst_menu_carrat_swaps.zip"),
                Asset("SOUND", "sound/music_frontend_yotc.fsb"),
            },
        },
    },

    [SPECIAL_EVENTS.NONE] =
    {
        frontend =
        {
            assets =
            {
                Asset("PKGREF", "anim/dst_menu.zip"),
                Asset("PKGREF", "anim/dst_menu_winona.zip"),
                Asset("PKGREF", "anim/dst_menu_wortox.zip"),
                Asset("PKGREF", "anim/dst_menu_willow.zip"),
                Asset("PKGREF", "anim/dst_menu_wormwood.zip"),
                Asset("PKGREF", "anim/dst_menu_warly.zip"),
                Asset("PKGREF", "anim/dst_menu_lunacy.zip"),
                Asset("PKGREF", "anim/dst_menu_woodie.zip"),
                Asset("PKGREF", "anim/dst_menu_rot2.zip"),
                Asset("PKGREF", "anim/dst_menu_inker.zip"),
                Asset("PKGREF", "anim/dst_menu_wendy.zip"),
                Asset("PKGREF", "anim/dst_menu_wes.zip"),
                Asset("PKGREF", "anim/dst_menu_shesells.zip"),
                Asset("PKGREF", "anim/dst_menu_v2.zip"),
                Asset("PKGREF", "anim/dst_menu_v2_bg.zip"),
                Asset("ANIM", "anim/dst_menu_walter.zip"),
            },
        },
    },
}

--------------------------------------------------------------------------
local FESTIVAL_EVENT_DEPS =
{
    [FESTIVAL_EVENTS.LAVAARENA] =
    {
        frontend =
        {
            assets =
            {
                Asset("ANIM", "anim/main_menu1.zip"), -- old assets, keeping around for mods
                Asset("ATLAS", "images/bg_redux_labg.xml"),
                Asset("IMAGE", "images/bg_redux_labg.tex"),
				Asset("ANIM", "anim/dst_menu_lavaarena_s2.zip"),
                Asset("PKGREF", "sound/lava_arena.fsb"),
                Asset("ATLAS", "images/lavaarena_frontend.xml"),
                Asset("IMAGE", "images/lavaarena_frontend.tex"),
            },
        },
    },
    [FESTIVAL_EVENTS.QUAGMIRE] =
    {
        frontend =
        {
            assets =
            {
                Asset("ATLAS", "images/quagmire_frontend.xml"),
                Asset("IMAGE", "images/quagmire_frontend.tex"),
                Asset("ANIM", "anim/quagmire_menu.zip"),
                Asset("ANIM", "anim/quagmire_menu_mid.zip"),
                Asset("ANIM", "anim/quagmire_menu_bg.zip"),
                Asset("PKGREF", "sound/quagmire.fsb"),
            },
        },
    },
}

--------------------------------------------------------------------------
--we don't actually instantiate this prefab. It's used for controlling asset loading
local function fn()
    return CreateEntity()
end

local ret = {}
local function AddLoadingAssets(deps, special_event)
    if deps.global == nil then
        deps.global = { assets = {} }
    elseif deps.global.assets == nil then
        deps.global.assets = {}
    end
    local spiral = false
    for i, v in ipairs(LOADING_IMAGES[special_event] or LOADING_IMAGES[SPECIAL_EVENTS.NONE]) do
        assert(v.atlas:sub(-4) == ".xml")
        table.insert(deps.global.assets, Asset("DYNAMIC_ATLAS", v.atlas))
        table.insert(deps.global.assets, Asset("PKGREF", v.atlas:sub(1, -4).."tex"))
    end
end
local function AddDependencyPrefab(name, env)
    table.insert(ret, Prefab(name, fn, env.assets, env.prefabs))
end
for k, v in pairs(SPECIAL_EVENTS) do
    local deps = SPECIAL_EVENT_DEPS[v] or {}
    AddLoadingAssets(deps, v)
    AddDependencyPrefab(v.."_event_global", deps.global or {})
    AddDependencyPrefab(v.."_event_frontend", deps.frontend or {})
    AddDependencyPrefab(v.."_event_backend", deps.backend or {})
end
for k, v in pairs(FESTIVAL_EVENTS) do
    local deps = FESTIVAL_EVENT_DEPS[v] or {}
    AddDependencyPrefab(v.."_fest_global", deps.global or {})
    AddDependencyPrefab(v.."_fest_frontend", deps.frontend or {})
    AddDependencyPrefab(v.."_fest_backend", deps.backend or {})
end
return unpack(ret)
