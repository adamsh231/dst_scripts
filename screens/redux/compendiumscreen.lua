require "util"
require "strings"
require "constants"

local Screen = require "widgets/screen"
local Subscreener = require "screens/redux/subscreener"
local ImageButton = require "widgets/imagebutton"
local Menu = require "widgets/menu"
local Grid = require "widgets/grid"
local Text = require "widgets/text"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local ScrollableList = require "widgets/scrollablelist"
local PopupDialogScreen = require "screens/redux/popupdialog"
local OnlineStatus = require "widgets/onlinestatus"
local MovieDialog = require "screens/moviedialog"


local HistoryOfTravelsPanel = require "screens/redux/panels/historyoftravelspanel"
local CharacterDetailsPanel = require "screens/redux/panels/characterdetailspanel"
local ObituariesPanel = require "screens/redux/panels/obituariespanel"
local EncountersPanel = require "screens/redux/panels/encounterspanel"
local CinematicsPanel = require "screens/redux/panels/cinematicspanel"

local TEMPLATES = require "widgets/redux/templates"

local CompendiumScreen = Class(Screen, function(self, prev_screen)
	Screen._ctor(self, "CompendiumScreen")

    self:AddChild(TEMPLATES.old.ForegroundLetterbox())

	self.root = self:AddChild(TEMPLATES.ScreenRoot("CompendiumScreenRoot"))
    self.bg = self.root:AddChild(TEMPLATES.PlainBackground())	
    self.title = self.root:AddChild(TEMPLATES.ScreenTitle(STRINGS.UI.MAINSCREEN.COMPENDIUM, ""))
    
	self.onlinestatus = self.root:AddChild(OnlineStatus())

	self.cancel_button = self.root:AddChild(TEMPLATES.BackButton(function() self:Close() end))
    if TheInput:ControllerAttached() then
        self.cancel_button:Hide()
	end

    self.panel_root = self.root:AddChild(Widget("panel_root"))
    self.panel_root:SetPosition(155, 0)

	--self.panel_root:AddChild(Image("images/global.xml", "square.tex"))

    local menu_items = {
			historyoftravels = self.panel_root:AddChild(HistoryOfTravelsPanel(self)),
			characterdetails = self.panel_root:AddChild(CharacterDetailsPanel(self)),
            obituaries = self.panel_root:AddChild(ObituariesPanel(self)),
            encounters = self.panel_root:AddChild(EncountersPanel()),
			cinematics = self.panel_root:AddChild(CinematicsPanel(self)),
        }

    self.characterdetails = menu_items.characterdetails --for refreshing

    self.subscreener = Subscreener(self, self._BuildMenu, menu_items )
    self.subscreener:SetPostMenuSelectionAction(function(selection)
        self.selected_tab = selection
    end)


	---------------------------------------------------

    self.subscreener:OnMenuButtonSelected("historyoftravels")

    self:_DoFocusHookups()
	self.default_focus = self.subscreener.menu
end)

function CompendiumScreen:_BuildMenu(subscreener)
    self.tooltip = self.root:AddChild(TEMPLATES.ScreenTooltip())
	
    local menu_items = {
        {widget = subscreener:MenuButton(STRINGS.UI.COMPENDIUM.CINEMATICS, "cinematics", STRINGS.UI.COMPENDIUM.TOOLTIP_CINEMATICS, self.tooltip)},
        {widget = subscreener:MenuButton(STRINGS.UI.COMPENDIUM.OBITUARIES, "obituaries", STRINGS.UI.COMPENDIUM.TOOLTIP_OBITUARIES, self.tooltip)},
        {widget = subscreener:MenuButton(STRINGS.UI.COMPENDIUM.ENCOUNTERS, "encounters", STRINGS.UI.COMPENDIUM.TOOLTIP_ENCOUNTERS, self.tooltip)},
        {widget = subscreener:MenuButton(STRINGS.UI.COMPENDIUM.CHARACTERDETAILS, "characterdetails", STRINGS.UI.COMPENDIUM.TOOLTIP_CHARACTERDETAILS, self.tooltip)},
        {widget = subscreener:MenuButton(STRINGS.UI.COMPENDIUM.HISTORYOFTRAVELS, "historyoftravels", STRINGS.UI.COMPENDIUM.TOOLTIP_HISTORYOFTRAVELS, self.tooltip)},
    }

    return self.root:AddChild(TEMPLATES.StandardMenu(menu_items, 38, nil, nil, true))
end

function CompendiumScreen:OnControl(control, down)
    if CompendiumScreen._base.OnControl(self, control, down) then return true end
    
    if not down then
	    if control == CONTROL_CANCEL then
			self:Close() --go back
			TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
			return true
	    end
	end
end

function CompendiumScreen:Close(fn)
    TheFrontEnd:FadeBack(nil, nil, fn)
end	

function CompendiumScreen:OnBecomeActive()
    CompendiumScreen._base.OnBecomeActive(self)

    self.characterdetails:Refresh()
end

function CompendiumScreen:GetHelpText()
	local t = {}
	local controller_id = TheInput:GetControllerID()

	table.insert(t, TheInput:GetLocalizedControl(controller_id, CONTROL_CANCEL) .. " " .. STRINGS.UI.HELP.BACK)

	return table.concat(t, "  ")
end

function CompendiumScreen:_DoFocusHookups()
--[[
	local function torightcol()
        if self.selected_tab == "settings" then
		    return self.grid
        else
            return self.active_list
        end
	end

    self.grid:SetFocusChangeDir(MOVE_RIGHT, self.action_menu)
    self.controller_controllist:SetFocusChangeDir(MOVE_RIGHT, self.action_menu)
    self.kb_controllist:SetFocusChangeDir(MOVE_RIGHT, self.action_menu)

    self.action_menu:SetFocusChangeDir(MOVE_LEFT, self.subscreener.menu)
    self.action_menu:SetFocusChangeDir(MOVE_UP, torightcol)

    self.cancel_button:SetFocusChangeDir(MOVE_UP, self.subscreener.menu)
]]
end


return CompendiumScreen
