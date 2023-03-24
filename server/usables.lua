
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


Citizen.CreateThread(function()
    for name, info in pairs(Config.Items) do
        RegisterServerEvent("RegisterUsableItem:" .. name)
        AddEventHandler("RegisterUsableItem:" .. name, function(source, data)
            TriggerEvent("redemrp_inventory:getData", function(Inventory)
                local Player = RedEM.GetPlayer(source)
                local meta = Player.GetMetaData()
                local itemmeta = data.meta or {}
                local ItemData = Inventory.getItem(source, name, itemmeta)
                local add_h, add_t = info.hunger, info.thirst
                local vomit
                if itemmeta.expire then 
                    local expire_hours = ItemData.ItemInfo.expire_hours
                    if expire_hours <= 0 then 
                        vomit = true 
                        add_h, add_t = -20.0, -20.0
                    end
                end
                
                Player.SetMetaData("hunger", tonumber(meta.hunger) + add_h)
                Player.SetMetaData("thirst", tonumber(meta.thirst) + add_t)
                if Player.GetMetaData().hunger > 100.0 then Player.SetMetaData("hunger", 100) end
                if Player.GetMetaData().thirst > 100.0 then Player.SetMetaData("thirst", 100) end

                ItemData.RemoveItem(1)
    
                TriggerClientEvent('redemrp_status:UpdateStatus', source, Player.GetMetaData().thirst, Player.GetMetaData().hunger, Player.GetMetaData().stress)
                info.action(source, name)
                if vomit then 
                    Wait(6000)
                    TriggerClientEvent("redemrp_status:vomit_anim", source)
                end
            end)
        end)
    end
end)


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


RegisterServerEvent("RegisterUsableItem:cigarettes", function(source)
    local Player = RedEM.GetPlayer(source)
    TriggerEvent("redemrp_inventory:getData", function(Inventory)
        local ItemData = Inventory.getItem(source, 'cigarettes')
        if ItemData.ItemAmount >= 1 then
            ItemData.RemoveItem(1)
            local ItemData2 = Inventory.getItem(source, 'cigarette')
            ItemData2.AddItem(20)
            TriggerClientEvent("redemrp_status:client:PlayConsumableSound", source)
            RedEM.Functions.NotifyRight( source, "Cigarette pack opened!", 3000)
        end
    end)
end)


RegisterServerEvent("RegisterUsableItem:smokingpipe", function(source)
    TriggerEvent("redemrp_inventory:getData", function(Inventory)
        local PipeData = Inventory.getItem(source, 'smokingpipe')
        local DrugData = Inventory.getItem(source, 'driedopium')
        local hasOpium = DrugData.ItemAmount >= 1
        local DrugData = Inventory.getItem(source, 'weed')
        local hasWeed = DrugData.ItemAmount >= 1
        local DrugData = Inventory.getItem(source, 'tobacco')
        local hasTobacco = DrugData.ItemAmount >= 1
        local DrugData = Inventory.getItem(source, 'btobacco')
        local hasBTobacco = DrugData.ItemAmount >= 1
        local DrugData = Inventory.getItem(source, 'indtobacco')
        local hasIndTobacco = DrugData.ItemAmount >= 1
        if PipeData.ItemAmount >= 1 then
            TriggerClientEvent("redemrp_status:client:PipeMenu", source, hasOpium, hasWeed, hasTobacco, hasBTobacco, hasIndTobacco)
        end
    end)
end)

RegisterServerEvent("redemrp_status:server:SmokeWeed", function()
    local _source = source
    TriggerEvent("redemrp_inventory:getData", function(Inventory)
        local Player = RedEM.GetPlayer(_source)

        local PipeData = Inventory.getItem(_source, 'smokingpipe')
        local DrugData = Inventory.getItem(_source, 'weed')
        if PipeData.ItemAmount >= 1 then
            if DrugData.ItemAmount >= 1 then
                DrugData.RemoveItem(1)
                TriggerClientEvent("redemrp_status:client:UseWeed", _source)
            end
        else
            RedEM.Functions.NotifyRight(_source, "You need a pipe to smoke this!", 3000)
        end
    end)
end)

RegisterServerEvent("redemrp_status:server:SmokeOpium", function()
    local _source = source
    TriggerEvent("redemrp_inventory:getData", function(Inventory)
        local PipeData = Inventory.getItem(_source, 'smokingpipe')
        local DrugData = Inventory.getItem(_source, 'driedopium')
        if PipeData.ItemAmount >= 1 then
            if DrugData.ItemAmount >= 1 then
                DrugData.RemoveItem(1)
                TriggerClientEvent("redemrp_status:client:UseOpium", _source)
            end
        else
            RedEM.Functions.NotifyRight(_source, "You need a pipe to smoke this!", 3000)
        end
    end)
end)

RegisterServerEvent("redemrp_status:server:SmokeTobacco", function()
    local _source = source
    TriggerEvent("redemrp_inventory:getData", function(Inventory)
        local PipeData = Inventory.getItem(_source, 'smokingpipe')
        local TobaccoData = Inventory.getItem(_source, 'tobacco')
        if PipeData.ItemAmount >= 1 then
            if TobaccoData.ItemAmount >= 1 then
                TobaccoData.RemoveItem(1)
                TriggerClientEvent("redemrp_status:client:UseTobaccoPipe", _source)
            end
        else
            RedEM.Functions.NotifyRight(_source, "You need a pipe to smoke this!", 3000)
        end
    end)
end)

RegisterServerEvent("redemrp_status:server:SmokeBTobacco", function()
    local _source = source
    TriggerEvent("redemrp_inventory:getData", function(Inventory)
        local PipeData = Inventory.getItem(_source, 'smokingpipe')
        local TobaccoData = Inventory.getItem(_source, 'btobacco')
        if PipeData.ItemAmount >= 1 then
            if TobaccoData.ItemAmount >= 1 then
                TobaccoData.RemoveItem(1)
                TriggerClientEvent("redemrp_status:client:UseTobaccoPipe", _source)
            end
        else
            RedEM.Functions.NotifyRight(_source, "You need a pipe to smoke this!", 3000)
        end
    end)
end)

RegisterServerEvent("redemrp_status:server:SmokeIndTobacco", function()
    local _source = source
    TriggerEvent("redemrp_inventory:getData", function(Inventory)
        local PipeData = Inventory.getItem(_source, 'smokingpipe')
        local TobaccoData = Inventory.getItem(_source, 'indtobacco')
        if PipeData.ItemAmount >= 1 then
            if TobaccoData.ItemAmount >= 1 then
                TobaccoData.RemoveItem(1)
                TriggerClientEvent("redemrp_status:client:UseTobaccoPipe", _source)
            end
        else
            RedEM.Functions.NotifyRight(_source, "You need a pipe to smoke this!", 3000)
        end
    end)
end)


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------