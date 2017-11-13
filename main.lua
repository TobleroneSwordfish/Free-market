local Mod = RegisterMod("Free market", 1)
local ITEM_FREE_MARKET = Isaac.GetItemIdByName("Free market")
--and player:HasCollectible(ITEM_FREE_MARKET)
local debugText = ""

local function div(a,b)
    return (a - a % b) / b
end

function Mod:prePlayerCollision(player, collider, low)
    local player = Game():GetPlayer(0)
    if collider.Type == EntityType.ENTITY_PICKUP then
        local pickup = collider:ToPickup()
        if pickup:IsShopItem() then
            player:AddCollectible(Game():GetItemPool():GetCollectible(ItemPoolType.POOL_SHOP, true, Game():GetSeeds():GetNextSeed()), 0, true)
            collider:Remove()
        end
    end
end
Mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, Mod.prePlayerCollision)

function Mod:postNewRoom()
    debugText = "New room loaded"
    local player = Game():GetPlayer(0)
    -- if not player:HasCollectible(ITEM_FREE_MARKET) then
    --     return nil
    -- end
    for i, entity in pairs(Isaac.GetRoomEntities()) do
        if entity.Type == EntityType.ENTITY_PICKUP then
            debugText = "pickup found"
            local pickup = entity:ToPickup()
            if pickup:IsShopItem() then
                debugText = "Found shop item"
                pickup.Price = div(pickup.Price, 3)
            end
        end
    end
end
Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM ,Mod.postNewRoom)

function Mod:drawDebug()
    Isaac.RenderText(debugText, 100, 100, 255, 0, 0, 255)
end
Mod:AddCallback(ModCallbacks.MC_POST_RENDER, Mod.drawDebug)