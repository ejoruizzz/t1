const productoRepository=require('../repositories/productoRepository');
const getAll=async()=>{
    try{
        const productos=await productoRepository.getAll();
        return productos || [];
    }catch(error){
        throw error;
    }
}
const getById=async(id)=>{
    try {
        const producto=await productoRepository.getById(id);
        return producto || [];
    }catch(error){
        throw error;
    }
}
const create=async(data)=>{
    try {
        const newProducto=await productoRepository.create(data);
        return newProducto || [];
    }catch(error){
        throw error;
    }
}
const update=async(id,data)=>{
    try {
        const updatedProducto=await productoRepository.update(id,data);
        return updatedProducto || [];
    }catch(error){
        throw error;
    }
}
const deleteProducto=async(id)=>{
    try {
        await productoRepository.delete(id);
        return;
    }catch(error){
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
