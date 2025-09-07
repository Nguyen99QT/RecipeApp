
// Importing models
const reviewModel = require("../model/reviewModel");
const settingModel = require("../model/settingModel");
const adminLoginModel = require("../model/adminLoginModel");

// Load view for all review
const loadReview = async (req, res) => {

    try {

        // fetch review với populate có điều kiện
        const reviews = await reviewModel.find()
            .populate("userId")
            .populate({
                path: "recipeId",
                select: "name image"
            })
            .sort({ createdAt: -1 }); // Sắp xếp mới nhất trước

        console.log('[DEBUG] Found reviews:', reviews.length);
        console.log('[DEBUG] App feedbacks (no recipeId):', reviews.filter(r => !r.recipeId).length);

        return res.render("review", { reviews });

    } catch (error) {
        console.log('[ERROR] loadReview:', error.message);
        return res.render("review", { reviews: [] });
    }
}

//for active review
const isEnableReview = async (req, res) => {

    try {

        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request
            const id = req.query.id;

            // Find current images
            const currentReview = await reviewModel.findById({ _id: id });

            // update status
            await reviewModel.findByIdAndUpdate({ _id: id }, { $set: { isEnable: currentReview.isEnable === false ? true : false } }, { new: true });

            return res.redirect('back');

        }
        else {

            req.flash('error', 'You have no access to enable/disable review, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
    }
}

module.exports = {
    loadReview,
    isEnableReview,
}