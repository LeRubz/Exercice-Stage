const express = require('express');
const cors = require('cors');
const app = express();
const fs = require('fs');
const utilisateursJson = 'utilisateurs.json';

app.use(express.json());

app.use(cors());


app.post('/api/utilisateurs/inscription', (req, res) => {
    const nouvelUtilisateur = req.body;
    const utilisateurs = JSON.parse(fs.readFileSync(utilisateursJson));
    utilisateurs.push(nouvelUtilisateur);
    fs.writeFileSync(utilisateursJson, JSON.stringify(utilisateurs));

    res.json({ message: 'Compte créé' });
});

app.post('/api/utilisateurs/connexion', (req, res) => {
    const { email, motDePasse } = req.body;
    const utilisateurs = JSON.parse(fs.readFileSync(utilisateursJson));
    const utilisateur = utilisateurs.find(u => u.email === email && u.motDePasse === motDePasse);
    if (utilisateur) {
        res.json({ message: 'Connexion réussie' });
    } else {
        res.status(401).json({ message: 'Identifiants invalides' });
    }
});

app.delete('/api/utilisateurs/suppression', (req, res) => {
    const { nom, motDePasse } = req.body;
    const utilisateurs = JSON.parse(fs.readFileSync(utilisateursJson));
    const utilisateur = utilisateurs.find(u => u.nom === nom && u.motDePasse === motDePasse);
    if (utilisateur) {
        const nouveauxUtilisateurs = utilisateurs.filter(u => u !== utilisateur);
        fs.writeFileSync(utilisateursJson, JSON.stringify(nouveauxUtilisateurs));
        res.json({ message: 'Compte supprimé' });
    } else {
        res.status(401).json({ message: 'Nom d\'utilisateur ou mot de passe incorrects' });
    }
});



const port = 3000;
app.listen(port, () => {
    console.log(`Le serveur écoute sur le port ${port}`);
});
