"use strict";

// Importing required modules 
var mongoose = require("mongoose");

require("dotenv").config();

var connectUrl = process.env.DB_CONNECTION; // Connect to the MongoDB database 

mongoose.connect(connectUrl).then(function () {
  console.log("connect");
})["catch"](function (error) {
  console.log("not connect", error);
});
