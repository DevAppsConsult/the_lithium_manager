import 'package:flutter/material.dart';

import 'contact.dart';

void main() {
  runApp(Dashboard());
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with large style
          SliverAppBar.large(
            expandedHeight: 300,
            stretch: true,
            pinned: true, // Keeps the AppBar pinned when scrolling
            backgroundColor: const Color.fromARGB(
                255, 73,69,180), // Collapsed background color
            foregroundColor: Colors.white, // Collapsed icon and text color
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate how much the app bar is collapsed
                double collapseRatio = (constraints.maxHeight - kToolbarHeight) /
                    (300 - kToolbarHeight);
                collapseRatio = collapseRatio.clamp(0.0, 1.0);

                // Interpolated background color
                Color appBarColor = Color.lerp(
                  const Color.fromARGB(
                      255, 73,69,180), // Collapsed color
                  Colors.transparent, // Expanded color
                  collapseRatio,
                )!;

                return Container(
                  decoration: BoxDecoration(
                    color: appBarColor,
                  ),
                  child: FlexibleSpaceBar(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.home, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Clinical Summary',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/avaters/banner.png',
                          fit: BoxFit.cover,
                        ),
                        // Add a gradient for better text readability
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showOptionsMenu(context),
              ),
            ],
          ),


          // Content starts here
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Full-width Cards with Background Images
                _buildFullWidthCard(
                  title: 'John Doe',
                  subtitle: 'Your Current Lithium Dose is 11mg, Current Lithium Level is 11mg, Last Drawn 2025.07.16 and your Target Lithium Range 1.0- 1.2',
                  icon: Icons.person,
                  imageUrl: 'assets/Backgrounds/1.png',
                ),
                _buildFullWidthCard(
                  title: 'Lab Results',
                  subtitle: 'Your Current TSH Level is 0.89, Last Drawn on 2025-07-16, Current GFR is 0.6 Last Drawn on 2025-07-16',
                  icon: Icons.change_circle,
                  imageUrl: 'assets/Backgrounds/2.png',
                ),
                _buildFullWidthCard(
                  title: 'Diagnosis',
                  subtitle: 'Treatment Resistant Depression.',
                  icon: Icons.change_circle,
                  imageUrl: 'assets/Backgrounds/1.png',
                ),
                _buildFullWidthCard(
                  title: 'Allergies',
                  subtitle: 'test',
                  icon: Icons.change_circle,
                  imageUrl: 'assets/Backgrounds/2.png',
                ),
                _buildFullWidthCard(
                  title: 'Potential Drug Interactions',
                  subtitle: 'ACE-I/ ARB,SSRI’s,Antipsychotics',
                  icon: Icons.change_circle,
                  imageUrl: 'assets/Backgrounds/1.png',
                ),

                // Grid Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildGridCard(
                        title: 'Next Lab Work Date',
                        subtitle: '2024-12-25',
                        icon: Icons.healing,
                        imageUrl: 'assets/Backgrounds/3.png',
                      ),
                      _buildGridCard(
                        title: 'Next Appointment',
                        subtitle: '2025-01-10',
                        icon: Icons.calendar_today,
                        imageUrl: 'assets/Backgrounds/5.jpg',
                      ),
                    ],
                  ),
                ),

                _buildFullWidthCard(
                  title: 'Dr. Jane Smith',
                  subtitle: 'Keep monitoring side effects closely.',
                  icon: Icons.comment,
                  imageUrl: 'assets/Backgrounds/4.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Full-Width Card Widget with Background Image
  Widget _buildFullWidthCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String imageUrl,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white60,
                child: Icon(icon, color: Colors.white),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Grid Card Widget with Background Image
  Widget _buildGridCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String imageUrl,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    radius: 24,
                    child: Icon(icon, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity, // Ensure the container takes full width
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Show PopupMenu with options
void _showOptionsMenu(BuildContext context) {
  showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(100.0, 100.0, 0.0, 0.0),
    items: [
      const PopupMenuItem(
        value: 'settings',
        child: Row(
          children: [
            Icon(Icons.settings, color: Colors.blue),
            SizedBox(width: 10),
            Text('Settings'),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'contact',
        child: Row(
          children: [
            Icon(Icons.message, color: Colors.red),
            SizedBox(width: 10),
            Text('Contact'),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'logout',
        child: Row(
          children: [
            Icon(Icons.exit_to_app, color: Colors.green),
            SizedBox(width: 10),
            Text('Logout'),
          ],
        ),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
    // Handle the selected option
    if (value != null) {
      switch (value) {
        case 'settings':
          print('Settings clicked');
          // Navigate to settings page
          break;
        case 'contact':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Contact()),
          );
          // Show help or contact support
          break;
        case 'logout':
          print('Logout clicked');
          // Handle logout functionality
          break;

      }
    }
  });
}
