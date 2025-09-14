const express = require('express')
const productoController = require('../controllers/productoController');
const { verifyToken } = require("../middleware/index");
const {productoValidationRules, validate} = require("../middleware/validaciones/producto");

const router = express.Router();

router.get('/', verifyToken,productoController.getAll);
router.get('/:id', verifyToken,productoController.getById);
router.post('/', [verifyToken,productoValidationRules(),validate],productoController.create);
router.put('/:id',[verifyToken,productoValidationRules(),validate], productoController.update);
router.delete('/:id',verifyToken, productoController.delete);
module.exports = router;
