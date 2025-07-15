import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_lithium_management/models/EditPatient.dart';
import 'package:the_lithium_management/serviceApis/RemoteCalls.dart';
import 'contact.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyProfile());
}

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => ProfileScreen();
}


class ProfileScreen extends State<MyProfile> {
late SharedPreferences prefs;
String userName = "";
String Emails = "";
String Phone = "";
String Address = "";

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
  setState(() {
    userName = user['Name'];
    Emails = user['Email'];
    Phone = user['Phone'];
    Address = user['Address'];
  });
}

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
            backgroundColor: const Color.fromARGB(255, 73, 69, 180),
            foregroundColor: Colors.white,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                double collapseRatio =
                    (constraints.maxHeight - kToolbarHeight) /
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
                        Icon(Icons.person, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'My Profile',
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

          // Profile details inside Cards
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ProfileCard(title: 'Full Name', value: userName),
                ProfileCard(title: 'Email', value: Emails),
                ProfileCard(title: 'Phone', value: Phone),
                ProfileCard(
                    title: 'Address',
                    value: Address),
                ProfileCard(title: 'Password', value: '********'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final String value;

  ProfileCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            _showEditDialog(context, title, value);
          },
        ),
      ),
    );
  }
}

// Show Edit Dialog
void _showEditDialog(BuildContext context, String title, String currentValue) {
  final TextEditingController controller =
  TextEditingController(text: currentValue);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog without saving
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Perform save action here
              print('$title updated to: ${controller.text}');
              _updateProfile(context,controller.text,title);
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

Future<void> _updateProfile(BuildContext context,String val,String titles) async {
  Navigator.of(context).pop(); // Close dialog after saving
  var prefs = await SharedPreferences.getInstance();
  var stringified = prefs.getString("userProfile");
  Map<String, dynamic> user = jsonDecode(stringified!);
   Map<String, dynamic> userProfiled = {
      "Name":titles=="Full Name"?val:user['Name'],
      "Email":titles=="Email"?val:user['Email'],
      "Phone":titles=="Phone"?val:user['Phone'],
      "Address":titles=="Address"?val:user['Address'],
      "Password":titles=="Password"?val:user['Password'],
     };
     // make API submission 
   var data = await RemoteCalls().editPatient(userProfiled) as EditPatient;
   print('data to: ${data.operationState}');
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
    if (value != null) {
      switch (value) {
        case 'settings':
          print('Settings clicked');
          break;
        case 'contact':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Contact()),
          );
          break;
        case 'logout':
          print('Logout clicked');
          break;
      }
    }
  });
}
