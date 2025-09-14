const db=require('../models');
const Producto=db.Producto;

const getAll=async()=>{
    try {
        const productos=await Producto.findAll();
        return productos;
    } catch (error) {
        throw error;
    }
}
const getById=async(id)=>{
    try {
        const producto=await Producto.findByPk(id);
        return producto;
    } catch (error) {
        throw error;
    }
}
const create=async(data)=>{
    try {
        const newProducto=await Producto.create(data);
        return newProducto;
    } catch (error) {
        throw error;
    }
}
const update=async(id,data)=>{
    try {
        const producto=await Producto.findByPk(id);
        if(!producto){
            throw new Error('Producto not found');
        }
        const updatedProducto=await producto.update(data);
        return updatedProducto;
    } catch (error) {
        throw error;
    }
}
const deleteProducto=async(id)=>{
    try {
        const producto=await Producto.findByPk(id);
        if(!producto){
            throw new Error('Producto not found');
        }
        await producto.destroy();
        return;
    } catch (error) {
        throw error;
    }
}
module.exports={
    getAll,
    getById,
    create,
    update,
    delete:deleteProducto
}
