import 'package:flutter/material.dart';

void main() {
  runApp(Contact());
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ContactFormScreen(),
    );
  }
}

class ContactFormScreen extends StatefulWidget {
  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
        ),
      );

      // Clear the form after submission
      _subjectController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar
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
                        Icon(Icons.message, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Contact Provider',
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

          // Intro Message
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.blue[50],
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Questions? Shoot any non-urgent questions to your provider.\n'
                        '\nIf you have any urgent concerns, please call your provider at **000-000-0000**.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

          // Contact Form
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subject Field
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _subjectController,
                          decoration: InputDecoration(
                            labelText: 'Subject',
                            hintText: 'Enter the subject',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a subject';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Message Field (Textarea)
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _messageController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            hintText: 'Write your message here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Submit Button
                    Center(
                      child: Container(
                        width: 300, // Custom Width
                        height: 55, // Custom Height
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white, // Icon color
                        ),
                        label: const Text(
                          'Submit Message',
                          style: TextStyle(color: Colors.white), // Text color
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 73,69,180),
                          textStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                    ),
              ),

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
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
