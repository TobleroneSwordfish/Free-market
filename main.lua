local Mod = RegisterMod("Free market", 1)
local ITEM_FREE_MARKET = Isaac.GetItemIdByName("Free market")
--and player:HasCollectible(ITEM_FREE_MARKET)

function Mod:prePlayerCollision(player, collider, low)
    local player = Game():GetPlayer(0)
    if collider.Type == EntityType.ENTITY_PICKUP and collider:IsShopItem() then
        player:AddCollectible(ItemPool.GetCollectible(ItemPoolType.POOL_SHOP, true, 123), 0, true)
        collider:Remove()
    end
end
Isaac.AddCallback(Mod.prePlayerCollision, ModCallbacks.MC_PRE_PLAYER_COLLISION, nil, 0)

function Mod:postNewRoom()
    DebugString("New room loaded")
    local player = Game():GetPlayer(0)
    -- if not player:HasCollectible(ITEM_FREE_MARKET) then
    --     return nil
    -- end
    for i, entity in pairs(Isaac.GetRoomEntities()) do
        if entity.Type == EntityType.ENTITY_PICKUP and entity:IsShopItem() then
            local pickup = entity:ToPickup()
            pickup.Price = pickup.Price / 3
        end
    end
end
Isaac.AddCallback(Mod.postNewRoom, ModCallbacks.MC_POST_NEW_ROOM, nil, 0)