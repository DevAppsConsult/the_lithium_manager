import 'package:flutter/material.dart';

import 'contact.dart';

void main() {
  runApp(Tips());
}

class Tips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AccordionScreen(),
    );
  }
}

class AccordionScreen extends StatelessWidget {
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
                        Icon(Icons.light_mode, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Helpful Tips',
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

          // SliverList for Accordion Cards
          SliverList(
            delegate: SliverChildListDelegate([
              AccordionCard(
                title: 'Helpful Tips',
                content: '•	Take your medication at bedtime, if possible \n'
                    '• Do not dramatically increase or decrease the amount of salt in your diet.\n'
                    '•	On the days that your blood work is due, please get your blood work done first '
                    'thing in the morning, about 12 hours after your last dose of Lithium. You DO NOT have to fast.\n'
                    '•	It is not uncommon to experience abdominal discomfort( stomach pain, nausea) when you start or '
                    'increase Lithium. This is because Lithium is broken down completely in your stomach.\n'
                    '•	Let you provider know if you are prescribed a medication called hydrocholorothiazide,'
                    ' or  NSAIDS like Celebrex, celecoxib , meloxicam or Mobic.\n'
                    '•	Avoid taking ibuprofen ( motrin, aleve) for pain or fever. You may take acetaminophen ( tylenol).\n'
                    '•	Let your psychiatric provider know if you are put on any new medications by other providers.',
                icon: 'assets/icons/icon_acc_one.png',  // Custom Image Icon
              ),
              AccordionCard(
                title: 'Side effects',
                content: 'As is the case with every drug, Lithium some side effects to be aware:-\n'
                    '•	Acne\n'
                    '•	Tremors (shaking of hands)\n'
                    '•	Increased thirst\n'
                    '•	Lightheadedness that should pass.',
                icon: 'assets/icons/icon_acc_two.png',  // Custom Image Icon
              ),
              AccordionCard(
                title: 'When to call your provider',
                content: 'Please let your provider know if you experience any of the following after starting or increasing  the medication:\n'
                    '•	Dizziness Nausea/vomiting, diarrhea, slurred speech, seizures, difficulty walking straight\n'
                    '•	Frequent daytime urination, urinating excessively at night, if this was not  a problem for you before starting Lithium.\n'
                    '•	If you are planning to get pregnant or are pregnant. Lithium can cause birth defects (Ebstein’s Anomaly) when taken late \n'
                    'in pregnancy, and you provider will need to take you off the medication towards the end of your 3rd trimester.',
                icon: 'assets/icons/icon_acc_three.png',  // Custom Image Icon
              ),

            ]),
          ),
        ],
      ),
    );
  }
}

class AccordionCard extends StatelessWidget {
  final String title;
  final String content;
  final String icon;

  AccordionCard({
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          leading: Image.network(
            icon,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                content,
                style: const TextStyle(fontSize: 12),
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
