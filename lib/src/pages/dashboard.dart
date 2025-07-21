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
                    title: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home, color: Colors.white),
                        SizedBox(width: 8),
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
                _buildFullWidthCard(
                  title: 'John Doe',
                  subtitle:
                  'Your Current Lithium Dose is 11mg, Current Lithium Level is 11mg, Last Drawn 2025.07.16 and your Target Lithium Range 1.0-1.2',
                  icon: Icons.person,
                  backgroundColor: Colors.deepPurple,
                  titleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  subtitleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.white70,
                  ),
                ),
                _buildFullWidthCard(
                  title: 'Lab Results',
                  subtitle:
                  'Your Current TSH Level is 0.89, Last Drawn on 2025-07-16, Current GFR is 0.6 Last Drawn on 2025-07-16',
                  icon: Icons.health_and_safety,
                  backgroundColor: Colors.deepPurple,
                  titleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  subtitleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.white70,
                  ),
                ),
                _buildFullWidthCard(
                  title: 'Diagnosis',
                  subtitle: 'Treatment Resistant Depression.',
                  icon: Icons.report,
                  backgroundColor: Colors.deepPurple,
                  titleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  subtitleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.white70,
                  ),
                ),
                _buildFullWidthCard(
                  title: 'Allergies',
                  subtitle: 'test',
                  icon: Icons.sick,
                  backgroundColor: Colors.deepPurple,
                  titleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  subtitleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.white70,
                  ),
                ),
                _buildFullWidthCard(
                  title: 'Potential Drug Interactions',
                  subtitle: 'ACE-I/ ARB,SSRI’s,Antipsychotics',
                  icon: Icons.accessibility,
                  backgroundColor: Colors.deepPurple,
                  titleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  subtitleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.white70,
                  ),
                ),
                // Grid section remains unchanged
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
                        backgroundColor: Colors.indigo,
                        titleColor: Colors.white,
                        subtitleColor: Colors.white70,
                      ),
                      _buildGridCard(
                        title: 'Next Appointment',
                        subtitle: '2025-01-10',
                        icon: Icons.calendar_today,
                        backgroundColor: Colors.indigo,
                        titleColor: Colors.white,
                        subtitleColor: Colors.white70,
                      ),
                    ],
                  ),
                ),

                _buildFullWidthCard(
                  title: 'Dr. Jane Smith',
                  subtitle: 'Keep monitoring side effects closely.',
                  icon: Icons.comment,
                  backgroundColor: Colors.deepPurple,
                  titleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  subtitleStyleBuilder: (context) => TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          )
          ,
        ],
      ),
    );
  }

  Widget _buildFullWidthCard({
    required String title,
    required String subtitle,
    required IconData icon,
    Color backgroundColor = Colors.blue,
    TextStyle Function(BuildContext)? titleStyleBuilder,
    TextStyle Function(BuildContext)? subtitleStyleBuilder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0), // Slight rounding for visual polish
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final titleStyle = titleStyleBuilder?.call(context) ??
                        const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        );
                    final subtitleStyle = subtitleStyleBuilder?.call(context) ??
                        const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: titleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: subtitleStyle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildGridCard({
    required String title,
    required String subtitle,
    required IconData icon,
    Color backgroundColor = Colors.blue,
    Color titleColor = Colors.white,
    Color subtitleColor = Colors.white70,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = MediaQuery.of(context).size.width;
        double titleFontSize = width * 0.035;
        double subtitleFontSize = width * 0.03;

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
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
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                        color: titleColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
