import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_lithium_management/models/NotificationsModel.dart';
import 'package:the_lithium_management/serviceApis/RemoteCalls.dart';
import 'package:the_lithium_management/src/pages/dashboard.dart';
import 'package:the_lithium_management/src/pages/tips.dart';
import 'package:the_lithium_management/src/pages/profile.dart';
import 'package:the_lithium_management/src/pages/contact.dart';
import 'package:the_lithium_management/screens/onboding/onboding_screen.dart';

void main() {
  runApp(Noftify());
}

class Noftify extends StatefulWidget {
  @override
  State<Noftify> createState() => Notifications();
}

class Notifications extends State<Noftify>  {
   late SharedPreferences prefs;
   List<dynamic> notifications = [];

   @override
    initState() {
     // TODO: implement initState
     super.initState();
     startProcess();
   }

   Future<void> startProcess() async {
   prefs = await SharedPreferences.getInstance();
      var stringified = prefs.getString("userProfile");
      Map<String, dynamic> user = jsonDecode(stringified!);
       getUserNotifications(user['PatientID']);
 } 

  Future<void> getUserNotifications(patientID) async {
    var reqData = await RemoteCalls().getNotifications(patientID) as NotificationsModel;
    setState(() {
      notifications  = reqData.data;
      print(notifications[0].notificationDate);
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
                       '${ notifications[index].notificationDate}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${notifications[index].notificationDetails}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                );
              },
              childCount: notifications.length,
            ),
          ),
        ],
      ),
    );
  }
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
    if (value != null) {
      switch (value) {
        case 'settings':
        // Navigate to settings page
          break;
        case 'contact':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Contact()),
          );
          break;
        case 'logout':
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OnboardingScreen()),
          );
          break;
      }
    }
  });
}
