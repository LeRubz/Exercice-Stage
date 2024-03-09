# Exercice-Stage

Objectif : Application Flutter avec Authentification et API Rest NodeJS

L'objectif de cet exercice est de concevoir et de développer une application mobile Flutter qui interagit avec une API Rest réalisée avec NodeJS pour gérer l'authentification d'utilisateurs. Les fonctionnalités nécessaires sont : 
- création de compte
- connexion
- suppression de compte

Lorsque l’utilisateur se connecte, il aura accès à certaines parties de l'application étant restreintes aux utilisateurs non-authentifiés. 
Le stockage des mots de passe en clair doit être évité.

Etapes conseillées :

- Mettre en place un serveur NodeJS qui expose une API Rest avec Express
- Implémenter les endpoints nécessaires pour la création de compte, la connexion et la suppression du compte utilisateur.
- S'assurer que les mots de passe ne soient pas stockés en clair et qu’il en soit pas échangé à chaque requête (JWT)
Comme la gestion d'une base de données n'est pas requise pour cet exercice, stocker les informations des utilisateurs dans une variable directement, en veillant à la sécurité des données.

- Créer un projet Flutter
- Créer un écran de création de compte.
- Créer un écran de connexion.
- Créer un écran principal accessible uniquement aux utilisateurs connectés.
- Intégrer une logique de navigation qui dirige l'utilisateur vers l'écran principal après une connexion réussie et permet à l'utilisateur de se déconnecter.

Conseil : Utilisez le package dio de Flutter pour communiquer avec votre API Rest. 
Gérer les réponses de l'API de manière appropriée pour informer l'utilisateur en cas de succès ou d'erreur.

Sécurité et Bonnes Pratiques :
- S'assurer que les communications entre l'application Flutter et l'API Rest soient sécurisées.

Livrables :
Le code source de l'API Rest NodeJS, incluant les instructions pour lancer le serveur.
Le code source de l'application Flutter.


Critères d'évaluation :
Fonctionnalité : L'application doit fonctionner comme décrit dans les consignes.
Sécurité : Les mots de passe doivent être traités de manière sécurisée.
Qualité du code : Le code doit être clair, bien organisé, et suivre les bonnes pratiques de développement. Aucun crash bloquant ne doit arriver.



COMMANDES POSTMAN :

Créer un compte :

type : POST
URL : http://localhost:3000/api/utilisateurs/inscription
Body : 
{
    "nom": "",
    "email": "",
    "motDePasse": ""
}

Se connecter :

type : POST
URL : http://localhost:3000/api/utilisateurs/connexion
Body : 
{
    "email": "",
    "motDePasse": ""
}

Supprimer un compte : 

Type : DELETE
URL : http://localhost:3000/api/utilisateurs/suppression
Body : 
{
    "nom": "Rubens Guzman",
    "motDePasse": "password123"
}
