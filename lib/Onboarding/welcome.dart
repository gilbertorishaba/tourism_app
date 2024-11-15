import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  int currentPage = 0;
  List<String> backgroundImages = [
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg'
  ];

  @override
  void initState() {
    super.initState();
    // want to achieve changing images every 5 seconds
    _startImageRotation();
  }

  void _startImageRotation() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        currentPage = (currentPage + 1) % backgroundImages.length;
      });
      _startImageRotation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Dynamic background image
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Container(
              key: ValueKey<String>(backgroundImages[currentPage]),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImages[currentPage]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              buildOnboardingPage('Discover New Destinations',
                  'Explore the world with handpicked locations and personalized suggestions.'),
              buildOnboardingPage('Easy Booking & Planning',
                  'Plan your trips easily with our advanced booking system.'),
              buildOnboardingPage('Exclusive Travel Deals',
                  'Unlock access to exclusive deals tailored just for you.'),
            ],
          ),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.white54,
                dotHeight: 10,
                dotWidth: 10,
                spacing: 16,
              ),
            ),
          ),
          // Skip and Continue Buttons
          Positioned(
            bottom: 20,
            right: 20,
            child: onLastPage
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Get Started'),
                  )
                : TextButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Next',
                        style: TextStyle(color: Colors.white)),
                  ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: onLastPage
                ? const SizedBox.shrink()
                : TextButton(
                    onPressed: () {
                      _controller.jumpToPage(2);
                    },
                    child: const Text('Skip',
                        style: TextStyle(color: Colors.white)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildOnboardingPage(String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 250),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                  blurRadius: 10, color: Colors.black45, offset: Offset(2, 2))
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
