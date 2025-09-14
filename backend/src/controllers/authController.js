const authAdapter = require('../adapters/authAdapter');

const bcrypt = require('bcrypt');
const getAllUsers = async (req, res, next) => {
    try {
        const users = await authAdapter.getAllUsers()
        res.status(200).json(users)
    } catch (error) {
        console.log('Error in getAllUsers: ', error.message)
        res.status(500).json({
            message: 'Error in getAllUsers'
        })

    }
}

const createUser = async (req, res, next) => {
    console.log(req.body);
    try {
        const {
            firstName,
            lastName,
            email,
            password,
            status,
            dob,
            profile_picture
        } = req.body
        const userData = {
            firstName,
            lastName,
            email,
            password: await bcrypt.hash(password, 10), // Hash the password
            status,
            dob,
            profile_picture
        }

        const user = await authAdapter.createUser(userData)
        res.status(201).json(user)
    } catch (error) {
        console.log('Error in createUser: ', error.message)
        res.status(500).json({
            message: 'Error in createUser'
        })
    }
}


const login = async (req, res, next) => {
    try {
        const {email,password} = req.body
        const user = await authAdapter.login(email,password)
        res.status(200).json(user)
    } catch (error) {
        res.status(500).json({
            message: 'Error in login este'
        })
    }
}

module.exports = {
    getAllUsers, 
    createUser,
    login,

}