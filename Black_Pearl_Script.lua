--[[
	   ||||||   ||      ||||||  ||||||  ||  ||	    |||||   ||||||  ||||||   |||||   ||    
		||	||	||		||  ||  ||	    || ||       ||	||  ||      ||  ||   ||	 ||  ||		 
		||||||	||		||||||  ||	    |||     -   |||||   ||||||  ||||||   |||||   ||		 
		||	||	||	    ||  ||  ||	    || ||       ||		||      ||  ||   ||	||   ||	   
	   ||||||	||||||  ||  ||  ||||||  ||  ||      ||		||||||  ||  ||   ||  ||  |||||| 
							MAINTAINTED BY ALEXEWARR (KNOWN AS AK47SIGH)
--]]

--[[--  SCRIPT CONFIGS  --]]-- : Availe configs
local Battlemaster_EntryID = 92000 -- npc's entry ID, the npc where the players can join battle or leave
local MIN_PLAYERS = 2 -- minimum players to start the battle (MAXIMUM ALLOWED: 20 - do not pass this value)
local MIN_AP = 1 -- minimum alliance players to start the battle (MAXIMUM ALLOWED: 20 - do not pass this value)
local MIN_HP = 1 -- minimum horde players to start the battle (MAXIMUM ALLOWED: 20 - do not pass this value)

--[[--  BROADCAST MESSAGES  --]]-- : Not recommended to edit
local queuedMSG = "You have been placed in que."
local unqueuedMSG = "You have left the que."

--[[--  DO NOT EDIT THIS CATEGORY  --]]-- : Do not edit these values
BP_ASTART = { 1, -10180.42, -5124.49, 9.402811, 4.712514 }
BP_HSTART = { 1, -10100.23, -5131.04, 11.257527, 4.856875 }

local T = {}

function T.OnQue(pPlayer) -- Functin When Player is Trying to Que to Battle
 plrAccName = pPlayer:GetAccountName() -- Define Player's Account Name in this function
 plrCharName = pPlayer:GetName() -- Define Player's Character Name in this function
 
  if(pPlayer:GetTeam() == 1) then 
   plrFaction = "Horde" -- Define faction for the character name
   else
   plrFaction = "Alliance" -- Define faction for the character name
   end
   
 GetQAStatus = CharDBQuery("SELECT * FROM blackpearl_queue WHERE `faction`='Alliance';") -- Get Character names with Alliance faction
 GetQHStatus = CharDBQuery("SELECT * FROM blackpearl_queue WHERE `faction`='Horde';") -- Get Character names with Horde faction
 
 if(GetQAStatus == nil) then -- if there is no character in database with alliance faction
 QAST = 0+1 -- then status string 0+joined player
 else -- if there is at least 1 player of alliance faction
 QAST = GetQAStatus:GetRowCount() -- then result how many
 end
 
 if(GetQHStatus == nil) then -- if there is no character in database horde faction
 QHST = 0+1 -- then status string 0+joined player
 else -- if there is at least 1 player of horde faction
 QHST = GetQHStatus:GetRowCount() -- then result how many
 end

 if(QAST == MIN_AP) then -- if alliance team is full
 TAP = "FULL" -- then total alliance players equal with minimum alliance players required (Full team)
 if(pPlayer:GetTeam() == 0) then -- alliance player
 	pPlayer:SendAreaTriggerMessage("Alliance Queue is Full. Please stand by for a free spot.")
 end
 else -- if team not full
 TAP = "UNREADY" -- then total alliance players equal with currently players qued (Not full)
 if(pPlayer:GetTeam() == 0) then -- alliance player
 CharDBQuery("INSERT INTO `blackpearl_queue` (`AccName`, `Character`, `faction`) VALUES ('"..plrAccName.."', '"..plrCharName.."', '"..plrFaction.."');") -- Insert player in queue table
  pPlayer:PlaySoundToPlayer(8458) -- play Sound on Battle Que Join
  	pPlayer:SendAreaTriggerMessage("You are now placed in queue.")
  pPlayer:SendBroadcastMessage("Horde: "..QHST.."/"..MIN_HP..". Alliance: "..QAST.."/"..MIN_AP..".") -- Show how many Alliance & Horde players are qued to battle
 end
 end
  
 if(QHST == MIN_HP) then -- if horde team is full
 THP = "FULL" -- then total horde players equal with minimum horde players required (Full team)
 if(pPlayer:GetTeam() == 1) then -- horde player
 	pPlayer:SendAreaTriggerMessage("Horde Queue is Full. Please stand by for a free spot.")
 end
 else -- if team not full
 THP = "UNREADY" -- then total alliance players equal with currently players qued (Not full)
 if(pPlayer:GetTeam() == 1) then -- horde player
 CharDBQuery("INSERT INTO `blackpearl_queue` (`AccName`, `Character`, `faction`) VALUES ('"..plrAccName.."', '"..plrCharName.."', '"..plrFaction.."');") -- Insert player in queue table
  pPlayer:PlaySoundToPlayer(8458) -- play Sound on Battle Que Join
  	pPlayer:SendAreaTriggerMessage("You are now placed in queue.")
  pPlayer:SendBroadcastMessage("Alliance: "..QAST.."/"..MIN_AP..". Horde: "..QHST.."/"..MIN_HP..".") -- Show how many Alliance & Horde players are qued to battle
 end
 end
  
 if(TAP == "FULL" and THP == "FULL") then -- if Teams are full (Thanks to Rochet for this part)
  QueryResult = CharDBQuery("SELECT * FROM blackpearl_queue;")    -- QueryResult is now a query result containing all rows from table_name
 if(QueryResult) then                                              -- Check that the query did not fail and did actually return at least one row
    repeat                                                        -- QueryResult is NOT a lua table! It is a query result, so we cant use for k,v in pairs for example. We can use repeat or for loop with Q:GetRowCount()
     local player_name = QueryResult:GetColumn(1):GetString()  -- Are you sure it is in column 1? Columns start from 0, so in normal character table it would be 2 for example. (guid 0, acct, 1, name, 2)
     local player = GetPlayer(player_name)                     -- Find the player from world with the name and save it to a variable
    if(player) then                                           -- Check if a player was found ingame
     if(player:GetTeam() == 1) then -- if horde team
     player:Teleport(BP_HSTART[1], BP_HSTART[2], BP_HSTART[3], BP_HSTART[4], BP_HSTART[5]) -- teleport horde players to horde cargo
     else -- if alliance team
     player:Teleport(BP_ASTART[1], BP_ASTART[2], BP_ASTART[3], BP_ASTART[4], BP_ASTART[5]) -- teleport alliance players to alliance cargo
     end
    if(pPlayer:GetTeam() == 1) then -- if horde player (last player joined the que)
     pPlayer:Teleport(BP_HSTART[1], BP_HSTART[2], BP_HSTART[3], BP_HSTART[4], BP_HSTART[5]) -- teleport player to the horde cargo
    else -- if alliance player (last player joined the que)
     pPlayer:Teleport(BP_ASTART[1], BP_ASTART[2], BP_ASTART[3], BP_ASTART[4], BP_ASTART[5]) -- teleport player to the alliance cargo
    end
   else -- if players not found
   -- do something if the player was not found
   end
  until not QueryResult:NextRow() -- repeat until NextRow() = false, so until (not QueryResult:NextRow()) is true.
 end
 else -- if teams are not full
 -- do something if teams are not full
 end
