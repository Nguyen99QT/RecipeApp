// Importing required modules 
const express = require("express");
const session = require("express-session")
const flash = require('connect-flash');
const dotenv = require("dotenv");
const bodyParser = require("body-parser");
const path = require("path");
const MongoStore = require('connect-mongo');

// dotenv config
dotenv.config();

// Import database connection
require("./config/conn");

// Import flash middleware
const flashmiddleware = require('./config/flash');

// Create an Express app
const app = express();

// Configure session
app.use(session({
    secret: process.env.SESSION_SECRET_KEY,
    resave: false,
    saveUninitialized: false,
    store: MongoStore.create({
        mongoUrl: process.env.DB_CONNECTION,
        ttl: 3600
    })
}));

// Configure flash
app.use(flash())
app.use(flashmiddleware.setflash);

// Configure body-parser for handling form data
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Configure body-parser for handling form data
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Routes for the Admin section
const adminRoutes = require("./routes/adminRoutes");
app.use('/', adminRoutes);

// Routes for the API section
const apiRoutes = require("./routes/apiRoutes");
app.use('/api', apiRoutes);

// Start the server on the specified port
app.listen(process.env.SERVER_PORT, () => {
    console.log("server is start", process.env.SERVER_PORT);
})
