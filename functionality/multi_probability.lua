
--[[

-- TODO rename function
-- when a game starts, this will return a player data structure, each client will connect to the server with their multi_player variable
function get_player_on_game_start(pid) -- preferably pid not related to seed, idk yet how players are differentiated in BMP
    if playing_multiplayer() then --can't continue a BMP game so no need to check if a game is created or loaded from a save file
        return player_probability_identity(pid)
    end

    if G_SAVED_GAME == nil then -- new singleplayer game
        return player_probability_identity(pid)
    else                        -- loading singleplayer game (I need to save those files if the game closes or opens :/ )
        return single_player
    end
end
]]

--[[ This Probability table has barebone for table handling with multiple players, but since the multiplayer mod has a special enemy, I will work around it
function Multiplayer_Probability_Table()
    local multiplayer_table = {}
    function multiplayer_table:adjust_player_probability(player)
        local pid = player.get_personID()
        multiplayer_table[pid] = {add_num = player.get_additive_numerator_nemesis(), 
                                  mult_num = player.get_multiplicative_numerator_nemesis(), 
                                  add_denom = player.get_additive_denominator_nemesis()}
    end
    
    function multiplayer_table:get_additive_numerator(pid)
        local sum = 0

        for playerID, odds in pairs(table) do
            if playerID ~= pid then
                sum = sum + multiplayer_table[playerID].add_num
            end
        end
        
        return sum
    end
    function multiplayer_table:get_multiplicative_numerator(pid)
        local product = 1

        for playerID, odds in pairs(table) do
            if playerID ~= pid then
                product = product * multiplayer_table[playerID].mult_num
            end
        end

        return product
    end
    function multiplayer_table:get_additive_denominator(pid)
        local sum = 0

        for playerID, odds in pairs(table) do
            if playerID ~= pid then
                sum = sum + multiplayer_table[playerID].add_denom
            end
        end

        return sum
    end
    
    return this
end
]]

function Multiplayer_Probability_Table()
    -- WE WILL HAVE A PLAYER INSTANCE FOR US AND FOR ENEMY, which will later be updated through client stuff
    
    function get_additive_numerator(pid)
        return MP and MP.GAME and MP.GAME.enemy.probability_identity:get_additive_numerator_nemesis()
    end
    function get_multiplicative_numerator(pid)
        return MP and MP.GAME and MP.GAME.enemy.probability_identity:get_multiplicative_numerator_nemesis()
    end
    function get_additive_denominator(pid)
        return MP and MP.GAME and MP.GAME.enemy.probability_identity:get_additive_denominator_nemesis()
    end
    
    return this
end


-- miscellaneous function
function default_probability_parameters()
    return {additive_numerator = 0, multiplicative_numerator = 1, additive_denominator = 0}
end

-- at all times there would be a singleplayer and a multiplayer instance, which would be instantiated when a game begins
-- pID value redundant in singleplayer, even in multiplayer with current implementation of strict 1v1 single-nemesis behaviour
function player_probability_identity(pID)
    local default_parameters = default_probability_parameters()

    local self = {
        pid = pID,

        additive_numerator = default_parameters.additive_numerator,
        multiplicative_numerator = default_parameters.multiplicative_numerator,
        additive_denominator = default_parameters.additive_denominator,

        additive_numerator_nemesis = default_parameters.additive_numerator,
        multiplicative_numerator_nemesis = default_parameters.multiplicative_numerator,
        additive_denominator_nemesis = default_parameters.additive_denominator
    }

    function self:get_personID()                            return self.pid                                 end
    function self:get_additive_numerator_nemesis()          return self.additive_numerator_nemesis          end
    function self:get_multiplicative_numerator_nemesis()    return self.multiplicative_numerator_nemesis    end
    function self:get_additive_denominator_nemesis()        return self.additive_denominator_nemesis        end

    function self:get_numerator(base_object_numerator)
        if playing_multiplayer() and MP.GAME.NemesisProbabilityTable ~= nil then
            return (base_object_numerator + self.additive_numerator + MP.GAME.NemesisProbabilityTable:get_additive_numerator(self.pid)) * 
                    self.multiplicative_numerator * MP.GAME.NemesisProbabilityTable:get_multiplicative_numerator(self.pid)
        end
        return (base_object_numerator + self.additive_numerator) * self.multiplicative_numerator
    end
    function self:get_denominator(base_denominator)
        if playing_multiplayer() and MP.GAME.NemesisProbabilityTable ~= nil then
            return (base_denominator + self.additive_denominator + MP.GAME.NemesisProbabilityTable:get_additive_denominator(self.pid))
        end
        return (base_denominator + self.additive_denominator)
    end
    

    function self:increase_additive_value(value)        self.additive_numerator = self.additive_numerator + value                   end
    function self:increase_multiplicative_value(Mvalue)  self.multiplicative_numerator = self.multiplicative_numerator * Mvalue     end
    function self:increase_denominator_value(denom)     self.additive_denominator = self.additive_denominator + denom               end

    -- all of these 3 update the server side table
    --TODO update enemy player values
    function self:increase_additive_value_nemesis(value)
        self.additive_numerator_nemesis = self.additive_numerator_nemesis + value
        -- if MP and MP.GAME and MP.GAME.NemesisProbabilityTable then
        --     MP.GAME.NemesisProbabilityTable:adjust_player_probability(self)
        -- end
    end
    function self:increase_multiplicative_value_nemesis(Mvalue)
        self.multiplicative_numerator_nemesis = self.multiplicative_numerator_nemesis * Mvalue
        -- if MP and MP.GAME and MP.GAME.NemesisProbabilityTable then
        --     MP.GAME.NemesisProbabilityTable:adjust_player_probability(self)
        -- end
    end
    function self:increase_denominator_value_nemesis(denom)
        self.additive_denominator_nemesis = self.additive_denominator_nemesis + denom
        -- if MP and MP.GAME and MP.GAME.NemesisProbabilityTable then
        --     MP.GAME.NemesisProbabilityTable:adjust_player_probability(self)
        -- end
    end

    return self
end

-- (load on game launch for saved run!!!!!!!!!!!!!!!!!!!!!)
single_player = player_probability_identity(1)

-- idk where I got this implementation with string handling and edge-cases, but it works, feel like it tries too hard
local get_probability_varsref = SMODS.get_probability_vars
function SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, from_roll)
    -- base_numerator = 1 since we use the overriden function just for multiplying the (oops all 6s) logic
    -- base_denominator = denominator
    local numerator, denominator = get_probability_varsref(trigger_obj, 1, base_denominator, identifier, from_roll)
    if type(numerator) == "string" or numerator == nil then numerator = 1 end
    if type(denominator) == "string" or denominator == nil then denominator = 1 end
    
    if playing_multiplayer() then
        numerator = numerator * multi_player:get_numerator(base_numerator)
        denominator = multi_player:get_denominator(base_denominator)
    else
        numerator = numerator * single_player:get_numerator(base_numerator)
        denominator = single_player:get_denominator(base_denominator)
    end

    if (numerator or -1) < 0 then numerator = 0 end
    if (denominator or 0) < 1 then denominator = 1 end
    return numerator, denominator
end

local probability_ref = SMODS.pseudorandom_probability
function SMODS.pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator, identifier)
    local result_numerator = single_player:get_numerator(base_numerator)
    local result_denominator = single_player:get_denominator(base_denominator)
    
    return probability_ref(trigger_obj, seed, result_numerator, result_denominator)
end
