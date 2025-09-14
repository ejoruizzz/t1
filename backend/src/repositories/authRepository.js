const db=require('../models');
const User=db.User;

const getAllUsers=async()=>{
    try{
       const users=await User.findAll({ attrubutes: ['id', 'firstName', 'lastName', 'email', 'status', 'dob', 'profile_picture']})
       return users
    }catch(err){
        console.log('Error in getAllUsers: ',err.message)
        throw err
    }
}
const getUserById=async(id)=>{
    try{
        const user=await User.findByPk(id, { attributes: ['id', 'firstName', 'lastName', 'email', 'status', 'dob', 'profile_picture']})
        return user
    }catch(err){
        console.log('Error in getUserById: ',err.message)
        throw err
    }
}
const createUser=async(userData)=>{
    try{
        const user=await User.create(userData)
        return user
    }catch(err){
        console.log('Error in createUser: ',err.message)
        throw err
    }
}
const updateUser=async(id, userData)=>{
    try{
        const user=await User.update(userData, { where: { id }})
        return user
    }catch(err){
        console.log('Error in updateUser: ',err.message)
        throw err
    }
}
const deleteUser=async(id)=>{
    try{
        const user=await User.destroy({ where: { id }})
        return user
    }catch(err){
        console.log('Error in deleteUser: ',err.message)
        throw err
    }
}
const login=async(email)=>{
    try{
        const user=await User.findOne({ where: { email }})
        return user
    }catch(err){
        console.log('Error in login: ',err.message)
        throw err
    }
}
const cambiarFoto=async(data,id)=>{
    try{
        const user=await User.update(data, { where: { id }})
        return user
    }catch(err){
        console.log('Error in cambiarFoto: ',err.message)
        throw err
    }
}
const cambiarclave=async(data,id)=>{
    try{
        const user=await User.update(data, { where: { id }})
        return user
    }catch(err){
        console.log('Error in cambiarclave: ',err.message)
        throw err
    }
}
module.exports={
    getAllUsers,
    getUserById,
    createUser,
    updateUser,
    deleteUser,
    login,
    cambiarFoto,
    cambiarclave
};