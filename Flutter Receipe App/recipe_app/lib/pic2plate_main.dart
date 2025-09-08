import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'domain/cubit/meal/meal_cubit.dart';
import 'domain/cubit/meal/meal_state.dart';

/// Entry point with pic2plate_ai architecture integration
/// Can run independently or alongside existing FlutterFlow app
void runPic2PlateApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  runApp(const Pic2PlateApp());
}

/// Pic2Plate AI App following clean architecture
class Pic2PlateApp extends StatelessWidget {
  const Pic2PlateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealCubit(),
      child: MaterialApp(
        title: 'Pic2Plate AI',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Poppins',
          useMaterial3: true,
        ),
        home: const Pic2PlateHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/// Main page with pic2plate_ai UI/UX
class Pic2PlateHomePage extends StatefulWidget {
  const Pic2PlateHomePage({super.key});

  @override
  State<Pic2PlateHomePage> createState() => _Pic2PlateHomePageState();
}

class _Pic2PlateHomePageState extends State<Pic2PlateHomePage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD1ECBC), // Light sage green
              Color(0xFFA9C6B9), // Muted turquoise
            ],
          ),
        ),
        child: SafeArea(
          child: PageView(
            controller: _pageController,
            children: [
              // Onboarding Page
              _buildOnboardingPage(),

              // Meal Creation Page
              const Pic2PlateMealCreationPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App Logo/Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: const Icon(
              Icons.restaurant_menu,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),

          // App Title
          const Text(
            'PIC2PLATE AI',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),

          // Subtitle with TyperAnimatedText effect
          const Text(
            'Transform your ingredients into delicious meals',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 50),

          // Feature highlights
          _buildFeatureItem(
            Icons.camera_alt,
            'Snap Photos',
            'Take pictures of your ingredients',
          ),
          const SizedBox(height: 20),
          _buildFeatureItem(
            Icons.auto_awesome,
            'AI Magic',
            'Get personalized recipe suggestions',
          ),
          const SizedBox(height: 20),
          _buildFeatureItem(
            Icons.restaurant,
            'Cook & Enjoy',
            'Follow step-by-step instructions',
          ),
          const SizedBox(height: 50),

          // CTA Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 8,
              ),
              child: const Text(
                'Create Your Meal Now!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Powered by
          const Text(
            'Powered by Gemini 1.5 Flash',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

/// Meal Creation Page with BLoC integration
class Pic2PlateMealCreationPage extends StatelessWidget {
  const Pic2PlateMealCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealCubit, MealState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              'Create Recipe',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: const Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Input selection cards
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'How would you like to input your ingredients?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 40),

                      // Multi-image option
                      _InputOptionCard(
                        icon: Icons.photo_library,
                        title: 'Multiple Photos',
                        subtitle: 'Take or select up to 5 photos',
                        onTap: null, // TODO: Implement
                      ),
                      SizedBox(height: 16),

                      // Single image option
                      _InputOptionCard(
                        icon: Icons.photo_camera,
                        title: 'Single Photo',
                        subtitle: 'Take one photo of ingredients',
                        onTap: null, // TODO: Implement
                      ),
                      SizedBox(height: 16),

                      // Text input option
                      _InputOptionCard(
                        icon: Icons.edit,
                        title: 'Text Input',
                        subtitle: 'Type your ingredients',
                        onTap: null, // TODO: Implement
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Input option card widget
class _InputOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _InputOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFD1ECBC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: const Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
