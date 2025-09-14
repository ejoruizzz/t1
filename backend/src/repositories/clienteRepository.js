const db=require('../models');
const Cliente=db.Cliente;

//Crear un nuevo cliente
const getAllClientes=async()=>{
    try {
        const clientes=await Cliente.findAll();
        return clientes;
    } catch (error) {
        throw error; 
    }
}
const getById=async(id)=>{
    try {
        const cliente=await Cliente.findByPk(id);
        return cliente;
    } catch (error) {
        throw error; 
    }
}
const createCliente=async(data)=>{
    try {
        const newCliente=await Cliente.create(data);
        return newCliente;
    } catch (error) {
        throw error; 
    }
}
const updateCliente=async(id,data)=>{
    try {
        const cliente=await Cliente.findByPk(id);
        if(!cliente){
            throw new Error('Cliente not found');
        }
        const updatedCliente=await cliente.update(data);
        return updatedCliente;
    } catch (error) {
        throw error; 
    }
}
const deleteCliente=async(id)=>{
    try {
        const cliente=await Cliente.findByPk(id);
        if(!cliente){
            throw new Error('Cliente not found');
        }
        await cliente.destroy();
        return;
    } catch (error) {
        throw error; 
    }
}
module.exports={
    getAllClientes,
    getById,
    createCliente,
    updateCliente,
    deleteCliente
}