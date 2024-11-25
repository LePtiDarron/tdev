const { Client } = require('pg');
require('dotenv').config();

const connect = async () => {
  const connectionString = process.env.PG_URI;

  if (!connectionString) {
    throw new Error('L\'URL de la base de données PostgreSQL n\'est pas définie dans le fichier .env');
  }

  const client = new Client({
    connectionString: connectionString
  });

  try {
    await client.connect();
    console.log('Connecté à PostgreSQL');
  } catch (error) {
    console.error('Erreur de connexion à PostgreSQL', error);
  }

  return client;
};

module.exports = { connect };
