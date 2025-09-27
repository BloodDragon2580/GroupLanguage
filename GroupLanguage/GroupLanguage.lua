-- GroupLanguage Addon - Improved Version
local ADDON_NAME = "GroupLanguage"
local VERSION = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version") or "1.0"

-- Namespace für bessere Organisation
local GroupLanguage = {}
GroupLanguage.db = {}

-- Lokalisierung System
local L = {}

-- Locale Detection
local function GetClientLocale()
    return GetLocale() or "enUS"
end

-- Lokalisierungstabellen
local LOCALIZATION = {
    enUS = {
        -- Sprachen
        ["English"] = "English",
        ["German"] = "German", 
        ["French"] = "French",
        ["Spanish"] = "Spanish",
        ["Portuguese"] = "Portuguese",
        ["Russian"] = "Russian",
        ["Italian"] = "Italian",
        ["Unknown"] = "Unknown",
        ["Russian/Other"] = "Russian/Other",
        
        -- Interface
        ["ADDON_LOADED"] = "%s version %s loaded!",
        ["NO_GROUP_MEMBERS"] = "No group members found.",
        ["GROUP_LANGUAGES"] = "Group Languages:",
        ["LEFT_GROUP"] = "Left group.",
        ["SHOW_MINIMAP_BUTTON"] = "Show Minimap Button",
        ["HIDE_MINIMAP_BUTTON"] = "Hide Minimap Button", 
        ["TEST_LANGUAGE_REPORT"] = "Test Language Report",
        ["MINIMAP_TOOLTIP_TITLE"] = "GroupLanguage",
        ["MINIMAP_TOOLTIP_CLICK"] = "Left-click: Show language report",
        ["MINIMAP_TOOLTIP_DRAG"] = "Drag: Move button",
        
        -- Commands
        ["COMMANDS_HELP"] = "GroupLanguage Commands:",
        ["COMMAND_SHOW"] = "/gl or /gl show - Show language report",
        ["COMMAND_HELP"] = "/gl help - Show this help",
        ["UNKNOWN_COMMAND"] = "Unknown command. Type '/gl help' for help."
    },
    
    deDE = {
        -- Sprachen
        ["English"] = "Englisch",
        ["German"] = "Deutsch",
        ["French"] = "Französisch", 
        ["Spanish"] = "Spanisch",
        ["Portuguese"] = "Portugiesisch",
        ["Russian"] = "Russisch",
        ["Italian"] = "Italienisch",
        ["Unknown"] = "Unbekannt",
        ["Russian/Other"] = "Russisch/Andere",
        
        -- Interface
        ["ADDON_LOADED"] = "%s Version %s geladen!",
        ["NO_GROUP_MEMBERS"] = "Keine Gruppenmitglieder gefunden.",
        ["GROUP_LANGUAGES"] = "Gruppensprachen:",
        ["LEFT_GROUP"] = "Gruppe verlassen.",
        ["SHOW_MINIMAP_BUTTON"] = "Minimap-Button anzeigen",
        ["HIDE_MINIMAP_BUTTON"] = "Minimap-Button verstecken",
        ["TEST_LANGUAGE_REPORT"] = "Sprachen-Report testen",
        ["MINIMAP_TOOLTIP_TITLE"] = "GruppenSprache",
        ["MINIMAP_TOOLTIP_CLICK"] = "Linksklick: Sprachen-Report anzeigen",
        ["MINIMAP_TOOLTIP_DRAG"] = "Ziehen: Button bewegen",
        
        -- Commands  
        ["COMMANDS_HELP"] = "GruppenSprache Befehle:",
        ["COMMAND_SHOW"] = "/gl oder /gl show - Sprachen-Report anzeigen",
        ["COMMAND_HELP"] = "/gl help - Diese Hilfe anzeigen", 
        ["UNKNOWN_COMMAND"] = "Unbekannter Befehl. Tippe '/gl help' für Hilfe."
    },
    
    frFR = {
        -- Sprachen
        ["English"] = "Anglais",
        ["German"] = "Allemand",
        ["French"] = "Français",
        ["Spanish"] = "Espagnol", 
        ["Portuguese"] = "Portugais",
        ["Russian"] = "Russe",
        ["Italian"] = "Italien",
        ["Unknown"] = "Inconnu",
        ["Russian/Other"] = "Russe/Autre",
        
        -- Interface
        ["ADDON_LOADED"] = "%s version %s chargé !",
        ["NO_GROUP_MEMBERS"] = "Aucun membre de groupe trouvé.",
        ["GROUP_LANGUAGES"] = "Langues du groupe :",
        ["LEFT_GROUP"] = "Groupe quitté.",
        ["SHOW_MINIMAP_BUTTON"] = "Afficher le bouton minimap",
        ["HIDE_MINIMAP_BUTTON"] = "Masquer le bouton minimap",
        ["TEST_LANGUAGE_REPORT"] = "Tester le rapport des langues",
        ["MINIMAP_TOOLTIP_TITLE"] = "LangueGroupe",
        ["MINIMAP_TOOLTIP_CLICK"] = "Clic gauche : Afficher le rapport des langues",
        ["MINIMAP_TOOLTIP_DRAG"] = "Glisser : Déplacer le bouton",
        
        -- Commands
        ["COMMANDS_HELP"] = "Commandes LangueGroupe :",
        ["COMMAND_SHOW"] = "/gl ou /gl show - Afficher le rapport des langues",
        ["COMMAND_HELP"] = "/gl help - Afficher cette aide",
        ["UNKNOWN_COMMAND"] = "Commande inconnue. Tapez '/gl help' pour l'aide."
    },
    
    esES = {
        -- Sprachen
        ["English"] = "Inglés",
        ["German"] = "Alemán",
        ["French"] = "Francés",
        ["Spanish"] = "Español",
        ["Portuguese"] = "Portugués", 
        ["Russian"] = "Ruso",
        ["Italian"] = "Italiano",
        ["Unknown"] = "Desconocido",
        ["Russian/Other"] = "Ruso/Otro",
        
        -- Interface
        ["ADDON_LOADED"] = "¡%s versión %s cargado!",
        ["NO_GROUP_MEMBERS"] = "No se encontraron miembros del grupo.",
        ["GROUP_LANGUAGES"] = "Idiomas del grupo:",
        ["LEFT_GROUP"] = "Grupo abandonado.",
        ["SHOW_MINIMAP_BUTTON"] = "Mostrar botón del minimapa",
        ["HIDE_MINIMAP_BUTTON"] = "Ocultar botón del minimapa",
        ["TEST_LANGUAGE_REPORT"] = "Probar informe de idiomas",
        ["MINIMAP_TOOLTIP_TITLE"] = "IdiomaGrupo",
        ["MINIMAP_TOOLTIP_CLICK"] = "Clic izquierdo: Mostrar informe de idiomas",
        ["MINIMAP_TOOLTIP_DRAG"] = "Arrastrar: Mover botón",
        
        -- Commands
        ["COMMANDS_HELP"] = "Comandos IdiomaGrupo:",
        ["COMMAND_SHOW"] = "/gl o /gl show - Mostrar informe de idiomas",
        ["COMMAND_HELP"] = "/gl help - Mostrar esta ayuda",
        ["UNKNOWN_COMMAND"] = "Comando desconocido. Escribe '/gl help' para ayuda."
    },
    
    ptBR = {
        -- Sprachen
        ["English"] = "Inglês",
        ["German"] = "Alemão",
        ["French"] = "Francês", 
        ["Spanish"] = "Espanhol",
        ["Portuguese"] = "Português",
        ["Russian"] = "Russo",
        ["Italian"] = "Italiano",
        ["Unknown"] = "Desconhecido",
        ["Russian/Other"] = "Russo/Outro",
        
        -- Interface
        ["ADDON_LOADED"] = "%s versão %s carregado!",
        ["NO_GROUP_MEMBERS"] = "Nenhum membro do grupo encontrado.",
        ["GROUP_LANGUAGES"] = "Idiomas do grupo:",
        ["LEFT_GROUP"] = "Grupo abandonado.",
        ["SHOW_MINIMAP_BUTTON"] = "Mostrar botão do minimapa",
        ["HIDE_MINIMAP_BUTTON"] = "Esconder botão do minimapa",
        ["TEST_LANGUAGE_REPORT"] = "Testar relatório de idiomas",
        ["MINIMAP_TOOLTIP_TITLE"] = "IdiomaGrupo",
        ["MINIMAP_TOOLTIP_CLICK"] = "Clique esquerdo: Mostrar relatório de idiomas",
        ["MINIMAP_TOOLTIP_DRAG"] = "Arrastar: Mover botão",
        
        -- Commands
        ["COMMANDS_HELP"] = "Comandos IdiomaGrupo:",
        ["COMMAND_SHOW"] = "/gl ou /gl show - Mostrar relatório de idiomas",
        ["COMMAND_HELP"] = "/gl help - Mostrar esta ajuda",
        ["UNKNOWN_COMMAND"] = "Comando desconhecido. Digite '/gl help' para ajuda."
    },
    
    ruRU = {
        -- Sprachen
        ["English"] = "Английский",
        ["German"] = "Немецкий",
        ["French"] = "Французский",
        ["Spanish"] = "Испанский",
        ["Portuguese"] = "Португальский",
        ["Russian"] = "Русский",
        ["Italian"] = "Итальянский", 
        ["Unknown"] = "Неизвестно",
        ["Russian/Other"] = "Русский/Другие",
        
        -- Interface
        ["ADDON_LOADED"] = "%s версия %s загружен!",
        ["NO_GROUP_MEMBERS"] = "Участники группы не найдены.",
        ["GROUP_LANGUAGES"] = "Языки группы:",
        ["LEFT_GROUP"] = "Покинул группу.",
        ["SHOW_MINIMAP_BUTTON"] = "Показать кнопку миникарты",
        ["HIDE_MINIMAP_BUTTON"] = "Скрыть кнопку миникарты",
        ["TEST_LANGUAGE_REPORT"] = "Тестировать отчет языков",
        ["MINIMAP_TOOLTIP_TITLE"] = "ЯзыкГруппы",
        ["MINIMAP_TOOLTIP_CLICK"] = "ЛКМ: Показать отчет языков",
        ["MINIMAP_TOOLTIP_DRAG"] = "Перетащить: Переместить кнопку",
        
        -- Commands
        ["COMMANDS_HELP"] = "Команды ЯзыкГруппы:",
        ["COMMAND_SHOW"] = "/gl или /gl show - Показать отчет языков",
        ["COMMAND_HELP"] = "/gl help - Показать эту справку",
        ["UNKNOWN_COMMAND"] = "Неизвестная команда. Введите '/gl help' для справки."
    },
    
    itIT = {
        -- Sprachen
        ["English"] = "Inglese",
        ["German"] = "Tedesco",
        ["French"] = "Francese",
        ["Spanish"] = "Spagnolo",
        ["Portuguese"] = "Portoghese",
        ["Russian"] = "Russo", 
        ["Italian"] = "Italiano",
        ["Unknown"] = "Sconosciuto",
        ["Russian/Other"] = "Russo/Altro",
        
        -- Interface
        ["ADDON_LOADED"] = "%s versione %s caricato!",
        ["NO_GROUP_MEMBERS"] = "Nessun membro del gruppo trovato.",
        ["GROUP_LANGUAGES"] = "Lingue del gruppo:",
        ["LEFT_GROUP"] = "Gruppo abbandonato.",
        ["SHOW_MINIMAP_BUTTON"] = "Mostra pulsante minimappa",
        ["HIDE_MINIMAP_BUTTON"] = "Nascondi pulsante minimappa",
        ["TEST_LANGUAGE_REPORT"] = "Testa rapporto lingue",
        ["MINIMAP_TOOLTIP_TITLE"] = "LinguaGruppo", 
        ["MINIMAP_TOOLTIP_CLICK"] = "Clic sinistro: Mostra rapporto lingue",
        ["MINIMAP_TOOLTIP_DRAG"] = "Trascina: Muovi pulsante",
        
        -- Commands
        ["COMMANDS_HELP"] = "Comandi LinguaGruppo:",
        ["COMMAND_SHOW"] = "/gl o /gl show - Mostra rapporto lingue",
        ["COMMAND_HELP"] = "/gl help - Mostra questo aiuto",
        ["UNKNOWN_COMMAND"] = "Comando sconosciuto. Digita '/gl help' per aiuto."
    }
}

