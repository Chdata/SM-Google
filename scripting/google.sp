#pragma semicolon 1
#include <sourcemod>

#define PLUGIN_VERSION  "0x01"

public Plugin:myinfo = {
    name = "Allows players to perform google searches.",
    author = "Chdata",
    description = "Hexy.",
    version = PLUGIN_VERSION,
    url = "http://steamcommunity.com/groups/tf2data"
};

public OnPluginStart()
{
    RegConsoleCmd("sm_google", cdGoogle);
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