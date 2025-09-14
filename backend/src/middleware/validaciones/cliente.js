const {
    body,
    validationResult
} = require('express-validator');

const clienteValidationRules = () => {
    return [
        body('nombre')
            .notEmpty()
            .withMessage('El nombre es requerido').isLength({ min: 2, max: 255 })
            .withMessage('El nombre debe tener entre 2 y 255 caracteres'),
        body('apellido').notEmpty()
            .withMessage('El nombre es requerido').isLength({ min: 2, max: 255 })
            .withMessage('El nombre debe tener entre 2 y 255 caracteres'),
        body('email')
            .isEmail().trim().isLength({ max: 255 }).normalizeEmail()
            .withMessage('El correo electrónico es inválido'),
        body('telefono')
            .notEmpty()
            .withMessage('El teléfono es requerido')
            .isLength({ min: 7, max: 20 })
            .withMessage('El teléfono debe tener entre 7 y 20 caracteres'),
        body('direccion')
            .notEmpty()
            .withMessage('La dirección es requerida')
            .isLength({ min: 5, max: 255 })
            .withMessage('La dirección debe tener entre 5 y 255 caracteres'),
        body('fechanacimiento')
            .notEmpty()
            .withMessage('La fecha de nacimiento es requerida')
            .isISO8601()
            .withMessage('La fecha de nacimiento debe ser una fecha válida (YYYY-MM-DD)')   
    ];
}
const validate = (req, res, next) => {
    const errors = validationResult(req)
    console.log('errors', errors);
    if (errors.isEmpty()) {
        return next()
    }
    const extractedErrors = [];
    errors.array().map(err => extractedErrors.push({
        [err.path]: err.msg
    }))


    return res.status(422).json({
        errors: extractedErrors,
    })
}

module.exports = {
    clienteValidationRules,
    validate,
}