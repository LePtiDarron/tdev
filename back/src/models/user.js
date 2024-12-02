const { Client } = require('pg');
const bcrypt = require('bcryptjs');
const { connect } = require('../service/postgres');

const createUserTable = async () => {
  const client = await connect();
  await client.query(`
    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      email VARCHAR(100) UNIQUE NOT NULL,
      password TEXT NOT NULL,
      fistname TEXT NOT NULL,
      lastname TEXT NOT NULL,
      phonenumber TEXT NOT NULL,
      address TEXT NOT NULL,
      zip TEXT NOT NULL,
      city TEXT NOT NULL,
      country TEXT NOT NULL
    );
  `);
};

const createUser = async (email, password, firstname, lastname, phonenumber, address, zip, city, country) => {
  const client = await connect();
  const hashedPassword = await bcrypt.hash(password, 10);
  const query = `
    INSERT INTO users (email, password, firstname, lastname, phonenumber, address, zip, city, country) 
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) 
    RETURNING *;
  `;
  const values = [email, hashedPassword, firstname, lastname, phonenumber, address, zip, city, country];
  const result = await client.query(query, values);
  return result.rows[0];
};


const findUserByEmail = async (email) => {
  const client = await connect();
  const result = await client.query('SELECT * FROM users WHERE email = $1', [email]);
  return result.rows[0];
};

module.exports = { createUserTable, createUser, findUserByEmail };
