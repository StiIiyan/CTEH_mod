function get_inner_color_table(start_color,end_color,median_point_amount)
    
    local color_vector = {}
    for j=1,4 do
        color_vector[j] = end_color[j] - start_color[j]
    end
    local mpa = median_point_amount
    local segment_amount = mpa + 2
    
    for i=1,4 do
        color_vector[i] = color_vector[i] / segment_amount
    end
    
    local result = {}
    for i=1,mpa do
        local next_color = {}
        for j=1,4 do
            next_color[j] = start_color[j] + i * color_vector[j]
        end
        table.insert(result,next_color)
    end

    return result
end

function table_first_to_last(current_table) -- fade right to left
    if current_table == nil or #current_table < 1 then return end
    local element = current_table[1]
    table.remove(current_table,1)
    table.insert(current_table,element)
    return current_table
end

function table_last_to_first(current_table) -- fade left to right
    if current_table == nil or #current_table < 1 then return end
    local last = #current_table
    local element = current_table[last]
    table.remove(current_table,last)
    table.insert(current_table,1,element)
    return current_table
end

function looping_variation(current_table,steps,right_to_left)
    for i=1,steps do
        if right_to_left then
            current_table = table_first_to_last(current_table)
        else
            current_table = table_last_to_first(current_table)
        end
    end
    return current_table
end

function Fade_Gradient(color_table,key,message,right_to_left,median_point_amount)
    -- make all the inbetween colors (from color table to bigger color table)

    if key == nil then return end

    key = key .. '_fade'
    local n = #color_table
    local mpa = median_point_amount or 4

    local bigger_color_table = {}
    for i=1,n do
        table.insert(bigger_color_table,color_table[i])

        local first_color = i
        local last_color = i + 1
        if i == n then
            last_color = 1
        end

        local inner_color_table = get_inner_color_table(color_table[first_color],color_table[last_color],mpa)
        for j=1,#inner_color_table do
            table.insert(bigger_color_table,inner_color_table[j])
        end
    end

    -- return bigger_color_table

    -- create all the gradients

    for i=1,#bigger_color_table do
        local current_color_table = looping_variation(bigger_color_table,i,right_to_left)
        SMODS.Gradient {
            key = key .. '_' .. i,
            colours = current_color_table
        }
    end
    
    -- return the specialized message


    -- local new_message = ""
    -- for i = 1,#message do
    --     local gradient_to_use = i % #color_table
    --     if gradient_to_use == 0 then gradient_to_use = #color_table end
    --     local gradient_key = key .. '_' .. gradient_to_use

    --     local modified_character = '{C:cteh_' .. gradient_key .. '}' .. string.sub(message,i,i)
    --     new_message = new_message .. modified_character
    -- end

    
    local new_message = ""
    for i = 1,#message do
        local gradient_to_use = i % #bigger_color_table
        if gradient_to_use == 0 then gradient_to_use = #bigger_color_table end
        local gradient_key = key .. '_' .. gradient_to_use

        local modified_character = '{C:cteh_' .. gradient_key .. '}' .. string.sub(message,i,i)
        new_message = new_message .. modified_character
    end

    return new_message
end