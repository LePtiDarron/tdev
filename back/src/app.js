const express = require('express');
const bodyParser = require('body-parser');
const { connect } = require('./service/postgres');
const authRoutes = require('./route/auth');
const { createUserTable } = require('./model/user');

const app = express();
const port = 3000;

app.use(bodyParser.json());

connect()
  .then(() => {
    console.log('Connexion à PostgreSQL réussie');
    createUserTable();
  })
  .catch((err) => console.error('Échec de la connexion à PostgreSQL', err));

app.use('/auth', authRoutes);

app.listen(port, () => {
  console.log(`Serveur en écoute sur http://localhost:${port}`);
});
