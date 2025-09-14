const {
    body,
    validationResult
} = require('express-validator');

const productoValidationRules = () => {
    return [
        body('nombre')
            .notEmpty()
            .withMessage('El nombre es requerido').isLength({ min: 2, max: 255 })
            .withMessage('El nombre debe tener entre 2 y 255 caracteres'),
        body('descripcion')
            .notEmpty()
            .withMessage('La descripcion es requerida').isLength({ min: 5, max: 255 })
            .withMessage('La descripcion debe tener entre 5 y 255 caracteres'),
        body('precio')
            .notEmpty()
            .withMessage('El precio es requerido')
            .isFloat({ gt: 0 })
            .withMessage('El precio debe ser un número positivo'),
        body('stock')
            .notEmpty()
            .withMessage('El stock es requerido')
            .isInt({ min: 0 })
            .withMessage('El stock debe ser un número entero no negativo'),
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
    productoValidationRules,
    validate,
}
