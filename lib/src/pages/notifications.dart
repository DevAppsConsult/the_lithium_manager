import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_lithium_management/models/NotificationsModel.dart';
import 'package:the_lithium_management/serviceApis/RemoteCalls.dart';
import 'package:the_lithium_management/src/pages/dashboard.dart';
import 'package:the_lithium_management/src/pages/tips.dart';
import 'package:the_lithium_management/src/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contact.dart';

void main() {
  runApp(NotificationApp());
}

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Notifications(),
    );
  }
}

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<Notifications> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Dashboard(),
    Tips(),
    NotificationPage(),
    MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.light_mode),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: const Color.fromRGBO(73, 69, 180, 1),
      ),
    );
  }
}

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> notifications = [];
  late SharedPreferences prefs;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    
  }

Future<void> getData() async {
  prefs = await SharedPreferences.getInstance();
  var stringified = prefs.getString("userProfile");
  Map<String, dynamic> user = jsonDecode(stringified!);
  
  getUser(user['Email']!);
}

 getUser(String pID) async{
    
     var data = await RemoteCalls().getNotifications(pID!) as NotificationsModel;
     
   setState(() {
       notifications = data.data as List<dynamic>;
    });
   }
  

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
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
                      Icon(Icons.notifications, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Notifications',
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

    /// Notification List using SliverList
    SliverList(
    delegate: SliverChildBuilderDelegate(
    (context, index) {
    return Padding(
    padding: const EdgeInsets.symmetric(
    horizontal: 8.0, vertical: 4.0),
    child: Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    child: ListTile(
    leading: const CircleAvatar(
    backgroundColor: Colors.blueAccent,
    child: Icon(Icons.notifications, color: Colors.white),
    ),
    title: Text(
    notifications[index].notificationDate,
    style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
    notifications[index].notificationDetails,
    ),
    trailing: const Icon(Icons.chevron_right),
    ),
    ),
    );
    },
    childCount: notifications.length,
    )),
      ],
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