-- Lokalisierungsfunktion
local function GetLocalizedString(key, ...)
    local locale = GetClientLocale()
    local localeTable = LOCALIZATION[locale] or LOCALIZATION.enUS
    local text = localeTable[key] or LOCALIZATION.enUS[key] or key
    
    if ... then
        return string.format(text, ...)
    end
    return text
end

-- Shorthand function
local function L(key, ...)
    return GetLocalizedString(key, ...)
end

-- Konstanten
local MINIMAP_BUTTON_RADIUS = 80
local DEFAULT_MINIMAP_POS = 0
local FRAME_LEVEL_HIGH = 200

-- Server-Sprach-Zuordnungen (vollständig)
local SERVER_LANGUAGES = {
    US = {
        -- US/Americas Server
        ["Aegwynn"] = "English",
        ["AeriePeak"] = "English",
        ["Agamaggan"] = "English",
        ["Aggramar"] = "English",
        ["Akama"] = "English",
        ["Alexstrasza"] = "English",
        ["Alleria"] = "English",
        ["AltarofStorms"] = "English",
        ["AlteracMountains"] = "English",
        ["Aman'thul"] = "English",
        ["Andorhal"] = "English",
        ["Anetheron"] = "English",
        ["Antonidas"] = "English",
        ["Anub'arak"] = "English",
        ["Anvilmar"] = "English",
        ["Arathor"] = "English",
        ["Archimonde"] = "English",
        ["Area52"] = "English",
        ["ArgentDawn"] = "English",
        ["Arthas"] = "English",
        ["Arygos"] = "English",
        ["Auchindoun"] = "English",
        ["Azgalor"] = "English",
        ["Azjol-Nerub"] = "English",
        ["Azralon"] = "Portuguese",
        ["Azshara"] = "English",
        ["Azuremyst"] = "English",
        ["Baelgun"] = "English",
        ["Balnazzar"] = "English",
        ["Barthilas"] = "English",
        ["BlackDragonflight"] = "English",
        ["Blackhand"] = "English",
        ["Blackrock"] = "English",
        ["BlackwaterRaiders"] = "English",
        ["BlackwingLair"] = "English",
        ["Blade'sEdge"] = "English",
        ["Bladefist"] = "English",
        ["BleedingHollow"] = "English",
        ["BloodFurnace"] = "English",
        ["Bloodhoof"] = "English",
        ["Bloodscalp"] = "English",
        ["Bonechewer"] = "English",
        ["BoreanTundra"] = "English",
        ["Boulderfist"] = "English",
        ["Bronzebeard"] = "English",
        ["Burning Blade"] = "English",
        ["Burning Legion"] = "English",
        ["Caelestrasz"] = "English",
        ["Cairne"] = "English",
        ["CenarionCircle"] = "English",
        ["Cenarius"] = "English",
        ["Cho'gall"] = "English",
        ["Chromaggus"] = "English",
        ["Coilfang"] = "English",
        ["Crushridge"] = "English",
        ["Daggerspine"] = "English",
        ["Dalaran"] = "English",
        ["Dalvengyr"] = "English",
        ["Dark Iron"] = "English",
        ["Darkspear"] = "English",
        ["Darrowmere"] = "English",
        ["Dath'Remar"] = "English",
        ["Dawnbringer"] = "English",
        ["Deathwing"] = "English",
        ["Demon Soul"] = "English",
        ["Dentarg"] = "English",
        ["Destromath"] = "English",
        ["Dethecus"] = "English",
        ["Detheroc"] = "English",
        ["Doomhammer"] = "English",
        ["Draenor"] = "English",
        ["Dragonblight"] = "English",
        ["Dragonmaw"] = "English",
        ["Drak'Tharon"] = "English",
        ["Drak'thul"] = "English",
        ["Draka"] = "English",
        ["Drakkari"] = "Portuguese",
        ["Dreadmaul"] = "English",
        ["Drenden"] = "English",
        ["Dunemaul"] = "English",
        ["Durotan"] = "English",
        ["Duskwood"] = "English",
        ["EarthenRing"] = "English",
        ["Echo Isles"] = "English",
        ["Eitrigg"] = "English",
        ["Eldre'Thalas"] = "English",
        ["Elune"] = "English",
        ["Emerald Dream"] = "English",
        ["Eonar"] = "English",
        ["Eredar"] = "English",
        ["Executus"] = "English",
        ["Exodar"] = "English",
        ["Farstriders"] = "English",
        ["Feathermoon"] = "English",
        ["Fenris"] = "English",
        ["Firetree"] = "English",
        ["Fizzcrank"] = "English",
        ["Frostmane"] = "English",
        ["Frostmourne"] = "English",
        ["Frostwolf"] = "English",
        ["Galakrond"] = "English",
        ["Gallywix"] = "Portuguese",
        ["Garithos"] = "English",
        ["Garona"] = "English",
        ["Garrosh"] = "English",
        ["Ghostlands"] = "English",
        ["Gilneas"] = "English",
        ["Gnomeregan"] = "English",
        ["Goldrinn"] = "Russian",
        ["Gorefiend"] = "English",
        ["Gorgonnash"] = "English",
        ["Greymane"] = "English",
        ["GrizzlyHills"] = "English",
        ["Gul'dan"] = "English",
        ["Gundrak"] = "English",
        ["Gurubashi"] = "English",
        ["Hakkar"] = "English",
        ["Haomarush"] = "English",
        ["Hellscream"] = "English",
        ["Hydraxis"] = "English",
        ["Hyjal"] = "English",
        ["Icecrown"] = "English",
        ["Illidan"] = "English",
        ["Jaedenar"] = "English",
        ["Jubei'Thos"] = "English",
        ["Kael'thas"] = "English",
        ["Kalecgos"] = "English",
        ["Kargath"] = "English",
        ["Kel'Thuzad"] = "English",
        ["Khadgar"] = "English",
        ["Khaz Modan"] = "English",
        ["Khaz'goroth"] = "English",
        ["Kil'jaeden"] = "English",
        ["Kilrogg"] = "English",
        ["Kirin Tor"] = "English",
        ["Korgath"] = "English",
        ["KulTiras"] = "English",
        ["Korialstrasz"] = "English",
        ["Laughing Skull"] = "English",
        ["Lethon"] = "English",
        ["Lightbringer"] = "English",
        ["Lightning'sBlade"] = "English",
        ["Lightninghoof"] = "English",
        ["Llane"] = "English",
        ["Lothar"] = "English",
        ["Madoran"] = "English",
        ["Maelstrom"] = "English",
        ["Magtheridon"] = "English",
        ["Maiev"] = "English",
        ["Mal'Ganis"] = "English",
        ["Malfurion"] = "English",
        ["Malorne"] = "English",
        ["Malygos"] = "English",
        ["Mannoroth"] = "English",
        ["Medivh"] = "English",
        ["Misha"] = "English",
        ["Mok'Nathal"] = "English",
        ["MoonGuard"] = "English",
        ["Moonrunner"] = "English",
        ["Mug'thol"] = "English",
        ["Muradin"] = "English",
        ["Nagrand"] = "English",
        ["Nathrezim"] = "English",
        ["Nazgrel"] = "English",
        ["Nazjatar"] = "English",
        ["Nemesis"] = "Portuguese",
        ["Ner'zhul"] = "English",
        ["Nesingwary"] = "English",
        ["Nordrassil"] = "English",
        ["Norgannon"] = "English",
        ["Onyxia"] = "English",
        ["Perenolde"] = "English",
        ["Proudmoore"] = "English",
        ["Quel'Thalas"] = "Spanish",
        ["Quel'dorei"] = "English",
        ["Ragnaros"] = "Spanish",
        ["Ravencrest"] = "English",
        ["Ravenholdt"] = "English",
        ["Rexxar"] = "English",
        ["Rivendare"] = "English",
        ["Runetotem"] = "English",
        ["Sargeras"] = "English",
        ["Saurfang"] = "English",
        ["ScarletCrusade"] = "English",
        ["Scilla"] = "English",
        ["Sen'jin"] = "English",
        ["Sentinels"] = "English",
        ["ShadowCouncil"] = "English",
        ["Shadowmoon"] = "English",
        ["Shadowsong"] = "English",
        ["Shandris"] = "English",
        ["Shattered Halls"] = "English",
        ["Shattered Hand"] = "English",
        ["Shu'halo"] = "English",
        ["Silver Hand"] = "English",
        ["Silvermoon"] = "English",
        ["SistersofElune"] = "English",
        ["Skullcrusher"] = "English",
        ["Skywall"] = "English",
        ["Smolderthorn"] = "English",
        ["Spinebreaker"] = "English",
        ["Spirestone"] = "English",
        ["Staghelm"] = "English",
        ["SteamwheedleCartel"] = "English",
        ["Stonemaul"] = "English",
        ["Stormrage"] = "English",
        ["Stormreaver"] = "English",
        ["Stormscale"] = "English",
        ["Suramar"] = "English",
        ["Tanaris"] = "English",
        ["Terenas"] = "English",
        ["Terokkar"] = "English",
        ["Thaurissan"] = "English",
        ["TheForgottenCoast"] = "English",
        ["TheScryers"] = "English",
        ["TheUnderbog"] = "English",
        ["TheVentureCo"] = "English",
        ["ThoriumBrotherhood"] = "English",
        ["Thrall"] = "English",
        ["Thunderhorn"] = "English",
        ["Thunderlord"] = "English",
        ["Tichondrius"] = "English",
        ["TolBarad"] = "Portuguese",
        ["Tortheldrin"] = "English",
        ["Trollbane"] = "English",
        ["Turalyon"] = "English",
        ["Twisting Nether"] = "English",
        ["Uldaman"] = "English",
        ["Uldum"] = "English",
        ["Undermine"] = "English",
        ["Ursin"] = "English",
        ["Uther"] = "English",
        ["Vashj"] = "English",
        ["Vek'nilash"] = "English",
        ["Velen"] = "English",
        ["Warsong"] = "English",
        ["Whisperwind"] = "English",
        ["Wildhammer"] = "English",
        ["Windrunner"] = "English",
        ["Winterhoof"] = "English",
        ["WyrmrestAccord"] = "English",
        ["Ysera"] = "English",
        ["Ysondre"] = "English",
        ["Zangarmarsh"] = "English",
        ["Zul'jin"] = "English",
        ["Zuluhed"] = "English",
        DEFAULT = "English"
    },
    
    EU = {
        -- European Server
        ["Aegwynn"] = "German",
        ["AeriePeak"] = "English",
        ["Agamaggan"] = "English",
        ["Aggra(Português)"] = "Portuguese",
        ["Aggramar"] = "English",
        ["Ahn'Qiraj"] = "English",
        ["Al'Akir"] = "English",
        ["Alexstrasza"] = "German",
        ["Alleria"] = "German",
        ["Alonsus"] = "English",
        ["Aman'thul"] = "German",
        ["Ambossar"] = "German",
        ["Anachronos"] = "English",
        ["Anetheron"] = "German",
        ["Antonidas"] = "German",
        ["Anub'arak"] = "German",
        ["Arakarahm"] = "French",
        ["Arathi"] = "French",
        ["Arathor"] = "English",
        ["Archimonde"] = "French",
        ["Area52"] = "German",
        ["ArgentDawn"] = "English",
        ["Arthas"] = "German",
        ["Arygos"] = "German",
        ["Ashenvale"] = "Russian",
        ["Aszune"] = "English",
        ["Auchindoun"] = "English",
        ["AzjolNerub"] = "English",
        ["Azshara"] = "German",
        ["Borean Tundra"] = "Russian",
        ["Azuremyst"] = "English",
        ["Baelgun"] = "German",
        ["Balnazzar"] = "English",
        ["Blackhand"] = "German",
        ["Blackmoore"] = "German",
        ["Blackrock"] = "German",
        ["Blackscar"] = "Russian",
        ["Blade'sEdge"] = "English",
        ["Bladefist"] = "English",
        ["Bloodfeather"] = "English",
        ["Bloodhoof"] = "English",
        ["Bloodscalp"] = "English",
        ["Blutkessel"] = "German",
        ["BootyBay"] = "Russian",
        ["BoreanTundra"] = "Russian",
        ["Boulderfist"] = "English",
        ["BronzeDragonflight"] = "English",
        ["Bronzebeard"] = "English",
        ["BurningBlade"] = "English",
        ["BurningLegion"] = "English",
        ["BurningSteppes"] = "English",
        ["C'Thun"] = "Spanish",
        ["ChamberofAspects"] = "English",
        ["Chants éternels"] = "French",
        ["Cho'gall"] = "French",
        ["Chromaggus"] = "English",
        ["ColinasPardas"] = "Spanish",
        ["Confrérie du Thorium"] = "French",
        ["ConseildesOmbres"] = "French",
        ["Crushridge"] = "English",
        ["CultedelaRivenoire"] = "French",
        ["Daggerspine"] = "English",
        ["Dalaran"] = "French",
        ["Dalvengyr"] = "German",
        ["DarkmoonFaire"] = "English",
        ["Darksorrow"] = "English",
        ["Darkspear"] = "English",
        ["DasKonsortium"] = "German",
        ["DasSyndikat"] = "German",
        ["Deathguard"] = "Russian",
        ["Deathweaver"] = "Russian",
        ["Deepholm"] = "Russian",
        ["DefiasBrotherhood"] = "English",
        ["Dentarg"] = "English",
        ["DerAbyssischeRat"] = "German",
        ["DerMithrilorden"] = "German",
        ["DerRatvonDalaran"] = "German",
        ["Destromath"] = "German",
        ["DieAldor"] = "German",
        ["Dethecus"] = "German",
        ["DieArguswacht"] = "German",
        ["DieewigeWacht"] = "German",
        ["DieNachtwache"] = "German",
        ["DieSilberneHand"] = "German",
        ["DieTodeskrallen"] = "German",
        ["Doomhammer"] = "English",
        ["Draenor"] = "English",
        ["Dragonblight"] = "English",
        ["Dragonmaw"] = "English",
        ["Drak'thul"] = "English",
        ["Drek'Thar"] = "French",
        ["DunModr"] = "Spanish",
        ["DunMorogh"] = "German",
        ["Dunemaul"] = "English",
        ["Durotan"] = "German",
        ["EarthenRing"] = "English",
        ["Echsenkessel"] = "German",
        ["Eitrigg"] = "French",
        ["Eldre'Thalas"] = "French",
        ["Elune"] = "French",
        ["EmeraldDream"] = "English",
        ["Emeriss"] = "English",
        ["Eonar"] = "English",
        ["Eredar"] = "German",
        ["Eversong"] = "Russian",
        ["Executus"] = "English",
        ["Exodar"] = "Spanish",
        ["FestungderSturme"] = "German",
        ["Fordragon"] = "Russian",
        ["Forscherliga"] = "German",
        ["Frostmane"] = "English",
        ["Frostmourne"] = "German",
        ["Frostwhisper"] = "English",
        ["Frostwolf"] = "German",
        ["Galakrond"] = "Russian",
        ["Garona"] = "French",
        ["Garrosh"] = "German",
        ["Genjuros"] = "English",
        ["Ghostlands"] = "English",
        ["Gilneas"] = "German",
        ["Goldrinn"] = "Russian",
        ["Gordunni"] = "Russian",
        ["Gorgonnash"] = "German",
        ["Greymane"] = "Russian",
        ["GrimBatol"] = "English",
        ["Grom"] = "Russian",
        ["Gul'dan"] = "German",
        ["Hakkar"] = "English",
        ["Haomarush"] = "English",
        ["Hellfire"] = "English",
        ["Hellscream"] = "English",
        ["HowlingFjord"] = "Russian",
        ["Hyjal"] = "French",
        ["Illidan"] = "French",
        ["Jaedenar"] = "English",
        ["Kael'thas"] = "French",
        ["Karazhan"] = "English",
        ["Kargath"] = "German",
        ["Kazzak"] = "English",
        ["Kel'Thuzad"] = "German",
        ["Khadgar"] = "English",
        ["KhazModan"] = "French",
        ["Khaz'goroth"] = "German",
        ["Kil'jaeden"] = "German",
        ["Kilrogg"] = "English",
        ["KirinTor"] = "French",
        ["Kor'gall"] = "English",
        ["Krag'jin"] = "German",
        ["Krasus"] = "French",
        ["KultderVerdammten"] = "German",
        ["LaCroisadeecarlate"] = "French",
        ["LaughingSkull"] = "English",
        ["LesClairvoyants"] = "French",
        ["LesSentinelles"] = "French",
        ["LichKing"] = "Russian",
        ["Lightbringer"] = "English",
        ["Lighning'sBlade"] = "English",
        ["Lordaeron"] = "German",
        ["LosErrantes"] = "Spanish",
        ["Lothar"] = "German",
        ["Madmortem"] = "German",
        ["Magtheridon"] = "English",
        ["Mal'Ganis"] = "German",
        ["Malfurion"] = "German",
        ["Malorne"] = "German",
        ["Malygos"] = "German",
        ["Mannoroth"] = "German",
        ["MarecagedeZangar"] = "French",
        ["Mazrigos"] = "English",
        ["Medivh"] = "French",
        ["Minahonda"] = "Spanish",
        ["Moonglade"] = "English",
        ["Mug'thol"] = "German",
        ["Nagrand"] = "English",
        ["Nathrezim"] = "German",
        ["Naxxramas"] = "French",
        ["Nazjatar"] = "German",
        ["Nefarian"] = "German",
        ["Nemesis"] = "Italian",
        ["Neptulon"] = "English",
        ["Ner'zhul"] = "French",
        ["Nera'thor"] = "German",
        ["Nethersturm"] = "German",
        ["Nordrassil"] = "English",
        ["Norgannon"] = "German",
        ["Nozdormu"] = "German",
        ["Onyxia"] = "German",
        ["Outland"] = "English",
        ["Perenolde"] = "German",
        ["PozzodellEternita"] = "Italian",
        ["Proudmoore"] = "German",
        ["Quel'Thalas"] = "English",
        ["Ragnaros"] = "English",
        ["Rajaxx"] = "German",
        ["Rashgarroth"] = "French",
        ["Ravencrest"] = "English",
        ["Ravenholdt"] = "English",
        ["Razuvious"] = "Russian",
        ["Rexxar"] = "German",
        ["Runetotem"] = "English",
        ["Sanguino"] = "Spanish",
        ["Sargeras"] = "French",
        ["Saurfang"] = "English",
        ["ScarshieldLegion"] = "English",
        ["Sen'jin"] = "German",
        ["Shadowsong"] = "English",
        ["ShatteredHalls"] = "English",
        ["ShatteredHand"] = "English",
        ["Shattrath"] = "German",
        ["Shen'dralar"] = "Spanish",
        ["Silvermoon"] = "English",
        ["Sinstralis"] = "French",
        ["Skullcrusher"] = "English",
        ["Soulflayer"] = "Russian",
        ["Spinebreaker"] = "English",
        ["Sporeggar"] = "English",
        ["SteamwheedleCartel"] = "English",
        ["Stormrage"] = "English",
        ["Stormreaver"] = "English",
        ["Stormscale"] = "English",
        ["Sunstrider"] = "English",
        ["Suramar"] = "French",
        ["Sylvanas"] = "English",
        ["Taerar"] = "German",
        ["Talnivarr"] = "English",
        ["TarrenMill"] = "English",
        ["Teldrassil"] = "German",
        ["Templenoir"] = "French",
        ["Terenas"] = "English",
        ["Terokkar"] = "English",
        ["Terrordar"] = "German",
        ["TheMaelstrom"] = "English",
        ["TheSha'tar"] = "English",
        ["TheVenture Co"] = "English",
        ["Theradras"] = "German",
        ["Thermaplugg"] = "Russian",
        ["Thrall"] = "German",
        ["Throk'Feroth"] = "French",
        ["Thunderhorn"] = "English",
        ["Tichondrius"] = "German",
        ["Tirion"] = "German",
        ["Todeswache"] = "German",
        ["Trollbane"] = "English",
        ["Turalyon"] = "English",
        ["Twilight'sHammer"] = "English",
        ["TwistingNether"] = "English",
        ["Tyrande"] = "Spanish",
        ["Uldaman"] = "French",
        ["Ulduar"] = "German",
        ["Uldum"] = "Spanish",
        ["Un'Goro"] = "German",
        ["Varimathras"] = "French",
        ["Vashj"] = "English",
        ["Vek'lor"] = "German",
        ["Vek'nilash"] = "English",
        ["Vol'jin"] = "French",
        ["Wildhammer"] = "English",
        ["Wrathbringer"] = "German",
        ["Xavius"] = "English",
        ["Ysera"] = "German",
        ["Ysondre"] = "French",
        ["Zenedar"] = "English",
        ["ZirkeldesCenarius"] = "German",
        ["Zul'jin"] = "Spanish",
        ["Zuluhed"] = "German",
        DEFAULT = "English"
    }
}

