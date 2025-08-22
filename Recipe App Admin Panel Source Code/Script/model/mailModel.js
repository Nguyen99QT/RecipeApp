const mongoose = require('mongoose');

const MailSchema = mongoose.Schema({

    host: {
        type: String,
        trim:true,
        required: true
    },
    port: {
        type: String,
        trim:true,
        required: true
    },
    mail_username: {
        type: String,
        trim:true,
        required: true
    },
    mail_password: {
        type: String,
        trim:true,
        required: true
    },
    encryption: {
        type: String,
        trim:true,
        required: true
    },
    senderEmail: {
        type: String,
        trim:true,
        required: true
    }

},
    {
        timestamps: true
    }
);

const mailModel = mongoose.model('smpts', MailSchema);

module.exports = mailModel;