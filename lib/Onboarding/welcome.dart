import 'package:flutter/material.dart';

/// Model for destinlabel and image_url
class DestinationOption {
  final String label;
  final String imagePath;

  DestinationOption({
    required this.label,
    required this.imagePath,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Page controller for the 3-step pages
  final PageController _pageController = PageController();

  // Track current page (0,1,2)
  int currentPage = 0;

  //selecting
  int? _selectedInterest;
  int? _selectedDestinationIndex;

  // For the plan selection (Page 3)
  int? _selectedPlan;
  int? _selectedBasicFeature;
  int? _selectedPremiumFeature;

  // Background images for the animated switch
  final List<String> backgroundImages = [
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg'
  ];

  // Destination options for the grid (12 items in total)
  final List<DestinationOption> _destinationOptions = [
    DestinationOption(label: 'Paris', imagePath: 'assets/paris.jpg'),
    DestinationOption(label: 'New York', imagePath: 'assets/newyork.jpg'),
    DestinationOption(label: 'London', imagePath: 'assets/london.jpg'),
    DestinationOption(label: 'Tokyo', imagePath: 'assets/tokyo.jpg'),
    DestinationOption(label: 'Sydney', imagePath: 'assets/sydney.jpg'),
    DestinationOption(label: 'Rome', imagePath: 'assets/rome.jpg'),
    DestinationOption(label: 'Cairo', imagePath: 'assets/cairo.jpg'),
    DestinationOption(label: 'Dubai', imagePath: 'assets/dubai.jpg'),
    DestinationOption(label: 'Toronto', imagePath: 'assets/toronto.jpg'),
    DestinationOption(label: 'Rio', imagePath: 'assets/rio.jpg'),
    DestinationOption(label: 'Cape Town', imagePath: 'assets/capetown.jpg'),
    DestinationOption(label: 'Barcelona', imagePath: 'assets/barcelona.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    _startImageRotation();
  }

  // Rotates background images every 5 seconds
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
          // Animated background
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

          // Foreground content
          SafeArea(
            child: Column(
              children: [
                // Thick Stepper
                const SizedBox(height: 20),
                _buildThickStepper(),

                // Expanded PageView
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => currentPage = index);
                    },
                    children: [
                      _buildSelectInterestsPage(),
                      _buildSelectDestinationsPage(),
                      // Replaced _buildSelectLanguagePage() with _buildSelectPlanPage()
                      _buildSelectPlanPage(),
                    ],
                  ),
                ),

                // Action Buttons (vertical)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Skip for now
                      TextButton(
                        onPressed: () {
                          // Jump to the last page or do something else
                          _pageController.jumpToPage(2);
                        },
                        child: const Text(
                          'Skip for now',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      // Continue button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          // Move to next page or finish
                          final page = _pageController.page?.round() ?? 0;
                          if (page < 2) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            // Final action: navigate to next screen
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                        child: const Text('Continue'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //my stick_stepper build
  Widget _buildThickStepper() {
    // Titles for the 3 steps
    final stepTitles = [
      'Select Interests',
      'Select Destinations',
      'Select Your Plan',
    ];

    final pageIndex =
        _pageController.hasClients ? _pageController.page?.round() ?? 0 : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 6,
            width: double.infinity,
            color: Colors.white.withOpacity(0.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              stepTitles.length,
              (index) => Column(
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == pageIndex
                          ? Colors.blueAccent
                          : Colors.white.withOpacity(0.5),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stepTitles[index],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black45,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Page 1: Select Interests (radio buttons)
  Widget _buildSelectInterestsPage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Select Your Interests',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(2, 2),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildRadioOption(
              label: 'Mountain Climbing',
              groupValue: _selectedInterest,
              value: 1,
              onChanged: (val) => setState(() => _selectedInterest = val),
            ),
            _buildRadioOption(
              label: 'Beach Vacation',
              groupValue: _selectedInterest,
              value: 2,
              onChanged: (val) => setState(() => _selectedInterest = val),
            ),
            _buildRadioOption(
              label: 'Jungle Safaris',
              groupValue: _selectedInterest,
              value: 3,
              onChanged: (val) => setState(() => _selectedInterest = val),
            ),
            _buildRadioOption(
              label: 'Cruise Vacations',
              groupValue: _selectedInterest,
              value: 4,
              onChanged: (val) => setState(() => _selectedInterest = val),
            ),
            _buildRadioOption(
              label: 'Food & Drinks',
              groupValue: _selectedInterest,
              value: 5,
              onChanged: (val) => setState(() => _selectedInterest = val),
            ),
          ],
        ),
      ),
    );
  }

  //  Select Destinations
  Widget _buildSelectDestinationsPage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Select Destinations',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(2, 2),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // The grid of destination cards
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _destinationOptions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final destination = _destinationOptions[index];
                final isSelected = (index == _selectedDestinationIndex);

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedDestinationIndex = index);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Destination image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            destination.imagePath,
                            fit: BoxFit.cover,
                            height: 60,
                            width: 80,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 40);
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Destination label
                        Text(
                          destination.label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (isSelected)
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child:
                                Icon(Icons.check_circle, color: Colors.green),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Page 3: Select Your Plan
  Widget _buildSelectPlanPage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Your Plan',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(2, 2),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please select your plan',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),