-- Utility-Funktionen
local function GetPortalRegion()
    return GetCVar('portal') or "US"
end

local function GetServerLanguage(realmName)
    if not realmName or realmName == "" then
        return L("Unknown")
    end
    
    local region = GetPortalRegion()
    local languages = SERVER_LANGUAGES[region]
    
    if not languages then
        return L("Unknown")
    end
    
    -- Direkter Lookup im entsprechenden Regionsarray
    local language = languages[realmName] or languages.DEFAULT
    
    -- Lokalisierte Sprachennamen zurückgeben
    return L(language)
end

-- Sortierte Iteration über Tabellen
local function spairs(t, orderFunction)
    local keys = {}
    for k in pairs(t) do
        table.insert(keys, k)
    end

    if orderFunction then
        table.sort(keys, function(a, b) return orderFunction(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- Hauptfunktionen
function GroupLanguage:GetGroupMembers()
    local members = {}
    
    -- Spieler selbst hinzufügen
    members[UnitGUID("player")] = true
    
    if GetNumGroupMembers() == 0 then
        return members
    end
    
    -- Raid-Mitglieder
    if IsInRaid() then
        for i = 1, 40 do
            local unit = "raid" .. i
            if UnitExists(unit) then
                members[UnitGUID(unit)] = true
            end
        end
    else
        -- Party-Mitglieder
        for i = 1, 4 do
            local unit = "party" .. i
            if UnitExists(unit) then
                members[UnitGUID(unit)] = true
            end
        end
    end
    
    return members
end

function GroupLanguage:AggregatePlayersByLanguage(playerList)
    local languageGroups = {}
    
    for guid in pairs(playerList) do
        local _, _, _, _, _, name, realm = GetPlayerInfoByGUID(guid)
        
        name = name and name ~= "" and name or L("Unknown")
        realm = realm and realm ~= "" and realm or GetRealmName()
        
        local language = GetServerLanguage(realm)
        
        if not languageGroups[language] then
            languageGroups[language] = {}
        end
        
        table.insert(languageGroups[language], string.format("%s-%s", name, realm))
    end
    
    return languageGroups
end

function GroupLanguage:FormatLanguageReport(languageGroups)
    local reportLines = {}
    
    for language, players in spairs(languageGroups) do
        table.sort(players) -- Alphabetisch sortieren
        
        local playerString = table.concat(players, ", ")
        local formattedLine = string.format("|cFF00f04d%s:|cffffcc00 %s", language, playerString)
        
        table.insert(reportLines, formattedLine)
    end
    
    return reportLines
end

function GroupLanguage:ShowLanguageReport()
    local members = self:GetGroupMembers()
    local languageGroups = self:AggregatePlayersByLanguage(members)
    local report = self:FormatLanguageReport(languageGroups)
    
    if #report == 0 then
        print("|cFFFF6600GroupLanguage:|r " .. L("NO_GROUP_MEMBERS"))
        return
    end
    
    print("|cFFFF6600GroupLanguage - " .. L("GROUP_LANGUAGES") .. "|r")
    for _, line in ipairs(report) do
        print(line)
    end
end

-- Minimap Button System
GroupLanguage.MinimapButton = {}

function GroupLanguage.MinimapButton:Initialize()
    self.settings = {
        position = GroupLanguage_SaveData or DEFAULT_MINIMAP_POS,
        visible = GroupLanguage_MinimapbuttonState ~= 0
    }
end

function GroupLanguage.MinimapButton:OnDragUpdate()
    if not GroupLanguageMButton then return end
    
    local scale = UIParent:GetScale()
    local x, y = GetCursorPosition()
    local cx, cy = Minimap:GetCenter()
    
    x, y = x / scale, y / scale
    
    local angle = math.deg(math.atan2(y - cy, x - cx))
    self.settings.position = angle
    self:UpdatePosition()
    
    GroupLanguage_SaveData = self.settings.position
end

function GroupLanguage.MinimapButton:UpdatePosition()
    if not GroupLanguageMButton then return end
    
    local angle = math.rad(self.settings.position)
    local x = MINIMAP_BUTTON_RADIUS * math.cos(angle)
    local y = MINIMAP_BUTTON_RADIUS * math.sin(angle)
    
    GroupLanguageMButton:ClearAllPoints()
    GroupLanguageMButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 52 - x, y - 52)
end

function GroupLanguage.MinimapButton:Show()
    if GroupLanguageMButton then
        GroupLanguageMButton:Show()
        GroupLanguageMButton:SetFrameLevel(FRAME_LEVEL_HIGH)
        self.settings.visible = true
        GroupLanguage_MinimapbuttonState = 1
    end
end

function GroupLanguage.MinimapButton:Hide()
    if GroupLanguageMButton then
        GroupLanguageMButton:Hide()
        self.settings.visible = false
        GroupLanguage_MinimapbuttonState = 0
    end
end

-- Interface Panel
function GroupLanguage:CreateInterfacePanel()
    local panel = CreateFrame("Frame", "GroupLanguageOptionsPanel", UIParent)
    panel.name = string.format("%s %s", ADDON_NAME, VERSION)
    
    -- Title
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(panel.name)
    
    -- Show Minimap Button
    local showBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    showBtn:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20)
    showBtn:SetSize(160, 22)
    showBtn:SetText(L("SHOW_MINIMAP_BUTTON"))
    showBtn:SetScript("OnClick", function()
        GroupLanguage.MinimapButton:Show()
    end)
    
    -- Hide Minimap Button  
    local hideBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    hideBtn:SetPoint("TOPLEFT", showBtn, "TOPRIGHT", 10, 0)
    hideBtn:SetSize(160, 22)
    hideBtn:SetText(L("HIDE_MINIMAP_BUTTON"))
    hideBtn:SetScript("OnClick", function()
        GroupLanguage.MinimapButton:Hide()
    end)
    
    -- Test Button
    local testBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    testBtn:SetPoint("TOPLEFT", showBtn, "BOTTOMLEFT", 0, -10)
    testBtn:SetSize(160, 22)
    testBtn:SetText(L("TEST_LANGUAGE_REPORT"))
    testBtn:SetScript("OnClick", function()
        GroupLanguage:ShowLanguageReport()
    end)
    
    return panel
