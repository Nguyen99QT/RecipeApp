// Importing required modules 
const sha256 = require("sha256");
const jwt = require("jsonwebtoken");
const otpGenerator = require("otp-generator");

// Importing models
const userModel = require("../model/userModel");
const categoryModel = require("../model/categoryModel");
const cuisinesModel = require("../model/cuisinesModel");
const recipeModel = require("../model/recipeModel");
const introModel = require("../model/introModel");
const faqModel = require("../model/faqModel");
const adsModel = require("../model/adsModel");
const settingModel = require("../model/settingModel");
const otpModel = require("../model/otpModel");
const ForgotPasswordOtpModel = require("../model/ForgotPasswordOtpModel");
const favouriteRecipeModel = require("../model/favouriteRecipeModel");
const reviewModel = require("../model/reviewModel");
const notificationModel = require("../model/notificationModel");

// Importing services
const sendOtpMail = require("../services/sendOtpMail");

// Check if user is already registered
const CheckRegisterUser = async (req, res) => {
    try {
        const { email } = req.body;
        
        const existingUser = await userModel.findOne({ email });
        
        if (existingUser) {
            return res.status(400).json({
                status: false,
                message: "User already exists with this email"
            });
        }
        
        return res.status(200).json({
            status: true,
            message: "Email is available for registration"
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// User signup
const SignUp = async (req, res) => {
    try {
        console.log('=== SIGNUP REQUEST RECEIVED ===');
        console.log('Request body:', req.body);
        
        const { firstname, lastname, email, country_code, phone, password } = req.body;
        
        console.log('Extracted data:', { firstname, lastname, email, country_code, phone, password: '***' });
        
        // Check if user already exists
        const existingUser = await userModel.findOne({ email });
        if (existingUser) {
            console.log('User already exists:', email);
            return res.status(400).json({
                status: false,
                message: "User already exists with this email"
            });
        }
        
        // Hash password
        const hashedPassword = sha256.x2(password);
        
        // Create new user
        const newUser = new userModel({
            firstname,
            lastname,
            email,
            country_code,
            phone,
            password: hashedPassword
        });
        
        const savedUser = await newUser.save();
        console.log('User saved successfully:', savedUser._id);
        
        // Generate OTP - manual generation to ensure only digits
        const otp = Math.floor(1000 + Math.random() * 9000); // Generate 4-digit number
        console.log('Generated OTP:', otp);
        console.log('Is valid number:', !isNaN(otp));
        
        // Save OTP with debugging
        console.log('Creating OTP data:', { userId: savedUser._id, email, otp });
        const otpData = new otpModel({
            userId: savedUser._id,
            email: email,
            otp: otp
        });
        
        try {
            await otpData.save();
            console.log('OTP saved successfully');
        } catch (otpError) {
            console.log('Error saving OTP:', otpError.message);
            throw new Error('Failed to save OTP: ' + otpError.message);
        }
        
        // Send OTP email
        try {
            await sendOtpMail(email, otp, firstname, lastname);
            console.log('OTP email sent successfully to:', email, 'OTP:', otp);
        } catch (emailError) {
            console.log('Error sending OTP email:', emailError.message);
            // Don't throw error here, user is created successfully
            console.log('User created but email failed to send');
        }
        
        const response = {
            status: true,
            message: "User registered successfully. OTP sent to email.",
            userId: savedUser._id
        };
        
        console.log('=== SIGNUP SUCCESS RESPONSE ===');
        console.log('Response:', response);
        
        return res.status(200).json(response);
        
    } catch (error) {
        console.log('=== SIGNUP ERROR ===');
        console.log('Error message:', error.message);
        console.log('Error stack:', error.stack);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Verify OTP
const VerifyOtp = async (req, res) => {
    try {
        console.log('=== VERIFY OTP REQUEST ===');
        console.log('Request body:', req.body);
        
        const { userId, email, otp } = req.body;
        console.log('Extracted userId:', userId, 'email:', email, 'otp:', otp);
        
        let otpData;
        
        if (userId) {
            // Find by userId and otp
            otpData = await otpModel.findOne({ userId, otp });
            console.log('OTP search by userId - found:', otpData);
        } else if (email) {
            // Find by email and otp
            otpData = await otpModel.findOne({ email, otp });
            console.log('OTP search by email - found:', otpData);
        } else {
            console.log('=== MISSING PARAMETERS ===');
            return res.status(400).json({
                status: false,
                message: "Missing userId or email parameter"
            });
        }
        
        if (!otpData) {
            console.log('=== OTP VERIFICATION FAILED ===');
            console.log('No matching OTP found for', userId ? `userId: ${userId}` : `email: ${email}`, 'otp:', otp);
            return res.status(400).json({
                status: false,
                message: "Invalid OTP"
            });
        }
        
        // Get userId from otpData if not provided
        const finalUserId = userId || otpData.userId;
        
        // Update user verification status
        await userModel.findByIdAndUpdate(finalUserId, { isOTPVerified: 1 });
        console.log('User verification status updated for userId:', finalUserId);
        
        // Delete OTP
        await otpModel.deleteOne({ _id: otpData._id });
        console.log('OTP deleted successfully');
        
        console.log('=== OTP VERIFICATION SUCCESS ===');
        return res.status(200).json({
            status: true,
            message: "OTP verified successfully"
        });
        
    } catch (error) {
        console.error('=== VERIFY OTP ERROR ===');
        console.error('Error message:', error.message);
        console.error('Error stack:', error.stack);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// User signin
const SignIn = async (req, res) => {
    try {
        console.log('=== SIGNIN REQUEST RECEIVED ===');
        console.log('Request body:', req.body);
        
        const { email, password } = req.body;
        
        console.log('Login attempt for email:', email);
        
        const hashedPassword = sha256.x2(password);
        
        const user = await userModel.findOne({ email, password: hashedPassword });
        
        if (!user) {
            console.log('Login failed: Invalid credentials for', email);
            return res.status(400).json({
                status: false,
                message: "Invalid email or password"
            });
        }
        
        if (user.isOTPVerified === 0) {
            console.log('Login failed: Email not verified for', email);
            return res.status(400).json({
                status: false,
                message: "Please verify your email first",
                isVerified: false,
                userId: user._id
            });
        }
        
        // Generate JWT token
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET_KEY, { expiresIn: '30d' });
        
        const response = {
            status: true,
            message: "Login successful",
            token: token,
            user: {
                id: user._id,
                firstname: user.firstname,
                lastname: user.lastname,
                email: user.email,
                phone: user.phone,
                avatar: user.avatar
            }
        };
        
        console.log('=== SIGNIN SUCCESS RESPONSE ===');
        console.log('User logged in:', email);
        console.log('Response:', { ...response, token: 'TOKEN_HIDDEN' });
        
        return res.status(200).json(response);
        
    } catch (error) {
        console.log('=== SIGNIN ERROR ===');
        console.log('Error message:', error.message);
        console.log('Error stack:', error.stack);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Check if account is verified
const isVerifyAccount = async (req, res) => {
    try {
        const { userId, email } = req.body;
        
        let user;
        if (userId) {
            user = await userModel.findById(userId);
        } else if (email) {
            user = await userModel.findOne({ email: email });
        } else {
            return res.status(400).json({
                status: false,
                message: "userId or email is required"
            });
        }
        
        if (!user) {
            return res.status(404).json({
                status: false,
                message: "User not found"
            });
        }
        
        return res.status(200).json({
            status: true,
            isVerified: user.isOTPVerified === 1
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Resend OTP
const resendOtp = async (req, res) => {
    try {
        const { userId, email } = req.body;
        
        let user;
        if (userId) {
            user = await userModel.findById(userId);
        } else if (email) {
            user = await userModel.findOne({ email });
        } else {
            return res.status(400).json({
                status: false,
                message: "Either userId or email is required"
            });
        }
        
        if (!user) {
            return res.status(404).json({
                status: false,
                message: "User not found"
            });
        }
        
        // Delete existing OTP
        await otpModel.deleteMany({ userId: user._id });
        
        // Generate new OTP
        const otp = Math.floor(1000 + Math.random() * 9000); // Consistent with signup
        
        // Save new OTP
        const otpData = new otpModel({
            userId: user._id,
            email: user.email,
            otp: otp
        });
        await otpData.save();
        
        // Send OTP email
        await sendOtpMail(user.email, otp, user.firstname || 'User', user.lastname || '');
        
        return res.status(200).json({
            status: true,
            message: "OTP sent successfully"
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Forgot password
const ForgotPassword = async (req, res) => {
    try {
        const { email } = req.body;
        
        const user = await userModel.findOne({ email });
        
        if (!user) {
            return res.status(404).json({
                status: false,
                message: "User not found with this email"
            });
        }
        
        // Generate OTP
        const otp = parseInt(otpGenerator.generate(4, { digits: true, alphabets: false, upperCase: false, specialChars: false }));
        
        // Delete existing forgot password OTP
        await ForgotPasswordOtpModel.deleteMany({ userId: user._id });
        
        // Save OTP
        const otpData = new ForgotPasswordOtpModel({
            userId: user._id,
            email: email,
            otp: otp
        });
        await otpData.save();
        
        // Send OTP email
        await sendOtpMail(email, otp, user.firstname || 'User', user.lastname || '');
        
        return res.status(200).json({
            status: true,
            message: "OTP sent to your email",
            userId: user._id
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Forgot password verification
const ForgotPasswordVerification = async (req, res) => {
    try {
        const { userId, otp } = req.body;
        
        const otpData = await ForgotPasswordOtpModel.findOne({ userId, otp });
        
        if (!otpData) {
            return res.status(400).json({
                status: false,
                message: "Invalid OTP"
            });
        }
        
        return res.status(200).json({
            status: true,
            message: "OTP verified successfully"
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Reset password
const ResetPassword = async (req, res) => {
    try {
        const { userId, otp, newPassword } = req.body;
        
        const otpData = await ForgotPasswordOtpModel.findOne({ userId, otp });
        
        if (!otpData) {
            return res.status(400).json({
                status: false,
                message: "Invalid OTP"
            });
        }
        
        const hashedPassword = sha256.x2(newPassword);
        
        // Update password
        await userModel.findByIdAndUpdate(userId, { password: hashedPassword });
        
        // Delete OTP
        await ForgotPasswordOtpModel.deleteOne({ userId, otp });
        
        return res.status(200).json({
            status: true,
            message: "Password reset successfully"
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Edit user profile
const UserEdit = async (req, res) => {
    try {
        const { firstname, lastname, phone, country_code } = req.body;
        const userId = req.userId;
        
        const updatedUser = await userModel.findByIdAndUpdate(
            userId,
            { firstname, lastname, phone, country_code },
            { new: true }
        ).select('-password');
        
        return res.status(200).json({
            status: true,
            message: "Profile updated successfully",
            user: updatedUser
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get user details
const GetUser = async (req, res) => {
    try {
        const userId = req.userId;
        
        const user = await userModel.findById(userId).select('-password');
        
        if (!user) {
            return res.status(404).json({
                status: false,
                message: "User not found"
            });
        }
        
        return res.status(200).json({
            status: true,
            user: user
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Upload user image
const UploadImage = async (req, res) => {
    try {
        const userId = req.userId;
        
        if (!req.file) {
            return res.status(400).json({
                status: false,
                message: "No image uploaded"
            });
        }
        
        const updatedUser = await userModel.findByIdAndUpdate(
            userId,
            { avatar: req.file.filename },
            { new: true }
        ).select('-password');
        
        return res.status(200).json({
            status: true,
            message: "Image uploaded successfully",
            user: updatedUser
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Change password
const ChangePassword = async (req, res) => {
    try {
        const { oldPassword, newPassword } = req.body;
        const userId = req.userId;
        
        const hashedOldPassword = sha256.x2(oldPassword);
        const user = await userModel.findOne({ _id: userId, password: hashedOldPassword });
        
        if (!user) {
            return res.status(400).json({
                status: false,
                message: "Current password is incorrect"
            });
        }
        
        const hashedNewPassword = sha256.x2(newPassword);
        
        await userModel.findByIdAndUpdate(userId, { password: hashedNewPassword });
        
        return res.status(200).json({
            status: true,
            message: "Password changed successfully"
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Delete user account
const DeleteAccountUser = async (req, res) => {
    try {
        const userId = req.userId;
        
        await userModel.findByIdAndDelete(userId);
        await favouriteRecipeModel.deleteMany({ userId });
        await reviewModel.deleteMany({ userId });
        
        return res.status(200).json({
            status: true,
            message: "Account deleted successfully"
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get all intro
const getAllIntro = async (req, res) => {
    try {
        const intros = await introModel.find().sort({ createdAt: 1 });
        
        return res.status(200).json({
            status: true,
            data: intros
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get all categories
const GetAllCategory = async (req, res) => {
    try {
        const categories = await categoryModel.find().sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: categories
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get all cuisines
const GetAllCuisines = async (req, res) => {
    try {
        const cuisines = await cuisinesModel.find().sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: cuisines
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get all recipes
const GetAllRecipe = async (req, res) => {
    try {
        const recipes = await recipeModel.find()
            .populate('categoryId', 'name')
            .populate('cuisinesId', 'name')
            .sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: recipes
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get popular recipes
const popularRecipe = async (req, res) => {
    try {
        const recipes = await recipeModel.find()
            .populate('categoryId', 'name')
            .populate('cuisinesId', 'name')
            .sort({ createdAt: -1 })
            .limit(10);
        
        return res.status(200).json({
            status: true,
            data: recipes
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get recommended recipes
const recommendedRecipe = async (req, res) => {
    try {
        const recipes = await recipeModel.find()
            .populate('categoryId', 'name')
            .populate('cuisinesId', 'name')
            .sort({ createdAt: -1 })
            .limit(10);
        
        return res.status(200).json({
            status: true,
            data: recipes
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get recipe by ID
const GetRecipeById = async (req, res) => {
    try {
        const { recipeId } = req.body;
        
        const recipe = await recipeModel.findById(recipeId)
            .populate('categoryId', 'name')
            .populate('cuisinesId', 'name');
        
        if (!recipe) {
            return res.status(404).json({
                status: false,
                message: "Recipe not found"
            });
        }
        
        return res.status(200).json({
            status: true,
            data: recipe
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get recipes by category ID
const GetRecipeByCategoryId = async (req, res) => {
    try {
        const { categoryId } = req.body;
        
        const recipes = await recipeModel.find({ categoryId })
            .populate('categoryId', 'name')
            .populate('cuisinesId', 'name')
            .sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: recipes
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Filter recipes
const FilterRecipe = async (req, res) => {
    try {
        const { categoryId, cuisinesId, difficultyLevel } = req.body;
        
        let query = {};
        
        if (categoryId) query.categoryId = categoryId;
        if (cuisinesId) query.cuisinesId = cuisinesId;
        if (difficultyLevel) query.difficultyLevel = difficultyLevel;
        
        const recipes = await recipeModel.find(query)
            .populate('categoryId', 'name')
            .populate('cuisinesId', 'name')
            .sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: recipes
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Search recipes
const SearchRecipes = async (req, res) => {
    try {
        const { searchTerm } = req.body;
        
        const recipes = await recipeModel.find({
            $or: [
                { name: { $regex: searchTerm, $options: 'i' } },
                { ingredients: { $regex: searchTerm, $options: 'i' } },
                { overview: { $regex: searchTerm, $options: 'i' } }
            ]
        })
            .populate('categoryId', 'name')
            .populate('cuisinesId', 'name')
            .sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: recipes
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Add favourite recipe
const AddFavouriteRecipe = async (req, res) => {
    try {
        const { recipeId } = req.body;
        const userId = req.userId;
        
        const existingFavourite = await favouriteRecipeModel.findOne({ userId, recipeId });
        
        if (existingFavourite) {
            return res.status(400).json({
                status: false,
                message: "Recipe already added to favourites"
            });
        }
        
        const favourite = new favouriteRecipeModel({ userId, recipeId });
        await favourite.save();
        
        return res.status(200).json({
            status: true,
            message: "Recipe added to favourites"
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get all favourite recipes
const GetAllFavouriteRecipes = async (req, res) => {
    try {
        const userId = req.userId;
        
        const favourites = await favouriteRecipeModel.find({ userId })
            .populate({
                path: 'recipeId',
                populate: [
                    { path: 'categoryId', select: 'name' },
                    { path: 'cuisinesId', select: 'name' }
                ]
            })
            .sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: favourites
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Delete favourite recipe
const DeleteFavouriteRecipe = async (req, res) => {
    try {
        const { recipeId } = req.body;
        const userId = req.userId;
        
        await favouriteRecipeModel.deleteOne({ userId, recipeId });
        
        return res.status(200).json({
            status: true,
            message: "Recipe removed from favourites"
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Add review
const AddReview = async (req, res) => {
    try {
        const { recipeId, rating, review } = req.body;
        const userId = req.userId;
        
        const newReview = new reviewModel({
            userId,
            recipeId,
            rating,
            review
        });
        
        await newReview.save();
        
        return res.status(200).json({
            status: true,
            message: "Review added successfully"
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get reviews by recipe ID
const GetReviewByRecipeId = async (req, res) => {
    try {
        const { recipeId } = req.body;
        
        const reviews = await reviewModel.find({ recipeId })
            .populate('userId', 'firstname lastname avatar')
            .sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: reviews
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get all FAQ
const getAllFaq = async (req, res) => {
    try {
        const faqs = await faqModel.find().sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: faqs
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get admob ads
const getAdmob = async (req, res) => {
    try {
        const ads = await adsModel.find();
        
        return res.status(200).json({
            status: true,
            data: ads
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get policy and terms
const GetPolicyAndTerms = async (req, res) => {
    try {
        const settings = await settingModel.find();
        
        return res.status(200).json({
            status: true,
            data: settings
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

// Get all notifications
const GetAllNotification = async (req, res) => {
    try {
        const notifications = await notificationModel.find().sort({ createdAt: -1 });
        
        return res.status(200).json({
            status: true,
            data: notifications
        });
        
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

module.exports = {
    CheckRegisterUser,
    SignUp,
    VerifyOtp,
    SignIn,
    isVerifyAccount,
    resendOtp,
    ForgotPassword,
    ForgotPasswordVerification,
    ResetPassword,
    UserEdit,
    GetUser,
    UploadImage,
    ChangePassword,
    DeleteAccountUser,
    getAllIntro,
    GetAllCategory,
    GetAllCuisines,
    GetAllRecipe,
    popularRecipe,
    recommendedRecipe,
    GetRecipeById,
    GetRecipeByCategoryId,
    FilterRecipe,
    SearchRecipes,
    AddFavouriteRecipe,
    GetAllFavouriteRecipes,
    DeleteFavouriteRecipe,
    AddReview,
    GetReviewByRecipeId,
    getAllFaq,
    getAdmob,
    GetPolicyAndTerms,
    GetAllNotification
};