            // BASIC PLAN CARD
            Card(
              color: Colors.white.withOpacity(0.85),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top-level radio to select Basic Plan
                    Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          groupValue: _selectedPlan,
                          onChanged: (val) {
                            setState(() => _selectedPlan = val);
                          },
                          activeColor: Colors.green,
                        ),
                        // Plan Title + Price in green
                        const Text.rich(
                          TextSpan(
                            text: 'Basic Plan - ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: '\$30',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_selectedPlan == 1) ...[
                      RadioListTile<int>(
                        title: const Text('Ad-supported experience'),
                        value: 101,
                        groupValue: _selectedBasicFeature,
                        onChanged: (val) {
                          setState(() => _selectedBasicFeature = val);
                        },
                        activeColor: Colors.green,
                      ),
                      RadioListTile<int>(
                        title: const Text('Save limited destination'),
                        value: 102,
                        groupValue: _selectedBasicFeature,
                        onChanged: (val) {
                          setState(() => _selectedBasicFeature = val);
                        },
                        activeColor: Colors.green,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // PREMIUM PLAN CARD
            Card(
              color: Colors.white.withOpacity(0.85),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top-level radio to select Premium Plan
                    Row(
                      children: [
                        Radio<int>(
                          value: 2,
                          groupValue: _selectedPlan,
                          onChanged: (val) {
                            setState(() => _selectedPlan = val);
                          },
                          activeColor: Colors.green,
                        ),
                        // Plan Title + Price in green
                        const Text.rich(
                          TextSpan(
                            text: 'Premium Plan - ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: '\$50',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_selectedPlan == 2) ...[
                      RadioListTile<int>(
                        title: const Text('Ad-free experience'),
                        value: 201,
                        groupValue: _selectedPremiumFeature,
                        onChanged: (val) {
                          setState(() => _selectedPremiumFeature = val);
                        },
                        activeColor: Colors.green,
                      ),
                      RadioListTile<int>(
                        title: const Text('Save unlimited destination'),
                        value: 202,
                        groupValue: _selectedPremiumFeature,
                        onChanged: (val) {
                          setState(() => _selectedPremiumFeature = val);
                        },
                        activeColor: Colors.green,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable method for building a RadioListTile
  Widget _buildRadioOption({
    required String label,
    required int value,
    required int? groupValue,
    required ValueChanged<int?> onChanged,
  }) {
    return RadioListTile<int>(
      title: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      activeColor: Colors.blueAccent,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
