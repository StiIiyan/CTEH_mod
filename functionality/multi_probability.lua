
--[[
--some global space: (after all, you can have a saved singleplayer run and be playing multiplayer at the same time)
multi_player

--some global space when game begins:
if playing_multiplayer() then
    single_player = get_player_on_game_start(some_id)
else
    multi_player = get_player_on_game_start(some_id)
end

-- TODO rename function
-- when a game starts, this will return a player data structure, each client will connect to the server with their multi_player variable
function get_player_on_game_start(pid) -- preferably pid not related to seed, idk yet how players are differentiated in BMP
    if playing_multiplayer() then --can't continue a BMP game so no need to check if a game is created or loaded from a save file
        return player_identity(pid)
    end

    if G_SAVED_GAME == nil then -- new singleplayer game
        return player_identity(pid)
    else                        -- loading singleplayer game (I need to save those files if the game closes or opens :/ )
        return single_player
    end
end
]]

-- a multiplayer game will create one SERVER SIDE instance of the table when a game begins 
-- (that would have to mean players will somehow send requests to the server using these commands)
-- it handles any nemesis effects, strictly avoiding your own nemesis-cast probability effects
-- table contents are all nemesis-related: table[pid] -> {additive_numerator,multiplicative_numerator,denominator}
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

-- miscellaneous function
function default_probability_parameters()
    return {additive_numerator = 0, multiplicative_numerator = 1, additive_denominator = 0}
end

-- at all times there would be a singleplayer and a multiplayer instance, which would be instantiated by get_player_on_game_start when a game begins
-- pID value and multiplayer_table value redundant in singleplayer
function player_identity(pID, BMP_table)
    local default_parameters = default_probability_parameters()

    local self = {
        pid = pID,
        multiplayer_probability_table = BMP_table,

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
        if playing_multiplayer() and self.multiplayer_probability_table ~= nil then
            return (base_object_numerator + self.additive_numerator + self.multiplayer_probability_table.get_additive_numerator(self.pid)) * 
                    self.multiplicative_numerator * self.multiplayer_probability_table.get_multiplicative_numerator(self.pid)
        end
        return (base_object_numerator + self.additive_numerator) * self.multiplicative_numerator
    end
    function self:get_denominator(base_denominator)
        if playing_multiplayer() and self.multiplayer_probability_table ~= nil then
            return (base_denominator + self.additive_denominator + self.multiplayer_probability_table.get_additive_denominator(self.pid))
        end
        return (base_denominator + self.additive_denominator)
    end
    

    function self:increase_additive_value(value)        self.additive_numerator = self.additive_numerator + value                   end
    function self:increase_multiplicative_value(Mvalue)  self.multiplicative_numerator = self.multiplicative_numerator * Mvalue     end
    function self:increase_denominator_value(denom)     self.additive_denominator = self.additive_denominator + denom               end

    -- all of these 3 update the server side table
    function self:increase_additive_value_nemesis(value)
        self.additive_numerator_nemesis = self.additive_numerator_nemesis + value
        if self.multiplayer_probability_table then
            self.multiplayer_probability_table:adjust_player_probability(self)
        end
    end
    function self:increase_multiplicative_value_nemesis(Mvalue)
        self.multiplicative_numerator_nemesis = self.multiplicative_numerator_nemesis * Mvalue
        if self.multiplayer_probability_table then
            self.multiplayer_probability_table:adjust_player_probability(self)
        end
    end
    function self:increase_denominator_value_nemesis(denom)
        self.additive_denominator_nemesis = self.additive_denominator_nemesis + denom
        if self.multiplayer_probability_table then
            self.multiplayer_probability_table:adjust_player_probability(self)
        end
    end

    return self
end

-- (load on game launch for saved run!!!!!!!!!!!!!!!!!!!!!)
single_player = player_identity(1)

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
