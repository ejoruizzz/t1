const clienteAdapter = require('../adapters/clienteAdapter');

const getAllClientes = async (req, res, next) => {
    try {
        const clientes = await clienteAdapter.getAllClientes()
        res.status(200).json(clientes)
    } catch (error) {
        console.log('Error in getAllClientes: ', error.message)
        res.status(500).json({
            message: 'Error in getAllClientes'
        })

    }
}
const getById = async (req, res, next) => {
    try {
        const id = req.params.id
        const cliente = await clienteAdapter.getById(id)
        res.status(200).json(cliente)
    } catch (error) {
        console.log('Error in getById: ', error.message)
        res.status(500).json({
            message: 'Error in getById'
        })
    }
}
const createCliente = async (req, res, next) => {
    console.log(JSON.stringify(req.body));
    try {
        const {
            nombre,
            apellido,
            fechanacimiento,
            email,
            telefono,
            direccion
        } = req.body
        const clienteData = {
            nombre,
            apellido,
            fechanacimiento,
            email,
            telefono,
            direccion
        }
        console.log("", clienteData);
        const cliente = await clienteAdapter.createCliente(clienteData)
        res.status(201).json(cliente)
    } catch (error) {
        console.log('Error in createCliente: ', error.message)
        res.status(500).json({
            message: 'Error in createCliente'
        })
    }
}
const updateCliente = async (req, res, next) => {
    try {
        const id = req.params.id 
        const {
            nombre,
            apellido,
            fechanacimiento,
            email,
            telefono,
            direccion
        } = req.body
        const clienteData = {
            nombre,
            apellido,
            fechanacimiento,
            email,
            telefono,
            direccion
        }
        const updatedCliente = await clienteAdapter.updateCliente(id, clienteData)
        res.status(200).json(updatedCliente)
    } catch (error) {
        console.log('Error in updateCliente: ', error.message)
        res.status(500).json({
            message: 'Error in updateCliente'
        })
    } 
}
const deleteCliente = async (req, res, next) => {
    try {
        const id = req.params.id
        await clienteAdapter.deleteCliente(id)
        res.status(204).send()
    } catch (error) {
        console.log('Error in deleteCliente: ', error.message)
        res.status(500).json({
            message: 'Error in deleteCliente'
        })
    }
}

module.exports={
    getAllClientes,
    getById,
    createCliente,
    updateCliente,
    deleteCliente
}