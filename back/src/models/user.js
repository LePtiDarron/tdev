const { Client } = require('pg');
const bcrypt = require('bcryptjs');
const { connect } = require('../service/postgres');

const createUserTable = async () => {
  const client = await connect();
  await client.query(`
    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      username VARCHAR(100) UNIQUE NOT NULL,
      password TEXT NOT NULL
    );
  `);
};

const createUser = async (username, password) => {
  const client = await connect();
  const hashedPassword = await bcrypt.hash(password, 10);
  const result = await client.query(
    'INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *',
    [username, hashedPassword]
  );
  return result.rows[0];
};

const findUserByUsername = async (username) => {
  const client = await connect();
  const result = await client.query('SELECT * FROM users WHERE username = $1', [username]);
  return result.rows[0];
};

module.exports = { createUserTable, createUser, findUserByUsername };
