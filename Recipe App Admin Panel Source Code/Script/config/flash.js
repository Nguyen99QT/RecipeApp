module.exports.setflash = (req, res, next) => {
    res.locals.flash = {
        'success': req.flash('success'),
        'error': req.flash('error'),
        'delete': req.flash('delete'),
        'edit': req.flash('edit'),
        'warning': req.flash('warning')
    }
    next()
}