end

-- Event Handler
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGOUT")
eventFrame:RegisterEvent("GROUP_JOINED")
eventFrame:RegisterEvent("GROUP_LEFT")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    local arg1 = ...
    
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        GroupLanguage:OnLoad()
    elseif event == "PLAYER_LOGOUT" then
        GroupLanguage:OnLogout()
    elseif event == "GROUP_JOINED" then
        C_Timer.After(2, function() GroupLanguage:ShowLanguageReport() end)
    elseif event == "GROUP_LEFT" then
        print("|cFFFF6600GroupLanguage:|r " .. L("LEFT_GROUP"))
    end
end)

-- Addon Lifecycle
function GroupLanguage:OnLoad()
    print(L("ADDON_LOADED", ADDON_NAME, VERSION))
    
    -- Minimap Button initialisieren
    self.MinimapButton:Initialize()
    
    -- Interface Panel erstellen
    local panel = self:CreateInterfacePanel()
    
    -- Panel zu Interface-Optionen hinzufügen
    if Settings and Settings.RegisterCanvasLayoutCategory then
        -- Dragonflight+ API
        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        Settings.RegisterAddOnCategory(category)
    elseif InterfaceOptions_AddCategory then
        -- Legacy API
        InterfaceOptions_AddCategory(panel)
    end
    
    -- Minimap Button Zustand wiederherstellen
    if self.MinimapButton.settings.visible then
        self.MinimapButton:Show()
    else
        self.MinimapButton:Hide()
    end
