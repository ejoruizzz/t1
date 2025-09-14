const express = require('express');
const authController = require('../controllers/authController');
const { loginValidationRules, validate } = require('../middleware/validaciones/login');
const { verifyToken } = require("../middleware/index");
const router = express.Router();
router.post('/login',  authController.login);
//router.put('/cambiarclave/:id', authController.cambiarclave);
//router.put('/cambiarfoto/:id', authController.cambiarFoto);

router.get('/', authController.getAllUsers);
//router.get('/:id', authController.getUserById);
router.post('/', authController.createUser);
//router.put('/:id', authController.updateUser);
//router.delete('/:id', authController.deleteUser);

module.exports = router;