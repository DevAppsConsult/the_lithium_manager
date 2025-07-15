import 'package:flutter/material.dart';

import 'src/pages/dashboard.dart';
import 'src/pages/notifications.dart';

void main() {
  runApp(IntroPage());
}

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'assets/avaters/onboard_one.png',
      'title': 'Welcome',
      'description': 'You are here because your medical provider has prescribed '
          'you Lithium Carbonate ( Li-thee-yum Kar-bon-ate). This is a medication '
          'that is used to control severe manic episodes in bipolar 1 disorder, '
          'prevent you from going into manic or depressive episodes, eliminate severe suicidal thoughts, '
          'or manage severe depression that has not respond to other treatments.',
      'imageHeight': 350.0,
    },
    {
      'image': 'assets/avaters/onboard_two.png',
      'title': 'How does it work?',
      'description': 'Lithium works exceptionally well for most patients, '
          'but requires a specific amount of medication to be effective and '
          'not affect other organs in your body like your kidneys or thyroid. '
          'Because of this, you will need to get your blood levels checked periodically '
          'when you start and while you are this medication.',
      'imageHeight':350.0,
    },
    {
      'image': 'assets/avaters/onboard_three.png',
      'title': 'So, what next?',
      'description': 'This app will help you by sending you reminders when your blood work is due, '
          'share tips on how the medication works in your body and let you know what signs to be '
          'concerned about and when to call your provider.  We are here to help you stay healthy!',
      'imageHeight': 350.0,
    },
  ];

  void _goToPage(int index) {
    if (index >= 0 && index < _pages.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = index;
      });
    }
  }

  void _goToDashboard() {
    // Replace this with actual dashboard navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Swipeable pages
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Column(
                  children: [
                    // Hero Image with Text Overlay
                    Stack(
                      children: [
                        Container(
                          height: page['imageHeight'],
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(page['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 30,
                          left: 100,
                          child: Text(
                            'Hi, John Doe',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        page['title'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Title & Description
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),

                        child: Text(
                          page['description'],
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Navigation Buttons
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous Button
                ElevatedButton(
                  onPressed: _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
                  child: const Text('Previous', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentPage > 0 ? Colors.black : Colors.grey,
                  ),
                ),



                // Next/Dashboard Button
                ElevatedButton(
                  onPressed: _currentPage < _pages.length - 1
                      ? () => _goToPage(_currentPage + 1)
                      : _goToDashboard,
                  child: Text(_currentPage < _pages.length - 1 ? 'Next' : 'Dashboard',style: const TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