end

function GroupLanguage:OnLogout()
    -- Einstellungen speichern
    if self.MinimapButton then
        GroupLanguage_SaveData = self.MinimapButton.settings.position
    end
end

-- Slash Commands
SLASH_GROUPLANGUAGE1 = "/gl"
SLASH_GROUPLANGUAGE2 = "/grouplanguage"
SlashCmdList["GROUPLANGUAGE"] = function(msg)
    local command = msg:lower():trim()
    
    if command == "show" or command == "" then
        GroupLanguage:ShowLanguageReport()
    elseif command == "help" then
        print("|cFFFF6600" .. L("COMMANDS_HELP") .. "|r")
        print(L("COMMAND_SHOW"))
        print(L("COMMAND_HELP"))
    else
        print("|cFFFF6600GroupLanguage:|r " .. L("UNKNOWN_COMMAND"))
    end
end

-- Global Functions (für XML-Callbacks)
function Button_OnClick()
    GroupLanguage:ShowLanguageReport()
end

function GroupLanguage_OnLoad(panel)
    -- Diese Funktion wird vom XML aufgerufen
    -- Wir machen hier nichts, da alles über ADDON_LOADED Event läuft
    -- Panel wird automatisch erstellt
end

function GroupLanguage_MinimapButton_DraggingFrame_OnUpdate()
    GroupLanguage.MinimapButton:OnDragUpdate()
end

function GroupLanguage_MinimapButton_OnEnter(self)
    if self.dragging then return end
    
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText(L("MINIMAP_TOOLTIP_TITLE"))
    GameTooltip:AddLine(L("MINIMAP_TOOLTIP_CLICK"), 1, 1, 1)
    GameTooltip:AddLine(L("MINIMAP_TOOLTIP_DRAG"), 1, 1, 1)
    GameTooltip:Show()
end
