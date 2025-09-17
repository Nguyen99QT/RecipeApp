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

// Add CORS support for Flutter app
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
    
    // Handle preflight requests
    if (req.method === 'OPTIONS') {
        res.sendStatus(200);
    } else {
        next();
    }
});

// Configure body-parser for handling form data
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Routes for the API section (MUST be before admin routes)
const apiRoutes = require("./routes/apiRoutes");
app.use('/api', apiRoutes);

// Routes for the Admin section
const adminRoutes = require("./routes/adminRoutes");
app.use('/', adminRoutes);

// Start the server on the specified port and listen on all interfaces
const httpServer = app.listen(process.env.SERVER_PORT, '0.0.0.0', () => {
    console.log("server is start", process.env.SERVER_PORT);
    console.log("server listening on all interfaces (0.0.0.0)");
});

// Initialize WebSocket service for real-time notifications
const NotificationWebSocketService = require('./services/notificationWebSocketService');
global.notificationWS = new NotificationWebSocketService(httpServer);

console.log('📡 Real-time notification system initialized');
