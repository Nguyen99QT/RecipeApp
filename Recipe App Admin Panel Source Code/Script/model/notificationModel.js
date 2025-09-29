const mongoose = require("mongoose");

const notificationSchema = new mongoose.Schema({

    date: {
        type: String,
        required: true
    },
    title: {
        type: String,
        required: true
    },
    message: {
        type: String,
        required: true
    },
    type: {
        type: String,
        enum: ['general', 'new_recipe'],
        default: 'general'
    },
    recipeId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'recipes',
        required: false
    },
    recipeName: {
        type: String,
        required: false
    },
    isEnabled: {
        type: Boolean,
        default: true
    },
    readNotifications: {
        type: [mongoose.Schema.Types.ObjectId],
        ref: 'users',
        default: []
    }

},
    {
        timestamps: true
    }
);

module.exports = mongoose.model('notification', notificationSchema);
