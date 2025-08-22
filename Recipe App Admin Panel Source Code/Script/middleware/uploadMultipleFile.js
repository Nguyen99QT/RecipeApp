// Importing required modules
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Importing the service function to delete uploaded files
const { deleteImages, deleteVideo } = require('../services/deleteImage');

// Configuration for Multer and file storage
const recipeStorage = multer.diskStorage({
    destination: function (req, file, cb) {
        let destinationPath;
        if (file.fieldname === 'image' || file.fieldname === 'gallery') {
            destinationPath = path.join(__dirname, '../uploads/images');
        } else if (file.fieldname === 'video') {
            destinationPath = path.join(__dirname, '../uploads/video');
        }
        cb(null, destinationPath);
    },
    filename: function (req, file, cb) {
        const timestamp = Date.now();
        const extension = path.extname(file.originalname);
        const basename = path.basename(file.originalname, extension);
        const newFilename = `${timestamp}_${basename}${extension}`;
        cb(null, newFilename);
    }
});

const recipeUpload = multer({ storage: recipeStorage });

const uploadMiddleware = (fields) => {
    return (req, res, next) => {
        recipeUpload.fields(fields)(req, res, (err) => {
            if (err) {
                return res.status(400).json({ error: err.message });
            }

            const files = req.files;
            const errors = [];

            // Validate uploaded files
            Object.keys(files).forEach((fieldname) => {
                files[fieldname].forEach((file) => {
                    if (fieldname === 'image' || fieldname === 'gallery') {
                        const allowedImageTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/tiff', 'image/x-icon'];
                        if (!allowedImageTypes.includes(file.mimetype)) {
                            errors.push(`Invalid image file type: ${file.originalname}. Only images are allowed.`);
                        }
                    } else if (fieldname === 'video') {
                        const allowedVideoTypes = ['video/mp4', 'video/webm', 'video/quicktime'];
                        if (!allowedVideoTypes.includes(file.mimetype)) {
                            errors.push(`Invalid video file type: ${file.originalname}. Only videos are allowed.`);
                        }
                    }
                });
            });

            if (errors.length > 0) {
                // Remove uploaded files if there are validation errors
                Object.keys(files).forEach((fieldname) => {
                    files[fieldname].forEach((file) => {
                        fs.unlink(file.path, (unlinkErr) => {
                            if (unlinkErr) {
                                console.error(`Failed to delete file: ${file.path}`, unlinkErr);
                            }
                        });
                    });
                });

                req.flash('error', errors.join(' '));
                return res.redirect('back');
            }

            req.files = files;
            next();
        });
    };
};

// Define the fields to upload
const fieldsToUpload = [
    { name: 'image', maxCount: 1 },
    { name: 'video', maxCount: 1 },
    { name: 'gallery', maxCount: 30 }
];

const multiplefile = uploadMiddleware(fieldsToUpload);

module.exports = multiplefile;
