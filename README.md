# README

Projet de site Rails dédié à Pokémon mais surtout à mon apprentissage

Pour réinitialiser la BDD et la remplir à partir d'une sauvegarde JSON :
> `rake import:everything`

Pour générer les combinaisons d'attaques à partir des attaques en base :
> `MovesetsCalculator.new.fill_movesets_table` 

En ligne sur heroku : http://www.pokestop.me

__TODO :__

* Intégrer et différencier des attaques classiques les attaques exclusives à certains events (genre community day)
* Créer une FAQ propre où intégrer les guides pour débutants
* Création d'une API qui couvre l'ensemble des données du site
* Intégrer un système de soumission de modification de page pour permettre aux visiteurs de signaler facilement les erreurs en proposant une correction
* Refléchir à une optimisation des modèles pour limiter le nombre de rows superflues dans la base
* Refacto globale du back pour optimiser les perfs et commenter tout ça
* Refacto globale du front et notamment tout passer en BEM clean
* (long terme) Me former à React, limiter l'usage de Ruby à la génération de l'API et refaire tout le front en JS
