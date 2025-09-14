const productoAdapter = require('../adapters/productoAdapter');

const getAll = async (req, res, next) => {
    try {
        const productos = await productoAdapter.getAll()
        res.status(200).json(productos)
    } catch (error) {
        console.log('Error in getAll: ', error.message)
        res.status(500).json({
            message: 'Error in getAll'
        })

    }
}
const getById = async (req, res, next) => {
    try {
        const id = req.params.id
        const producto = await productoAdapter.getById(id)
        res.status(200).json(producto)
    } catch (error) {
        console.log('Error in getById: ', error.message)
        res.status(500).json({
            message: 'Error in getById'
        })
    }
}
const create = async (req, res, next) => {
    try {
        const {
            nombre,
            descripcion,
            precio,
            stock
        } = req.body
        const productoData = {
            nombre,
            descripcion,
            precio,
            stock
        }
        const producto = await productoAdapter.create(productoData)
        res.status(201).json(producto)
    } catch (error) {
        console.log('Error in create: ', error.message)
        res.status(500).json({
            message: 'Error in create'
        })
    }
}
const update = async (req, res, next) => {
    try {
        const id = req.params.id
        const {
            nombre,
            descripcion,
            precio,
            stock
        } = req.body
        const productoData = {
            nombre,
            descripcion,
            precio,
            stock
        }
        const updatedProducto = await productoAdapter.update(id, productoData)
        res.status(200).json(updatedProducto)
    } catch (error) {
        console.log('Error in update: ', error.message)
        res.status(500).json({
            message: 'Error in update'
        })
    }
}
const deleteProducto = async (req, res, next) => {
    try {
        const id = req.params.id
        await productoAdapter.delete(id)
        res.status(204).send()
    } catch (error) {
        console.log('Error in delete: ', error.message)
        res.status(500).json({
            message: 'Error in delete'
        })
    }
}

module.exports={
    getAll,
    getById,
    create,
    update,
    delete:deleteProducto
}
