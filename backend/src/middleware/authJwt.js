const jwt = require("jsonwebtoken");

const db = require("../models");
const {
    tokenVerificationError
} =require("../utils/tokenManager")

verifyToken = async (req, res, next) => {
    try {
        //const token = req.headers["x-access-token"];
        //console.log("token split",token);
        console.log('entro a verificar')
        let token = req.headers?.authorization;
        console.log("token:",token);
        if (!token) throw new Error("No Bearer")
        token = token.split(" ")[1];

        if (!token) {
            return res.status(403).send({
                message: "No token provided!"
            });
        }
        const {
            id
        } = jwt.verify(token,
            process.env.JWT_SECRET);
         console.log('id:', id);
        req.userId = id;   
        next();
    } catch (error) {
        console.log("Error in verifyToken:", error);
        return res.status(401).send({
            error: tokenVerificationError[error.message]
        });
    }


};

module.exports = verifyToken;