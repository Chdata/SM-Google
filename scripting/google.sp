#pragma semicolon 1
#include <sourcemod>

#define PLUGIN_VERSION  "0x02"

public Plugin:myinfo = {
    name = "Google Search Command",
    author = "Chdata",
    description = "Allows players to perform google searches.",
    version = PLUGIN_VERSION,
    url = "http://steamcommunity.com/groups/tf2data"
};

public OnPluginStart()
{
    RegConsoleCmd("sm_google", cdGoogle);
    RegAdminCmd("sm_lmgtfy", cdLmgtfy, ADMFLAG_KICK);
    LoadTranslations("common.phrases");
}

public Action:cdGoogle(iClient, iArgc)
{
    if (!iArgc)
    {
        ReplyToCommand(iClient, "[SM] Usage: !google <search terms>");
        return Plugin_Handled;
    }

    if (!iClient)
    {
        ReplyToCommand(iClient, "[SM] Can't show html pages to console.");
        return Plugin_Handled;
    }

    decl String:szSearch[256], String:szLink[512];
    
    GetCmdArgString(szSearch, sizeof(szSearch));

    Format(szLink, sizeof(szLink), "https://www.google.com/search?q=%s", szSearch);

    ShowMOTDPanel(iClient, "Google Search", szLink, MOTDPANEL_TYPE_URL);

    return Plugin_Handled;
}

public Action:cdLmgtfy(iClient, iArgc)
{
    if (iArgc < 2)
    {
        ReplyToCommand(iClient, "[SM] Usage: !lmgtfy \"player name\" <search terms>");
        return Plugin_Handled;
    }

    decl String:szCmd[256];
    GetCmdArgString(szCmd, sizeof(szCmd));

    decl String:szExplode[2][256];
    ExplodeString(szCmd, " ", szExplode, sizeof(szExplode), sizeof(szExplode[]), true);

    new iTarget = FindTarget(iClient, szExplode[0], true, false);

    if (iTarget <= 0)
    {
        ReplyToCommand(iClient, "[SM] Could not find player \"%s\"", szExplode[0]);
        return Plugin_Handled;
    }

    decl String:szLink[512];
    Format(szLink, sizeof(szLink), "http://lmgtfy.com/?q=%s", szExplode[1]);

    ShowMOTDPanel(iTarget, "LMGTFY", szLink, MOTDPANEL_TYPE_URL);
    return Plugin_Handled;
}