--[[

#
#       @WaderTGTeam
#   @WaderTG
#

]]

local apikey ='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjUwNjRjZTZlLTFjNTAtNDA5Zi1iM2JlLTNhZDJiOWQwYzQ3OSIsImlhdCI6MTQ1OTc3MDYyNSwic3ViIjoiZGV2ZWxvcGVyL2IyMWNkYTZhLWUwMjMtMWIxYS02ZWFkLWRjYTk0ZGMzY2Y3ZiIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjg3LjIzNi4yMTQuMTQiXSwidHlwZSI6ImNsaWVudCJ9XX0.tPBWqMEYHi4ILm91u6Lyo9GdG9NvL30lhOlig-0DZxpl4WSUWbgNV-BZUwQhqoXocp76R1SK8_OwJSZEEHG7FQ' 
local function run(msg, matches)
 if matches[1]:lower() == 'clan' or matches[1]:lower() == 'clash' or matches[1]:lower() == 'clantag' or matches[1]:lower() == 'tag' then
  local clantag = matches[2]
  if string.match(matches[2], '^#.+$') then
     clantag = string.gsub(matches[2], '#', '')
  end
  clantag = string.upper(clantag)
  local curl = 'curl -X GET --header "Accept: application/json" --header "authorization: Bearer '..apikey..'" "https://api.clashofclans.com/v1/clans/%23'..clantag..'"'
  cmd = io.popen(curl)
  
  local result = cmd:read('*all')
  local jdat = json:decode(result)
if jdat.reason then
      if jdat.reason == 'accessDenied' then return 'For the record API Key Go to site\ndeveloper.clashofclans.com' end
   return '#Error\n'..jdat.reason
  end
  local text = 'Clan Tag: '.. jdat.tag
     text = text..'\nClan Name: '.. jdat.name
     text = text..'\nDescription: '.. jdat.description
     text = text..'\nType: '.. jdat.type
     text = text..'\nWar Frequency: '.. jdat.warFrequency
     text = text..'\nClan Level: '.. jdat.clanLevel
     text = text..'\nWar Wins: '.. jdat.warWins
     text = text..'\nClan Points: '.. jdat.clanPoints
     text = text..'\nRequired Trophies: '.. jdat.requiredTrophies
     text = text..'\nMembers: '.. jdat.members
     text = text..'\n\n@WaderTGTeam'
     cmd:close()
  return text
 end
 if matches[1]:lower() == 'members' or matches[1]:lower() == 'clashmembers' or matches[1]:lower() == 'clanmembers' then
  local members = matches[2]
  if string.match(matches[2], '^#.+$') then
     members = string.gsub(matches[2], '#', '')
  end
  members = string.upper(members)
  local curl = 'curl -X GET --header "Accept: application/json" --header "authorization: Bearer '..apikey..'" "https://api.clashofclans.com/v1/clans/%23'..members..'/members"'
  cmd = io.popen(curl)
  local result = cmd:read('*all')
  local jdat = json:decode(result)
  if jdat.reason then
      if jdat.reason == 'accessDenied' then return 'For the record API Key Go to site\ndeveloper.clashofclans.com' end
   return '#Error\n'..jdat.reason
  end
  local leader = ""
  local coleader = ""
  local items = jdat.items
  leader = 'Clan Moderators: \n'
   for i = 1, #items do
   if items[i].role == "leader" then
   leader = leader.."\nLeader: "..items[i].name.."\nLevel: "..items[i].expLevel
   end
   if items[i].role == "coLeader" then
   coleader = coleader.."\nCo-Leader: "..items[i].name.."\nLevel: "..items[i].expLevel
   end
  end
text = leader.."\n"..coleader.."\n\nClan Members:"
  for i = 1, #items do
  text = text..'\n'..i..'- '..items[i].name..'\nlevel: '..items[i].expLevel.."\n"
  end
  text = text.."\n\n@WaderTGTeam"
   cmd:close()
  return text
 end
end

return {
   patterns = {
"^[!/#](clash) (.*)$",
"^[!/#](clan) (.*)$",
"^[!/#](clantag) (.*)$",
"^[!/#](tag) (.*)$",
"^[!/#](clashmembers) (.*)$",
"^[!/#](clanmembers) (.*)$",
"^[!/#](members) (.*)$",
   },
   run = run
}
