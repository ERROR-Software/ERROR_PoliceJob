Config = {}
Config.ESXVersion = "legacy"
Config.Locale = "fr"
Config.copLabel = "L.S.P.D"
Config.jobname = "police"
Config.Markers = {
    color = {0, 18, 71},
    id = 21,
    size = 1.0,
    animate = true,
    turn = false
}

-- █████   ██████  ██████ ██    ██ ███████ ██ ██           ██████  ██████  ███    ██ ███████ ██  ██████  
-- ██   ██ ██      ██      ██    ██ ██      ██ ██          ██      ██    ██ ████   ██ ██      ██ ██       
-- ███████ ██      ██      ██    ██ █████   ██ ██          ██      ██    ██ ██ ██  ██ █████   ██ ██   ███ 
-- ██   ██ ██      ██      ██    ██ ██      ██ ██          ██      ██    ██ ██  ██ ██ ██      ██ ██    ██ 
-- ██   ██  ██████  ██████  ██████  ███████ ██ ███████      ██████  ██████  ██   ████ ██      ██  ██████  
                                                                                                       
Config.accueil = {
    pos = vec4(442.668121, -981.890137, 30.678345, 85.039368),
    npcmodel = "s_m_y_cop_01",
    interact_dst = 2,
    timeforcallpolice = 10,
    char = "CHAR_CHAT_CALL",
    complaint_webhook = "https://discord.com/api/webhooks/1227567227885322332/OU3npr-n__TCPWI_Xv9Em-XGjJ5bYYPg9aPR6yDN7iqiGjmvwYiFMWlLclJFEjbM3sDD",
    webhook = {
        ['color'] = 7495,
        ['bot_name'] = "Plainte LSPD",
        ['message_title'] = "Plainte d'un citoyen.",
        ['message'] = "Numero de téléphone : ***__%s__***\nMonsieur / Madame ***__%s__*** porte plainte pour : \n%s",
        ['footer'] = "Los Santos Police Departement."
    }
}

-- ██       ██████   ██████ ██   ██ ███████ ██████       ██████  ██████  ███    ██ ███████ ██  ██████  
-- ██      ██    ██ ██      ██  ██  ██      ██   ██     ██      ██    ██ ████   ██ ██      ██ ██       
-- ██      ██    ██ ██      █████   █████   ██████      ██      ██    ██ ██ ██  ██ █████   ██ ██   ███ 
-- ██      ██    ██ ██      ██  ██  ██      ██   ██     ██      ██    ██ ██  ██ ██ ██      ██ ██    ██ 
-- ███████  ██████   ██████ ██   ██ ███████ ██   ██      ██████  ██████  ██   ████ ██      ██  ██████  

