Blackwake server for Docker
===========================

Config Files
------------

The following files in `/blackwake` should be mounted to the host filesystem:

* Admin.txt
* Banner.jpg (optional)
* Bans.txt
* CaptainLeaderboard.txt (optional)
* Mod.txt
* Server.cfg
* ServerAnnouncements.txt
* ServerMessage.txt

Most of these files will be generated by the server on first run if not present.


**Admin.txt**

Uses [SteamID64 format](https://steamid.io/) in the form of `username=id`. For example:

* CaptainKidd=763655178145125746

Admins can use `/restart` to force a server restart from ingame, or `/endround` to end the current round


**Banner.jpg**

Optional, dimensions are 500 by 80 pixels


**Bans.txt**

Generated by server, uses same format as Admin.txt


**CaptainLeaderboard.txt**

Generated by server, useful to mount if you want leaderboard data external to container


**Mod.txt**

Can be added to using in-game options, uses same format as Admin.txt


**Server.cfg**

* serverName - Name of the server as seen on the server list
* useIp - the ip you want incoming connections on, leave blank for default
* port - Game server port
* sport - Steam game server port
* hideFromList - Hide this server from the server list
* restartHour - The hour of the day (0-23) when the server should auto restart to prevent time inaccuracies, set to -1 to disable
* password - Password
* gamemode - Game mode to run, 1 TDM 16, 2 TDM 32, 3 -, 4 -, 5 TDM Hoy 2v2, 6 TDM Galleon 2v2, 7 Fleet, 8 CTB, 9 TT
* friendlyPlayerCollision - Friendly players bump into each other, this can sometimes launch players
* friendlySpreadFires - Requies the above setting to be on, and will spread fires between friendly players that bump into eachother
* friendlyFire - Friendly fire
* friendlyShipDamage - Cause damage to friendly ships
* forceEqualFactions - Will only give new players the option to join the faction with less players
* shipSpeedFactor - Speed of the ships, 1 is default, 0.5 is 50%, 2 is 200% etc
* playerUpdateRate - Times per second player positions are updated. Minimum of 10. Increasing this uses more network usage but will reduce sliding/delay during melee fighting
* allowGlobalVoice - by default players can only use global during voting and the win screen (0) changing this to (1) will allow it during the round


**ServerAnnouncements.txt**

Random lines in this file will be broadcasted in the chatbox every 2 minutes.


**ServerMessage.txt**

Message displayed when players first join with server rules. Discord link can be added with format `discordLink=discordInviteUrl`. Must end with `--end--`.



Build Notes
-----------
* Xvfb is used because Blackwake will not boot fully without a display server present, even with `-nographics` set.
* The server outputs a lot of debug messages, there doesn't appear to be a way to disable this currently.
