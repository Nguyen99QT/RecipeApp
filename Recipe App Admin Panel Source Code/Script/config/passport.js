// Importing required modules 
const passport = require('passport');
const userModel = require("../model/userModel");
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;

// Load environment variables
require('dotenv').config();

// JWT strategy options
const jwtOptions = {
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: process.env.JWT_SECRET_KEY,
};


// Define the JWT strategy
passport.use(new JwtStrategy(jwtOptions, async (payload, done) => {
    try {

        // Use findOne to find a user based on the payload information
        const user = await userModel.findOne({ _id: payload.id });
      
        if (user) {
            return done(null, user);
        } else {
            // If user is not found,
            return done(null, false, { message: "User not found" })
        }

    } catch (error) {
        // Handle unexpected errors
        console.error('Error during authentication:', error);
        return done(error, false);
    }
}));