Config.locker = {
    pos = vec3(462.646149, -997.305481, 31.133301),
    [0] = {
        {
            label = "Tenue cadet",
            male = {
                tshirt_1 = 59,  tshirt_2 = 1,
                torso_1 = 55,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 41,
                pants_1 = 25,   pants_2 = 0,
                shoes_1 = 25,   shoes_2 = 0,
                helmet_1 = 46,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            },
            female = {
                tshirt_1 = 36,  tshirt_2 = 1,
                torso_1 = 48,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 44,
                pants_1 = 34,   pants_2 = 0,
                shoes_1 = 27,   shoes_2 = 0,
                helmet_1 = 45,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            }
        },
    },
    [1] = {
        {
            label = "Tenue officier",
            male = {
                tshirt_1 = 59,  tshirt_2 = 1,
                torso_1 = 55,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 41,
                pants_1 = 25,   pants_2 = 0,
                shoes_1 = 25,   shoes_2 = 0,
                helmet_1 = 46,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            },
            female = {
                tshirt_1 = 36,  tshirt_2 = 1,
                torso_1 = 48,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 44,
                pants_1 = 34,   pants_2 = 0,
                shoes_1 = 27,   shoes_2 = 0,
                helmet_1 = 45,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            }
        },
    },
    [2] = {
        {
            label = "Tenue Sergeant",
            male = {
                tshirt_1 = 59,  tshirt_2 = 1,
                torso_1 = 55,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 41,
                pants_1 = 25,   pants_2 = 0,
                shoes_1 = 25,   shoes_2 = 0,
                helmet_1 = 46,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            },
            female = {
                tshirt_1 = 36,  tshirt_2 = 1,
                torso_1 = 48,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 44,
                pants_1 = 34,   pants_2 = 0,
                shoes_1 = 27,   shoes_2 = 0,
                helmet_1 = 45,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            }
        },
    },
    [3] = {
        {
            label = "Tenue Lieutenant",
            male = {
                tshirt_1 = 59,  tshirt_2 = 1,
                torso_1 = 55,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 41,
                pants_1 = 25,   pants_2 = 0,
                shoes_1 = 25,   shoes_2 = 0,
                helmet_1 = 46,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            },
            female = {
                tshirt_1 = 36,  tshirt_2 = 1,
                torso_1 = 48,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 44,
                pants_1 = 34,   pants_2 = 0,
                shoes_1 = 27,   shoes_2 = 0,
                helmet_1 = 45,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            }
        },
    },
    [4] = {
        {
            label = "Tenue Capitaine",
            male = {
                tshirt_1 = 59,  tshirt_2 = 1,
                torso_1 = 55,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 41,
                pants_1 = 25,   pants_2 = 0,
                shoes_1 = 25,   shoes_2 = 0,
                helmet_1 = 46,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            },
            female = {
                tshirt_1 = 36,  tshirt_2 = 1,
                torso_1 = 48,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 44,
                pants_1 = 34,   pants_2 = 0,
                shoes_1 = 27,   shoes_2 = 0,
                helmet_1 = 45,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 2,     ears_2 = 0
            }
        },
    },
}

-- █████  ██████  ███    ███  ██████  ██████  ██    ██      ██████  ██████  ███    ██ ███████ ██  ██████  
-- ██   ██ ██   ██ ████  ████ ██    ██ ██   ██  ██  ██      ██      ██    ██ ████   ██ ██      ██ ██       
-- ███████ ██████  ██ ████ ██ ██    ██ ██████    ████       ██      ██    ██ ██ ██  ██ █████   ██ ██   ███ 
-- ██   ██ ██   ██ ██  ██  ██ ██    ██ ██   ██    ██        ██      ██    ██ ██  ██ ██ ██      ██ ██    ██ 
-- ██   ██ ██   ██ ██      ██  ██████  ██   ██    ██         ██████  ██████  ██   ████ ██      ██  ██████  

Config.armory = {
    npc = "s_m_y_cop_01",
    interact_dst = 2,
    coords = vec4(480.329681, -996.672546, 30.678345, 85.039368),
    weapons = {
        [0] = {
            {name = "WEAPON_STUNGUN", ammo = nil, ammocount = 50},
            {name = "WEAPON_PISTOL", ammo = "ammo-9", ammocount = 50}
        },
        [1] = {
            {name = "WEAPON_PISTOL", ammo = "ammo-9", ammocount = 50},
        },
        [2] = {
            {name = "WEAPON_PISTOL", ammo = "ammo-9", ammocount = 50},
        },
        [3] = {
            {name = "WEAPON_PISTOL", ammo = "ammo-9", ammocount = 50},
        },
        [4] = {
            {name = "WEAPON_PISTOL", ammo = "ammo-9", ammocount = 50},
        },
    }
}

