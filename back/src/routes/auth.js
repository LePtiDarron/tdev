const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { createUser, findUserByUsername } = require('../model/user');
const router = express.Router();
require('dotenv').config();

router.post('/signup', async (req, res) => {
  const { username, password } = req.body;

  try {
    const existingUser = await findUserByUsername(username);
    if (existingUser) {
      return res.status(400).json({ message: 'Utilisateur déjà existant' });
    }

    const newUser = await createUser(username, password);
    res.status(201).json({ message: 'Utilisateur créé avec succès', user: newUser });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la création de l\'utilisateur' });
  }
});

router.post('/login', async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await findUserByUsername(username);
    if (!user) {
      return res.status(400).json({ message: 'Utilisateur non trouvé' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: 'Mot de passe incorrect' });
    }

    const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' });
    res.status(200).json({ message: 'Connexion réussie', token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la connexion' });
  }
});

module.exports = router;
