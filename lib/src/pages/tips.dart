import 'package:flutter/material.dart';
import 'package:the_lithium_management/screens/onboding/onboding_screen.dart';
import 'contact.dart';

class Tips extends StatelessWidget {
  const Tips({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccordionScreen();
  }
}

class AccordionScreen extends StatelessWidget {
  const AccordionScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (Route<dynamic> route) => false,
    );
  }

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
      switch (value) {
        case 'settings':
        // Implement settings logic here
          break;
        case 'contact':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Contact()),
          );
          break;
        case 'logout':
          _logout(context);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 300,
            stretch: true,
            pinned: true,
            backgroundColor: const Color.fromARGB(255, 73, 69, 180),
            foregroundColor: Colors.white,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                double collapseRatio = (constraints.maxHeight - kToolbarHeight) /
                    (300 - kToolbarHeight);
                collapseRatio = collapseRatio.clamp(0.0, 1.0);

                Color appBarColor = Color.lerp(
                  const Color.fromARGB(255, 73, 69, 180),
                  Colors.transparent,
                  collapseRatio,
                )!;

                return Container(
                  decoration: BoxDecoration(color: appBarColor),
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
          SliverList(
            delegate: SliverChildListDelegate([
              AccordionCard(
                title: 'Helpful Tips',
                content: '• Take your medication at bedtime if possible\n'
                    '• Maintain a consistent salt intake\n'
                    '• Do bloodwork 12 hours after your last lithium dose\n'
                    '• Avoid NSAIDs like ibuprofen; use acetaminophen instead\n'
                    '• Notify provider of any new meds like hydrochlorothiazide\n'
                    '• Report side effects like nausea, tremors, or increased thirst',
                icon: 'assets/icons/icon_acc_one.png',
              ),
              AccordionCard(
                title: 'Side Effects',
                content: '• Acne\n'
                    '• Hand tremors\n'
                    '• Increased thirst\n'
                    '• Lightheadedness\n'
                    'All may reduce over time. Report severe issues.',
                icon: 'assets/icons/icon_acc_two.png',
              ),
              AccordionCard(
                title: 'When to Contact Your Provider',
                content: '• Severe dizziness, vomiting, seizures\n'
                    '• Excessive urination or speech changes\n'
                    '• Planning to become pregnant or already are',
                icon: 'assets/icons/icon_acc_three.png',
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

  const AccordionCard({
    super.key,
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
          leading: Image.asset(
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
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
