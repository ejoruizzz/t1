const clienteRepository=require('../repositories/clienteRepository');
const getAllClientes=async()=>{
    try{
        const clientes=await clienteRepository.getAllClientes();
        return clientes || [];
    }catch(error){
        throw error;
    }
}
const getById=async(id)=>{
    try {
        const cliente=await clienteRepository.getById(id);
        return cliente || [];
    }catch(error){
        throw error;
    }
}
const createCliente=async(data)=>{
    try {
        const newCliente=await clienteRepository.createCliente(data);
        return newCliente || [];
    }catch(error){
        throw error;
    }
}
const updateCliente=async(id,data)=>{
    try {
        const updatedCliente=await clienteRepository.updateCliente(id,data);
        return updatedCliente || [];
    }catch(error){
        throw error;
    }
}
const deleteCliente=async(id)=>{
    try {
        await clienteRepository.deleteCliente(id);
        return;
    }catch(error){  
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