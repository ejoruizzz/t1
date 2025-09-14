const jwt = require("jsonwebtoken");
const {
    tokenVerificationError
} =require("../utils/tokenManager");

 const requireRefreshToken = (req, res, next) => {
    try {
        console.log("Entre a requireRefreshToken");
        const refreshTokenCookie = req.cookies.refreshToken   //funciona como el refeshToken
        //console.log("refreshToken cookie",refreshTokenCookie);
        if (!refreshTokenCookie) throw new Error("No Existe el token")
        const {
            id
        } = jwt.verify(refreshTokenCookie,
            process.env.JWT_REFRESH);
            req.userId =id
            next()
    } catch (error) {
       // console.log("refreshToken cookie error:",error);
        return res.status(401).json({
            error: tokenVerificationError[error.message]
        });
    }
 }
module.exports={
     requireRefreshToken
 }