-- ██████   █████  ██████   █████   ██████  ███████      ██████  ██████  ███    ██ ███████ ██  ██████  
-- ██       ██   ██ ██   ██ ██   ██ ██       ██          ██      ██    ██ ████   ██ ██      ██ ██       
-- ██   ███ ███████ ██████  ███████ ██   ███ █████       ██      ██    ██ ██ ██  ██ █████   ██ ██   ███ 
-- ██    ██ ██   ██ ██   ██ ██   ██ ██    ██ ██          ██      ██    ██ ██  ██ ██ ██      ██ ██    ██ 
--  ██████  ██   ██ ██   ██ ██   ██  ██████  ███████      ██████  ██████  ██   ████ ██      ██  ██████  

Config.garage = {
    npc = "s_m_y_cop_01",
    interact_dst = 2,
    coords = vec4(441.402191, -985.252747, 25.690796, 354.330719),
    parkradius = 0.6,
    parks = {
        vec4(425.23809814453,-984.23162841797,25.699968338013,86.156143188477),
        vec4(425.12805175781,-981.49920654297,25.699968338013,89.25040435791),
        vec4(425.29602050781,-978.97900390625,25.699968338013,89.648735046387),
    },
    vehicles = {
        [0] = {
            {label = "Police banalise", name = "police4"},
        },
        [1] = {
            {label = "Police banalise", name = "police4"},
        },
        [2] = {
            {label = "Police banalise", name = "police4"},
        },
        [3] = {
            {label = "Police banalise", name = "police4"},
        },
        [4] = {
            {label = "Police banalise", name = "police4"},
        },
    },
    deleteVehicles = vec3(449.99609375, -975.79968261719, 25.699968338013),
    DeleteInteractDist = 5
}

-- ██████  ███████ ██████  ███████     ██ ███    ██ ████████ ███████ ██████   █████   ██████ ████████      ██████  ██████  ███    ██ ███████ ██  ██████  
-- ██   ██ ██      ██   ██ ██          ██ ████   ██    ██    ██      ██   ██ ██   ██ ██         ██        ██      ██    ██ ████   ██ ██      ██ ██       
-- ██████  █████   ██   ██ ███████     ██ ██ ██  ██    ██    █████   ██████  ███████ ██         ██        ██      ██    ██ ██ ██  ██ █████   ██ ██   ███ 
-- ██      ██      ██   ██      ██     ██ ██  ██ ██    ██    ██      ██   ██ ██   ██ ██         ██        ██      ██    ██ ██  ██ ██ ██      ██ ██    ██ 
-- ██      ███████ ██████  ███████     ██ ██   ████    ██    ███████ ██   ██ ██   ██  ██████    ██         ██████  ██████  ██   ████ ██      ██  ██████  

Config.PlayersInteractions = {
    cuff = {
        animDict = "mp_arresting",
        animName = "idle",
        freeze = false
    },
    uncuff = {
        animDict = "mp_arresting",
        animName = "a_uncuff"
    }
}

Config.Chest = {
    pos = vec3(448.92440795898, -997.72045898438, 30.689584732056),
    markerZone = 5,
    interactZone = 2,
}

Config.Cctv = {
    interact_pos = vec3(444.78967285156,-998.87542724609,34.970180511475),
    markerZone = 5,
    interactZone = 2,
    cams = {
        {label = "Caméra supérette 1", coords = vec4(372.73089599609, 330.15277099609,105.7, 226.63302612305), rotX = -35.0},
        {label = "Caméra supérette 2", coords = vec4(373.3410, 331.1681, 105.7686, 210.7031), rotX = -35.0},
        {label = "Fleeca Bank 1", coords = vec4(-2965.6858, 476.5087, 17.7483, 316.9306), rotX = -35.0},
        {label = "Caméra concess", coords = vec4(-62.8412, -1101.7107, 33.5577, 218.5712), rotX = -35.0},
        {label = "Caméra pacific standard", coords = vec4(259.6820, 217.1540, 116.4139, 93.7624), rotX = -52.0},
    }
}

Config.PersonalLocker = {
    pos = vec3(462.78591918945,-999.62683105469,30.689571380615),
    markerZone = 5,
    interactZone = 2,
    weight = 70000,
    slots = 30
}