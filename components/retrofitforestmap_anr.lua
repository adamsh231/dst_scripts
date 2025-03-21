

--------------------------------------------------------------------------
--[[ RetrofitForestMap_ANR class definition ]]
--------------------------------------------------------------------------

return Class(function(self, inst)

assert(TheWorld.ismastersim, "RetrofitForestMapA_NR should not exist on client")

--------------------------------------------------------------------------
--[[ Dependencies ]]
--------------------------------------------------------------------------

--------------------------------------------------------------------------
--[[ Constants ]]
--------------------------------------------------------------------------

local MAX_PLACEMENT_ATTEMPTS = 50

--------------------------------------------------------------------------
--[[ Member variables ]]
--------------------------------------------------------------------------

--Public
self.inst = inst

--Private
local retrofit_part1 = false


local STRUCTURE_TAGS = {"structure"} 
local WALKABLEPLATFORM_TAGS = {"walkableplatform"}
local LAVA_TAGS = {"lava"}
local IMPORTANT_OBJECT_TAGS = {"irreplaceable", "playerghost", "ghost", "flying", "player", "character", "animal", "monster", "giant"}
local WATERSOURCE_TAGS = {"watersource"}
local THORNY_TAGS = {"thorny"}
local SCULPTURE_TAGS = {"sculpture"}

--------------------------------------------------------------------------
--[[ Private member functions ]]
--------------------------------------------------------------------------

local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local function RetrofitNewContentPrefab(inst, prefab, min_space, dist_from_structures, canplacefn)
	local attempt = 1
	local topology = TheWorld.topology

	while attempt <= MAX_PLACEMENT_ATTEMPTS do
		local area =  topology.nodes[math.random(#topology.nodes)]

		local points_x, points_y = TheWorld.Map:GetRandomPointsForSite(area.x, area.y, area.poly, 1)
		if #points_x == 1 and #points_y == 1 then
			local x = points_x[1]
			local z = points_y[1]

			if (canplacefn ~= nil and canplacefn(x, 0, z, prefab)) or
                (canplacefn == nil and TheWorld.Map:CanPlacePrefabFilteredAtPoint(x, 0, z, prefab)) then
				local ents = TheSim:FindEntities(x, 0, z, min_space)
				if #ents == 0 then
					if dist_from_structures ~= nil then
						ents = TheSim:FindEntities(x, 0, z, dist_from_structures, STRUCTURE_TAGS )
					end
					
					if #ents == 0 then
						local e = SpawnPrefab(prefab)
						e.Transform:SetPosition(x, 0, z)
						break
					end
				end
			end
		end
		attempt = attempt + 1
	end
	print ("Retrofitting world for " .. prefab .. ": " .. (attempt < MAX_PLACEMENT_ATTEMPTS and ("Success after "..attempt.." attempts.") or "Failed."))
end

local function RetrofitNewOceanContentPrefab(inst, width, height, prefab, min_space, dist_from_structures, canplacefn)
	local function dowork()
		local attempt = 1
		local topology = TheWorld.topology
		local world_width, world_width = width * TILE_SCALE, height * TILE_SCALE
		local start_x, start_y = math.random(width), math.random(0, height)
		local edge_dist = 8
		local tile_step = 7

		for zz = 1, height, tile_step do
			local z = ((start_y + zz) % height) + edge_dist
			z = z - (0.5*height) * TILE_SCALE
			for xx = 1, width, tile_step do
				local x = ((start_x + xx) % width) + edge_dist
				x = x - (0.5*width) * TILE_SCALE
				if canplacefn(x, 0, z, prefab) then
					local ents = TheSim:FindEntities(x, 0, z, min_space)
					if #ents == 0 then
						if dist_from_structures ~= nil then
							ents = TheSim:FindEntities(x, 0, z, dist_from_structures, STRUCTURE_TAGS )
						end
					
						if #ents == 0 then
							local e = SpawnPrefab(prefab)
							e.Transform:SetPosition(x, 0, z)
							return attempt
						end
					end
				end
				attempt = attempt + 1
			end
			attempt = attempt + 1
		end

		return nil
	end

	local attempts = dowork()
	print ("Retrofitting ocean for " .. prefab .. ": " .. (attempts ~= nil and ("Success after "..attempts.." attempts.") or "Failed."))
end

local function RemovePrefabs(prefabs_to_remove, biomes_to_cleanup)
	local count = 0
	for _,ent in pairs(Ents) do
		if ent:IsValid() and table.contains(prefabs_to_remove, ent.prefab) and (biomes_to_cleanup == nil or table.contains(biomes_to_cleanup, TheWorld.Map:GetTileAtPoint(ent.Transform:GetWorldPosition()))) then
			count = count + 1
			ent:Remove()
		end
	end

	return count
end

local function populate_ocean(tile_type, contents, width, height, on_spawnfn)
	for y = OCEAN_POPULATION_EDGE_DIST, height - OCEAN_POPULATION_EDGE_DIST - 1, 1 do
		for x = OCEAN_POPULATION_EDGE_DIST, width - OCEAN_POPULATION_EDGE_DIST - 1, 1 do
			if TheWorld.Map:GetTile(x, y) == tile_type then
				if math.random() < contents.distributepercent then
					local prefab = weighted_random_choice(contents.distributeprefabs)
					if prefab ~= nil then
						local obj = SpawnPrefab(prefab)
						obj.Transform:SetPosition((x - width/2.0)*TILE_SCALE + math.random()*2-1, 0, (y - height/2.0)*TILE_SCALE + math.random()*2-1)

						if on_spawnfn ~= nil then
							on_spawnfn(prefab, obj:GetPosition())
						end
					end
				end
			end
		end
	end
end

local function TurnOfTidesRetrofitting_PopulateOcean()
	local pop = {
		OCEAN_COASTAL =  {
			distributepercent = 0.01,
			distributeprefabs = {
				driftwood_log = 1,
				bullkelp_plant = 2,
			},
		},
		OCEAN_SWELL = {
			distributepercent = 0.01,
			distributeprefabs =
			{
				driftwood_log = 1,
				antchovies_group = 1,
				seastack = 1,
			},
		},
		OCEAN_ROUGH = {
			distributepercent = 0.03,
			distributeprefabs =
			{
				seastack = 1,
			},
		},
		OCEAN_HAZARDOUS = {
			distributepercent = 0.15,
			distributeprefabs =
			{
				boatfragment03 = 1,
				boatfragment04 = 1,
				boatfragment05 = 1,
				seastack = 1,
			},
		},
	}

	local width, height = TheWorld.Map:GetSize()
	for k, v in pairs(pop) do
		populate_ocean(GROUND[k], v, width, height)
	end

	print("Retrofitting for Return Of Them: Turn of Tides - Populated Ocean.")
end

local function TurnOfTidesRetrofitting_CleanupOceanPoution(inst)
	require "map/bunch_spawner"

	local items_to_remove = { "seastack", "antchovies_group", "driftwood_log" }
	local biomes_to_cleanup = { GROUND.OCEAN_SWELL, GROUND.OCEAN_ROUGH, GROUND.OCEAN_BRINEPOOL }

	local count = RemovePrefabs(items_to_remove, biomes_to_cleanup)
	count = count + RemovePrefabs(items_to_remove, biomes_to_cleanup)
	print ("Retrofitting for Turn of Tides Beta: Removed "..tostring(count).." ocean things.")


	local width, height = TheWorld.Map:GetSize()
	
	BunchSpawnerInit(nil, width, height)
	local function SpawnBoatingSafePrefab(prefab, x, z)
		if #TheSim:FindEntities(x, 0, z, TUNING.MAX_WALKABLE_PLATFORM_RADIUS + 4, WALKABLEPLATFORM_TAGS) == 0 then
			local obj = SpawnPrefab(prefab)
			obj.Transform:SetPosition(x, 0, z)
		end
	end

	local function populate(tile_type, contents)
		for y = OCEAN_POPULATION_EDGE_DIST, height - OCEAN_POPULATION_EDGE_DIST - 1, 1 do
			for x = OCEAN_POPULATION_EDGE_DIST, width - OCEAN_POPULATION_EDGE_DIST - 1, 1 do
				if TheWorld.Map:GetTile(x, y) == tile_type then
					if math.random() < contents.distributepercent then
						local spawn_x, spawn_z = (x - width/2.0)*TILE_SCALE + math.random()*2-1, (y - height/2.0)*TILE_SCALE + math.random()*2-1
						local prefab = weighted_random_choice(contents.distributeprefabs)
						if prefab ~= nil then
							if IsBunchSpawner( prefab ) then
								BunchSpawnerRunSingleBatchSpawner(TheWorld.Map, prefab, spawn_x, spawn_z, SpawnBoatingSafePrefab)
							else
								local obj = SpawnPrefab(prefab)
								obj.Transform:SetPosition(spawn_x, 0, spawn_z)
							end
						end
					end
				end
			end
		end
	end
	local pop = {
		OCEAN_SWELL = {
			distributepercent = 0.005,
			distributeprefabs =
			{
				seastack = 1,
				seastack_spawner_swell = 0.1,
			},
		},
		OCEAN_ROUGH = {
			distributepercent = 0.01,
			distributeprefabs =
			{
				seastack = 1,
				seastack_spawner_rough = 0.13,
			},
		},
	}

	for k, v in pairs(pop) do
		populate(GROUND[k], v)
	end

	print("Retrofitting for Return Of Them : Turn of Tides Beta - Repopulated Ocean.")
end

local function SaltyRetrofitting_PopulateShoalSpawner()
	local width, height = TheWorld.Map:GetSize()

	local pop = {
		OCEAN_SWELL = {
			distributepercent = 0.0003,
			distributeprefabs =
			{
				oceanfish_shoalspawner = 1,
			},
		},
	}

	local width, height = TheWorld.Map:GetSize()
	for k, v in pairs(pop) do
		populate_ocean(GROUND[k], v, width, height)
	end
end


local function SaltyRetrofitting_PopulateBrinePools()
	require "map/bunch_spawner"

	local bunches = require "map/bunches"
	bunches.Bunches["SaltyRetrofitting_PopulateBrinePools"] = 
	{
		prefab = "saltstack",
		range = 14,
		min = 4,
		max = 6,
		min_spacing = 3, 
		valid_tile_types = {
			GROUND.OCEAN_BRINEPOOL,
		},
	}

	local num_spawners = 0
	local num_stacks = 0

	local width, height = TheWorld.Map:GetSize()
	BunchSpawnerInit(nil, width, height)

	local function SpawnBoatingSafePrefab(prefab, x, z)
		if #TheSim:FindEntities(x, 0, z, TUNING.MAX_WALKABLE_PLATFORM_RADIUS + 4, WALKABLEPLATFORM_TAGS) == 0 then
			local obj = SpawnPrefab(prefab)
			obj.Transform:SetPosition(x, 0, z)

			num_stacks = num_stacks + 1
		end
	end

	local function onspawn(prefab, pt)
		BunchSpawnerRunSingleBatchSpawner(TheWorld.Map, "SaltyRetrofitting_PopulateBrinePools", pt.x, pt.z, SpawnBoatingSafePrefab)
		num_spawners = num_spawners + 1
	end

	local pop = {
		OCEAN_BRINEPOOL = {
			distributepercent = 0.012,
			distributeprefabs =
			{
				cookiecutter_spawner = 1,
			},
		},
	}

	local width, height = TheWorld.Map:GetSize()
	for k, v in pairs(pop) do
		populate_ocean(GROUND[k], v, width, height, onspawn)
	end

	print("Retrofitting for Return Of Them: Salty Dog - Added " .. tostring(num_spawners) .. " 'cookiecutter_spawner' and " .. tostring(num_stacks) .. " 'saltstack' prefabs.")
end

local function SheSellsSeashellsRetrofitting_PopulateWobsterDens()
	require "map/bunch_spawner"
	local width, height = TheWorld.Map:GetSize()
	
	local count = 0

	BunchSpawnerInit(nil, width, height)
	local function SpawnBoatingSafePrefab(prefab, x, z)
		if #TheSim:FindEntities(x, 0, z, TUNING.MAX_WALKABLE_PLATFORM_RADIUS + 4, WALKABLEPLATFORM_TAGS) == 0 then
			local obj = SpawnPrefab(prefab)
			obj.Transform:SetPosition(x, 0, z)
			count = count + 1
		end
	end

	local function populate(tile_type, contents)
		for y = OCEAN_POPULATION_EDGE_DIST, height - OCEAN_POPULATION_EDGE_DIST - 1, 1 do
			for x = OCEAN_POPULATION_EDGE_DIST, width - OCEAN_POPULATION_EDGE_DIST - 1, 1 do
				if TheWorld.Map:GetTile(x, y) == tile_type then
					if math.random() < contents.distributepercent then
						local spawn_x, spawn_z = (x - width/2.0)*TILE_SCALE + math.random()*2-1, (y - height/2.0)*TILE_SCALE + math.random()*2-1
						local prefab = weighted_random_choice(contents.distributeprefabs)
						if prefab ~= nil then
							if IsBunchSpawner( prefab ) then
								BunchSpawnerRunSingleBatchSpawner(TheWorld.Map, prefab, spawn_x, spawn_z, SpawnBoatingSafePrefab)
							else
								local obj = SpawnPrefab(prefab)
								obj.Transform:SetPosition(spawn_x, 0, spawn_z)
							end
						end
					end
				end
			end
		end
	end
	local pop = {
		OCEAN_COASTAL_SHORE = {
			distributepercent = 0.005,
			distributeprefabs =
			{
				wobster_den_spawner_shore = 1,
			},
		},
	}

	for k, v in pairs(pop) do
		populate(GROUND[k], v)
	end

	print("Retrofitting for Return Of Them : She Sells Seashells - Added " .. tostring(count) .. " Wobster Dens.")
end

--------------------------------------------------------------------------
--[[ Lightning Bluff Retrofit ]]
--------------------------------------------------------------------------

local function RetrofitAgainstTheGrain(area)
	local function FindAreas(candidtates)
		local lake_pt = nil
		for k,v in ipairs(candidtates) do
			local node = TheWorld.topology.nodes[v]
			local pt = Vector3(node.cent[1], 0, node.cent[2])
			if false and TheWorld.Map:IsPassableAtPoint(pt.x, pt.y, pt.z) then
				if lake_pt == nil then
					lake_pt = pt
				else
					return pt, lake_pt
				end
			elseif node.x ~= nil then
				pt.x, pt.z = node.x, node.y
				if TheWorld.Map:IsPassableAtPoint(pt.x, pt.y, pt.z) then
					if lake_pt == nil then
						lake_pt = pt
					else
						return pt, lake_pt
					end
				end
			end
		end
		
		return nil
	end

	print ("Retrofitting for Against the Grain: Trying to retrofit "..area..".")

	local node_indices = {}
	local candidtates = {}
	local lake_candidate = nil
	for k,v in ipairs(TheWorld.topology.ids) do
		if area == string.sub(v, 1, #area) then
			table.insert(node_indices, k)

			local node = TheWorld.topology.nodes[k]
			if string.find(v, "PondyGrass") then
				lake_candidate = k
			elseif not string.find(v, "HoundyBadlands") and (#(TheSim:FindEntities(node.cent[1], 0, node.cent[2], 30, LAVA_TAGS)) == 0) then
				table.insert(candidtates, k)
			end
		end
	end
	if #node_indices == 0 then
		print ("Retrofitting for Against the Grain: "..area.." task was not added to the world.")
		return false
	end
	if #candidtates < 2 then
		print ("Retrofitting for Against the Grain: "..area.." is too small to retrofit.")
		return false
	end
	
	shuffleArray(candidtates)

	local shortlist = {}
	for k,v in ipairs(candidtates) do
		local node = TheWorld.topology.nodes[v]
		if #(TheSim:FindEntities(node.cent[1], 0, node.cent[2], 20, STRUCTURE_TAGS)) < 3 then
			table.insert(shortlist, v)
		end
	end
	if lake_candidate ~= nil then
		table.insert(shortlist, 1, lake_candidate)
		table.insert(candidtates, 1, lake_candidate)
	end

	print ("Retrofitting for Against the Grain: " .. tostring(#node_indices) .. " nodes, " .. tostring(#candidtates) .. " canidates, ".. tostring(#shortlist).." short listed.")
	
	local antlion_pt, lake_pt = FindAreas(shortlist)
	if antlion_pt == nil then
		print "Retrofitting for Against the Grain: All nodes have structures."
		antlion_pt, lake_pt = FindAreas(candidtates)
	end
	if antlion_pt == nil then
		print "Retrofitting for Against the Grain: Failed to find a location for the antlion and oasis lake."
		return
	end

	print ("Retrofitting for Against the Grain: "..area.." will be retorfitted to include Lightning Bluff.")

	-- Add standstorm node tag to all of the oasis
	for k,v in ipairs(node_indices) do
		if not table.contains(TheWorld.topology.nodes[v].tags, "sandstorm") then
			if TheWorld.topology.nodes[v].tags == nil then
				TheWorld.topology.nodes[v].tags = {}
			end
			table.insert(TheWorld.topology.nodes[v].tags, "sandstorm")
		end
	end
	print "Retrofitting for Against the Grain: Sandstorm enabled."

	-- Add the Antlion Spawner
	local ents = TheSim:FindEntities(antlion_pt.x, 0, antlion_pt.z, 2, nil, IMPORTANT_OBJECT_TAGS)
	for _,ent in ipairs(ents) do
		if ent.brain == nil then
			print ("Retrofitting for Against the Grain: Warning - Removing object, " .. tostring(ent) .. " to make way for the antlion.")
			if ent.components.workable ~= nil then
				ent.components.workable:Destroy(ent)
			end
			if ent:IsValid() then
				ent:Remove()
			end
		end
	end
	SpawnPrefab("antlion_spawner").Transform:SetPosition(antlion_pt:Get())
	print "Retrofitting for Against the Grain: Added Antlion Spawner."

	-- Add the Oasis Lake and clearout the area around it
	local lake_ents = TheSim:FindEntities(lake_pt.x, 0, lake_pt.z, 6, nil, IMPORTANT_OBJECT_TAGS)
	for _,ent in ipairs(lake_ents) do
		if ent.brain == nil then
			print ("Retrofitting for Against the Grain: Warning - Removing object, " .. tostring(ent) .. " to make way for the oasis lake.")
			if ent.components.workable ~= nil then
				ent.components.workable:Destroy(ent)
			end
			if ent:IsValid() then
				ent:Remove()
			end
		end
	end
	local oasis_ponds = TheSim:FindEntities(lake_pt.x, 0, lake_pt.z, 50, WATERSOURCE_TAGS)
	for _,ent in ipairs(oasis_ponds) do
		print ("Retrofitting for Against the Grain: Removing pond, " .. tostring(ent) .. " to make way for the oasis lake.")
		ent:Remove()
	end
	SpawnPrefab("oasislake").Transform:SetPosition(lake_pt:Get())
	print "Retrofitting for Against the Grain: Added Oasis Lake."
	
	-- Convert cactus to oasis_cactus
	if area == "Oasis" then
		local num_cactus = 0
		for k,v in ipairs(node_indices) do
			local node = TheWorld.topology.nodes[v]
			local ents = TheSim:FindEntities(node.cent[1], 0, node.cent[2], 50, THORNY_TAGS)
			for _,ent in ipairs(ents) do
				if ent.prefab == "cactus" then
					local x,y,z = ent.Transform:GetWorldPosition()
					ent:Remove()
					SpawnPrefab("oasis_cactus").Transform:SetPosition(x,y,z)
					num_cactus = num_cactus + 1
				end
			end
		end
		print ("Retrofitting for Against the Grain: Converted " .. tostring(num_cactus) .. " cactus objects to oasis_cactus.")
	end
	
	print ("Retrofitting for Against the Grain: "..area.." has been retrofitted to include Lightning Bluff.")
	return true
end


--------------------------------------------------------------------------
--[[ Post initialization ]]
--------------------------------------------------------------------------

function self:OnPostInit()
	if retrofit_part1 then
		local requires_retrofitting = true
	    for k,v in pairs(Ents) do
			if v ~= inst and v.prefab == "moonbase" then
				print ("Retrofitting for A New Reign Part1 is not required.")
				requires_retrofitting = false
				break
			end
		end

		if requires_retrofitting then
			print ("Retrofitting for A New Reign Part1.")
			RetrofitNewContentPrefab(inst, "stagehand", 2, 10)
			RetrofitNewContentPrefab(inst, "moonbase", 2, 40)
			RetrofitNewContentPrefab(inst, "sculpture_rookbody", 2, 40)
			RetrofitNewContentPrefab(inst, "sculpture_rooknose", 1, 10)
			RetrofitNewContentPrefab(inst, "sculpture_knightbody", 2, 40)
			RetrofitNewContentPrefab(inst, "sculpture_knighthead", 1, 10)
			RetrofitNewContentPrefab(inst, "sculpture_bishopbody", 2, 40)
			RetrofitNewContentPrefab(inst, "sculpture_bishophead", 1, 10)
		end
	end

	if self.retrofit_artsandcrafts then
		self.retrofit_artsandcrafts = nil
		
		local requires_retrofitting = true
		local missing_sculpture = {pawn=true, knight=true, rook=true, bishop=true, muse=true, formal=true}
	    for k,v in pairs(Ents) do
			if v ~= inst then
				if v.prefab == "statue_marble" then
					if v.typeid == 1 or v.typeid == 2 then
						missing_sculpture.muse = nil
					elseif v.typeid == 4 then
						missing_sculpture.pawn = nil
					end
				elseif v.prefab == "statuemaxwell" then
					missing_sculpture.formal = nil
				elseif v.prefab == "sculpture_rookbody" then
					missing_sculpture.rook = nil
				elseif v.prefab == "sculpture_knightbody" then
					missing_sculpture.knight = nil
				elseif v.prefab == "sculpture_bishopbody" then
					missing_sculpture.bishop = nil
				end
				
				if next(missing_sculpture) == nil then
					print ("Retrofitting for A New Reign: Arts and Crafts is not required.")
					break;
				end
			end
		end

		if next(missing_sculpture) ~= nil then
			print ("Retrofitting for A New Reign: Arts and Crafts.")
			for key,_ in pairs(missing_sculpture) do
				RetrofitNewContentPrefab(inst, "chesspiece_"..key.."_sketch", 1, 5)
			end
		end

	end

    if self.retrofit_artsandcrafts2 then
        self.retrofit_artsandcrafts2 = nil

        inst:PushEvent("ms_unlockchesspiece", "pawn")
        inst:PushEvent("ms_unlockchesspiece", "bishop")
        inst:PushEvent("ms_unlockchesspiece", "rook")
        inst:PushEvent("ms_unlockchesspiece", "knight")
        inst:PushEvent("ms_unlockchesspiece", "muse")
        inst:PushEvent("ms_unlockchesspiece", "formal")
    end
    
	if self.retrofit_cutefuzzyanimals then
		self.retrofit_cutefuzzyanimals = nil
		
		local missing_prefabs = {critterlab=true, beequeenhive=true}
	    for k,v in pairs(Ents) do
			if table.containskey(missing_prefabs, v.prefab) then
				missing_prefabs[v.prefab] = nil

				if next(missing_prefabs) == nil then
					print ("Retrofitting for A New Reign: Cute Fuzzy Animals is not required.")
					break
				end
			end
		end

		if next(missing_prefabs) ~= nil then
			print ("Retrofitting for A New Reign: Cute Fuzzy Animals.")
			for key,_ in pairs(missing_prefabs) do
				RetrofitNewContentPrefab(inst, key, 2, 10)
			end
		end
	end

	
	if self.retrofit_herdmentality then
		self.retrofit_herdmentality = nil

		local requires_retrofitting = true
	    for k,v in pairs(Ents) do
			if v ~= inst and v.prefab == "deerspawningground" then
				print ("Retrofitting for A New Reign: Herd Mentality is not required.")
				requires_retrofitting = false
				break
			end
		end
		
		if requires_retrofitting then
			local deciduousfn = function(x, y, z, prefab)
					return TheWorld.Map:GetTileAtPoint(x, y, z) == GROUND.DECIDUOUS
				end
				
			print ("Retrofitting for A New Reign: Herd Mentality.")
			RetrofitNewContentPrefab(inst, "deerspawningground", 1, 10, deciduousfn)
			RetrofitNewContentPrefab(inst, "deerspawningground", 1, 10, deciduousfn)
			RetrofitNewContentPrefab(inst, "deerspawningground", 1, 10, deciduousfn)
			RetrofitNewContentPrefab(inst, "deerspawningground", 1, 10, deciduousfn)
			RetrofitNewContentPrefab(inst, "deerspawningground", 1, 10, deciduousfn)
			RetrofitNewContentPrefab(inst, "deerspawningground", 1, 10, deciduousfn)
			RetrofitNewContentPrefab(inst, "deerspawningground", 1, 10, deciduousfn)
			RetrofitNewContentPrefab(inst, "deerspawningground", 1, 10, deciduousfn)
		end

	end
	
	if self.retrofit_againstthegrain then
		self.retrofit_againstthegrain = nil
		
		local requires_retrofitting = true
	    for k,v in pairs(Ents) do
			if v.prefab == "antlion_spawner" then
				print ("Retrofitting for A New Reign: Against the Grain is not required.")
				requires_retrofitting = false
				break
			end
		end
		
		if requires_retrofitting then
			if not RetrofitAgainstTheGrain("Oasis") then
				if not RetrofitAgainstTheGrain("Badlands") then
					print "Retrofitting for Against the Grain: FAILED!"
				end
			end
		end
	end
	
	if self.retrofit_penguinice then
		self.retrofit_penguinice = nil
		local count = 0
	    for k,v in pairs(Ents) do
			if v.prefab == "rock_ice" then
				local x, y, z = v.Transform:GetWorldPosition()
				local ents = TheSim:FindEntities(x, y, z, 15.1)
				for _,ent in ipairs(ents) do
					if ent.prefab == "penguin_ice" then
						v.remove_on_dryup = true
						count = count + 1
						break
					end
				end
			end
		end
		
		if count ~= 0 then
			print ("Retrofitting for Pengull spawned Mini Glaciers: Converted " .. count .. " Mini Glaciers near pengull colonies to be remove on dry up.")
		end
	end

	if self.retrofit_turnoftides then
		self.retrofit_turnoftides = nil

		print ("Retrofitting for Return Of Them: Turn of Tides")

		TurnOfTidesRetrofitting_PopulateOcean()

		self.requiresreset = true
	end
	
	if self.retrofit_turnoftides_betaupdate1 then
		TheWorld.Map:RetrofitNavGrid()
		print ("Retrofitting for Return Of Them: Turn of Tides - Updated Nav Grid")
		self.requiresreset = true
	end
	
	if self.retrofit_turnoftides_seastacks then
		print ("Retrofitting for Return Of Them: Turn of Tides - Balancing Seastacks")
		TurnOfTidesRetrofitting_CleanupOceanPoution(self.inst)
	end
	
	if self.retrofit_fix_sculpture_pieces then
		local count = 0
		for _,obj in pairs(Ents) do
			if obj:IsValid() then
				if obj.prefab == "sculpture_knighthead" or obj.prefab == "sculpture_bishophead" or obj.prefab == "sculpture_rooknose" then
					local x, y, z = obj.Transform:GetWorldPosition()
					local bodies = TheSim:FindEntities(x, y, z, 1.6, SCULPTURE_TAGS)
					for _, body in ipairs(bodies) do
						local radius = body.prefab == "sculpture_knightbody" and 0.8
									or body.prefab == "sculpture_bishopbody" and 0.8
									or body.prefab == "sculpture_rookbody" and 1.7
									or nil
						if radius ~= nil then
							local offset = FindWalkableOffset(body:GetPosition(), math.random() * 2 * PI, radius, 60, false, false, NoHoles) or Vector3(2, 0, 0)
							obj.Transform:SetPosition((body:GetPosition() + offset):Get())

							count = count + 1
							break
						end
					end
				end
			end
		end

		if count > 0 then
			print("Retrofitting - Fixed "..tostring(count).." sculpture pieces positions.")
		else
			print("Retrofitting - No sculpture pieces required repositioning.")
		end
	end
	
	if self.retrofit_salty then
		-- add shoals for malbatross spawning, salt statcks and cookie citter spawners
		print ("Retrofitting for Return Of Them: Salty Dog - Adding Malbatross food sources.")
		SaltyRetrofitting_PopulateShoalSpawner()

--		print ("Retrofitting for Return Of Them: Salty Dog - Raising salt levels.")
--		SaltyRetrofitting_PopulateBrinePools()
	end


    if self.retrofit_shesellsseashells then
        print("Retrofitting for Return Of Them: She Sells Seashells - Adding Wobster Dens")
        SheSellsSeashellsRetrofitting_PopulateWobsterDens()
		self.requiresreset = true -- for hermit island retofitting (retrofit_shesellsseashells_hermitisland)
    end

	---------------------------------------------------------------------------
	if self.requiresreset then
		print ("Retrofitting: Worldgen retrofitting requires the server to save and restart to fully take effect.")
		print ("Restarting server in 30 seconds...")

        inst:DoTaskInTime(5,  function() TheNet:Announce(subfmt(STRINGS.UI.HUD.RETROFITTING_ANNOUNCEMENT, {time = 25})) end)
        inst:DoTaskInTime(10, function() TheNet:Announce(subfmt(STRINGS.UI.HUD.RETROFITTING_ANNOUNCEMENT, {time = 20})) end)
        inst:DoTaskInTime(15, function() TheNet:Announce(subfmt(STRINGS.UI.HUD.RETROFITTING_ANNOUNCEMENT, {time = 15})) end)
		inst:DoTaskInTime(20, function() TheNet:Announce(subfmt(STRINGS.UI.HUD.RETROFITTING_ANNOUNCEMENT, {time = 10})) end)
		inst:DoTaskInTime(22, function() TheWorld:PushEvent("ms_save") end)
		inst:DoTaskInTime(25, function() TheNet:Announce(subfmt(STRINGS.UI.HUD.RETROFITTING_ANNOUNCEMENT, {time = 5})) end)
		inst:DoTaskInTime(29, function() TheNet:Announce(STRINGS.UI.HUD.RETROFITTING_ANNOUNCEMENT_NOW) end)
		inst:DoTaskInTime(30, function() TheNet:SendWorldRollbackRequestToServer(0) end)
	end

end

--------------------------------------------------------------------------
--[[ Save/Load ]]
--------------------------------------------------------------------------

function self:OnSave()
	return {}
end

function self:OnLoad(data)
    if data ~= nil then
		-- flags for OnPostLoad
		retrofit_part1 = data.retrofit_part1 or false
		self.retrofit_artsandcrafts = data.retrofit_artsandcrafts or false
        self.retrofit_artsandcrafts2 = data.retrofit_artsandcrafts2 or false
        self.retrofit_cutefuzzyanimals = data.retrofit_cutefuzzyanimals or false
        self.retrofit_herdmentality = data.retrofit_herdmentality or false
        self.retrofit_againstthegrain = data.retrofit_againstthegrain or false
        self.retrofit_penguinice = data.retrofit_penguinice or false
        self.retrofit_turnoftides = data.retrofit_turnoftides or false
        self.retrofit_turnoftides_betaupdate1 = data.retrofit_turnoftides_betaupdate1 or false
        self.retrofit_turnoftides_seastacks = data.retrofit_turnoftides_seastacks or false
		self.retrofit_fix_sculpture_pieces = data.retrofit_fix_sculpture_pieces or false
		self.retrofit_salty = data.retrofit_salty or false
        self.retrofit_shesellsseashells = data.retrofit_shesellsseashells or false
    end
end


--------------------------------------------------------------------------
end)