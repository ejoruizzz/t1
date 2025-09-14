const { Router } = require('express')
const router = Router();

// Importing auth routes
const authRoutes = require('./auth.routes')
const clienteRoutes = require('./cliente.routes')
const productoRoutes = require('./producto.routes')


// Using auth routes with a prefix
router.use('/api/v1/auth', authRoutes);
router.use('/api/v1/clientes', clienteRoutes);
router.use('/api/v1/productos', productoRoutes);

module.exports = router;
