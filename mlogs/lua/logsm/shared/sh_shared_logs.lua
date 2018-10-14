logs = {}
logs.All = {}

logs.joueur = {}

logs.config = {}

logs.config.Groupe = {   -- Config des gardes pour ceux qui on acces au logs

  ["Modérateur"] = true,
  ["Modérateur-test"] = true,
  ["Administrateur"] = true,
  ["superadmin"] = true
}

logs.config.Title = "Mouloud Le Sang"  -- Titre / Nom des logs

logs.config.CommandeLogs = "!logs"



logs.config.Categorie = {}

logs.config.Categorie[1] = {

  nom = "Tous les Logs",  -- Texte du bouton
  sousnom = "all"
}

logs.config.Categorie[2] = {

  nom = "Arrestation",
  sousnom = "arrest"
}

logs.config.Categorie[3] = {

  nom = "Changement D'arme",
  sousnom = "changeweap"
}

logs.config.Categorie[4] = {

  nom = "Chat",
  sousnom = "sayp"
}

logs.config.Categorie[5] = {

  nom = "Connexions",
  sousnom = "Spawn"
}

logs.config.Categorie[6] = {

  nom = "Déconnexions",
  sousnom = "Disconnect"
}

logs.config.Categorie[7] = {

  nom = "Dégats",
  sousnom = "damage1"
}

logs.config.Categorie[8] = {

  nom = "Économie",
  sousnom = "economie"
}

logs.config.Categorie[9] = {

  nom = "LockPick",
  sousnom = "lockpick"
}

logs.config.Categorie[10] = {

  nom = "Métier",
  sousnom = "teamchange"
}

logs.config.Categorie[11] = {

  nom = "Mort",
  sousnom = "Death"
}

logs.config.Categorie[12] = {

  nom = "Nom RP",
  sousnom = "namechange"
}

logs.config.Categorie[13] = {

  nom = "Respawn",
  sousnom = "Respawn"
}
