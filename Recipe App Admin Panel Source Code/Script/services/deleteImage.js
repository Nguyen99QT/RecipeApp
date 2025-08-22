// Importing required modules 
const fs = require("fs");

// Defining the path where uploaded images are stored
const imagePath = "./uploads/images/"

// Defining the path where uploaded videos  are stored
const videoPath = "./uploads/video/"


// Function to delete an uploaded file
function deleteImages(filename) {

    try {

        if (fs.existsSync(imagePath + filename)) {

            fs.unlinkSync(imagePath + filename);

        }

    } catch (error) {
        console.error(`Error deleting file`, error.message);
        throw error;
    }
}


// Function to delete an uploaded file
function deleteVideo(filename) {

    try {

        if (fs.existsSync(videoPath + filename)) {

            fs.unlinkSync(videoPath + filename);

        }

    } catch (error) {
        console.error(`Error deleting video`, error.message);
        throw error;
    }
}

module.exports = {

    deleteImages,
    deleteVideo

}