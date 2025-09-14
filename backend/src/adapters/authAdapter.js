const authRepository = require('../repositories/authRepository')
const bcrypt = require('bcrypt');
const { generateRefreshToken, generateToken } = require("../utils/tokenManager.js");
const getAllUsers = async () => {
    try {
        const users = await authRepository.getAllUsers()
        return (users) ? users : []
    } catch (err) {
        console.log('Error in getAllUsers: ', err.message)
        throw err
    }
}
const getUserById = async (id) => {
    try {
        const user = await authRepository.getUserById(id)
        return (user) ? user : []
    } catch (err) {
        console.log('Error in getUserById: ', err.message)
        throw err
    }
}
const createUser = async (userData) => {
    try {
        
        const user = await authRepository.createUser(userData)
        return (user) ? user : []
    } catch (err) {
        console.log('Error in createUser: ', err.message)
        throw err
    }
}
const updateUser = async (id, userData) => {
    try {
        const user = await authRepository.updateUser(id, userData)
        return (user) ? user : []
    } catch (err) {
        console.log('Error in updateUser: ', err.message)
        throw err
    }
}
const deleteUser = async (id) => {
    try {
        const user = await authRepository.deleteUser(id)
        return (user) ? user : []
    } catch (err) {
        console.log('Error in deleteUser: ', err.message)
        throw err
    }
}
const login = async (email,password) => {
     let userData = {}
    try {
        const user = await authRepository.login(email)
        if (!user) {
            return {
                message: 'Invalid email or password'
            }
        }
        const isMatch = await bcrypt.compare(password, user.password)
        if (!isMatch) {
            return {
                message: 'Invalid email or password'
            }
        } else {
            const {
                token,
                expiresIn
            } = generateToken(user.id);
            const refreshToken = generateRefreshToken(user.id);
            userData = {
                    email: user.email,
                    name: user.firstName + ' ' + user.lastName,
                    accessToken: token,
                    expiresIn: expiresIn,
                    refreshToken: refreshToken
                }
        }
        return userData || []
    } catch (err) {
        console.log('Error in login este:', err.message)
        throw err
    }
}
const cambiarFoto = async (data, id) => {
    try {
        //tenemos que subir el archivo a cloudinary
        //tenemos que guardar la url en la base de datos
        const user = await authRepository.cambiarFoto(data, id)
        return (user) ? user : []
    } catch (err) {
        console.log('Error in cambiarFoto: ', err.message)
        throw err
    }
}
const cambiarclave = async (data, id) => {
    try {
        //tenemos que verificar la contraseña actual
        //tenemos que hacer el bcrypt de la nueva contraseña
        const user = await authRepository.cambiarclave(data, id)
        return (user) ? user : []
    } catch (err) {
        console.log('Error in cambiarclave: ', err.message)
        throw err
    }
}
module.exports = {
    getAllUsers,
    getUserById,
    createUser,
    updateUser,
    deleteUser,
    login,
    cambiarFoto,
    cambiarclave
}