const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { createUser, findUserByEmail } = require('../model/user');
const router = express.Router();
require('dotenv').config();

router.post('/signup', async (req, res) => {
  const { email, password, firstname, lastname, phonenumber, address, zip, city, country } = req.body;

  try {
    const existingUser = await findUserByEmail(email);
    if (existingUser) {
      return res.status(400).json({ message: 'Email already used' });
    }

    const newUser = await createUser(email, password, firstname, lastname, phonenumber, address, zip, city, country);
    res.status(201).json({ message: 'User created successfuly', user: newUser });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error creating the user' });
  }
});

router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await findUserByEmail(email);
    if (!user) {
      return res.status(400).json({ message: 'Wrong email or password' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: 'Wrong email or password' });
    }

    const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET, { expiresIn: '10h' });
    res.status(200).json({ message: 'Successfuly connected', token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Conexion error' });
  }
});

router.put('/update', async (req, res) => {
  const { userId } = req.body;
  const { email, firstname, lastname, phonenumber, address, zip, city, country } = req.body;

  try {
    const user = await findUserById(userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    if (!email || !firstname || !lastname || !phonenumber || !address || !zip || !city || !country) {
      return res.status(430).json({ message: 'Missing field(s)' });
    }

    const updatedUser = await updateUserById(userId, {
      email,
      firstname,
      lastname,
      phonenumber,
      address,
      zip,
      city,
      country,
    });

    res.status(200).json({ message: 'User updated successfully', user: updatedUser });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error updating the user' });
  }
});

router.delete('/delete', async (req, res) => {
  const { userId } = req.body;

  try {
    const user = await findUserById(userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    await deleteUserById(userId);
    res.status(200).json({ message: 'User deleted successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error deleting the user' });
  }
});

module.exports = router;
