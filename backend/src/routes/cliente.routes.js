const express = require('express')
const clienteController = require('../controllers/clienteController');
const { verifyToken } = require("../middleware/index");
const {clienteValidationRules, validate} = require("../middleware/validaciones/cliente");

const router = express.Router();

router.get('/', verifyToken,clienteController.getAllClientes);
router.get('/:id', verifyToken,clienteController.getById);
router.post('/', [verifyToken,clienteValidationRules(),validate],clienteController.createCliente);
router.put('/:id',[verifyToken,clienteValidationRules(),validate], clienteController.updateCliente);
router.delete('/:id',verifyToken, clienteController.deleteCliente); 
module.exports = router;