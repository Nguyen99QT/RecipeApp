// Importing required modules 
const admin = require('firebase-admin');

const serviceAccount = require('../firebase.json');

// Initialize Firebase Admin SDK
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

// // const registrationTokens = "cLte7Mh0SaO6lkCTR9qDlV:APA91bGGKOob7C1QMQ1SaEuLCt9b_ddN7cftWYOqoUOOuP6zdtEgi3nvsmoAFVTRQuU0w4d1PugzGfTrG9WZfjPSaTPHeiWGxFjAT4E_lmir7WFR_Lq8QLRymKOZyRBxQZ0wRC99Egn9"

// const title = "Hello DreamVision";
// const description = "This is a test notification for you";

// Function to send notifications
const sendPushNotification = async (registrationTokens, title, message) => {

    const totalTokens = registrationTokens.length;

    // Iterate over each token and send the notification
    for (const token of registrationTokens) {
        const messagePayload = {
            notification: {
                title: title,
                body: message
            },
            token: token
        };

        try {
            // Send the notification
            const response = await admin.messaging().send(messagePayload);

            console.log(`Successfully sent notification to token: ${response}`);

        } catch (error) {
            console.error(`Failed to send notification to token:`, error);
        }
    }
};


// sendPushNotification();

module.exports = sendPushNotification;