end -- end of the OnQue Function

function T.CheckBattle(pPlayer) -- check status for battle
 GetBStatus = CharDBQuery("SELECT * FROM blackpearl_status ;") -- get status for battle
 BStatus = GetBStatus:GetColumn(0):GetLong() -- get battle status as number (1=isStarted, 0=Avaible)
 
 if(BStatus == 1) then -- if Battle status has started
    MenuItem01 = "Battle is in progress! Try Later." -- Menu String
    intID01 = "0" -- Menu intid
 else -- if Battle didn't started
    MenuItem01 = "Que to Battle! Now." -- Menu String
    intID01 = "1" -- Menu intid
 end
end -- end of the battle status function

function T.CheckPlayer(pPlayer) -- Check player function
 plrAccName = pPlayer:GetAccountName() -- Define player's account name
 plrCharName = pPlayer:GetName() -- Define Character's Name
 
 GetPCheck = CharDBQuery("SELECT * FROM blackpearl_queue WHERE `AccName`='"..plrAccName.."';") -- Get player from que / this is checking if is in que or not
  if(GetPCheck == nil) then -- if player is not qued
	MenuItem01 = "Que to Battle! Now." -- Menu string
	intID01 = "1" -- Menu intid
  else -- if player is qued already
	MenuItem01 = "You are qued! Leave?" -- Menu String
	intID01 = "2" -- Menu intid
  end
end -- end of the CheckPlayer function


function T.Battlemaster_OnGossip(pUnit,event,pPlayer) -- Battle Master NPC Gossip
 T.CheckBattle(pPlayer)
 T.CheckPlayer(pPlayer)
  pUnit:GossipCreateMenu(105695, pPlayer, 0)
  pUnit:GossipMenuAddItem(0,MenuItem01,intID01,0)
  pUnit:GossipSendMenu(pPlayer)
end

function T.Battlemaster_OnSelect(pUnit,event,pPlayer,id,intid,code) -- Battle Master NPC on Select Item
 plrAccName = pPlayer:GetAccountName() -- Define Player's Account Name
 plrCharName = pPlayer:GetName() -- Define Player's Character Name

if (intid == 1) then -- if player tries to join the battle
  T.OnQue(pPlayer) -- load function: OnQue
   if(TAP == "FULL" and THP == "FULL") then -- if teams are full
   pUnit:SetNPCFlags(0) -- disable npc gossip to prevent players from bugging the join que
   end
  pPlayer:GossipComplete() -- Close Gossip to prevent ugly bugs
  return T.Battlemaster_OnGossip(pUnit,event,pPlayer) -- return to the main menu
end

if (intid == 2) then -- if leave que
  CharDBQuery("DELETE FROM `blackpearl_queue` WHERE  `AccName`='"..plrAccName.."' ;") -- remove player from queue table
  pPlayer:SendBroadcastMessage(unqueuedMSG) -- broadcast a msg to player when leave que
  pPlayer:GossipComplete() -- Close Gossip to prevent ugly bugs
  return T.Battlemaster_OnGossip(pUnit,event,pPlayer) -- return to the main menu
end

if(intid == 0) then -- if close menu / whenever we need it, we will use it
pPlayer:GossipComplete() -- close main menu
end
end -- End of the function: Battlemaster on select 

RegisterUnitGossipEvent(Battlemaster_EntryID, 1, T.Battlemaster_OnGossip) -- not recommended to edit! DO NOT EDIT
RegisterUnitGossipEvent(Battlemaster_EntryID, 2, T.Battlemaster_OnSelect) -- not recommended to edit! DO NOT EDIT