// Importing required modules 
const mongoose = require("mongoose");

const connectUrl = process.env.DB_CONNECTION

// Connect to the MongoDB database 
mongoose.connect(connectUrl).then(() => {

    console.log("connect");

}).catch((error) => {

    console.log("not connect", error);

})