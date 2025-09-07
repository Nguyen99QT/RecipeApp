"use strict";

var mongoose = require("mongoose");

var notificationSchema = new mongoose.Schema({
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
    "enum": ['general', 'new_recipe'],
    "default": 'general'
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
    "default": true
  }
}, {
  timestamps: true
});
module.exports = mongoose.model('notification', notificationSchema);