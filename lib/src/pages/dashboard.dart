import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_lithium_management/models/AppointmentsModel.dart';
import 'package:the_lithium_management/models/PatientProtocol.dart';
import '../../serviceApis/RemoteCalls.dart';
import 'contact.dart';
import 'package:the_lithium_management/screens/onboding/onboding_screen.dart';

void main() {
  runApp(MainDash());
}

class MainDash extends StatefulWidget {
  @override
  State<MainDash> createState() => Dashboard();
}

class Dashboard extends State<MainDash> {
  late SharedPreferences prefs;
  String pName = "--";
  String litDose = "--";
  String litLvl = "--";
  String lastDrawn = "--";
  String targetLit = "--";
  String litRange = "--";
  String tshLvl = "--";
  String tshLastDrawn = "--";
  String gfrLvl = "--";
  String gfrDate = "--";
  String diagnosis = "--";
  String allergy = "--";
  String potentialDrugsIndication = "--";
  String providerComments = '--';
  String providerNamed = "--";
  List<dynamic>? appointsDate = [];

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
      fetchProtocol(user['PatientID']);
      userAppointments(user['PatientID']);
 }

  Future<void> fetchProtocol(patientID) async {
    var reqData = await RemoteCalls().getProtocols(patientID) as PatientProtocol;


    setState(() {
      pName = reqData.data?.patientName?? '--';
      litDose = reqData.data?.lithiumDose?? '--';
      litLvl = reqData.data?.lithiumLevel?? '--';
      lastDrawn = reqData.data?.lithiumLevelDate?? '--';
      litRange = reqData.data?.targetLithiumRange?? '--';
      tshLvl = reqData.data?.tshLevel?? '--';
      tshLastDrawn = reqData.data?.tshDate?? '--';
      gfrLvl = reqData.data?.gfrLevel?? '--';
      gfrDate = reqData.data?.gfrDate?? '--';
      diagnosis = reqData.data?.patientDiagnosis?? '--';
      allergy = reqData.data?.allergies ?? '--';
      potentialDrugsIndication =reqData.data?.potentialDrugIndication !=null? jsonDecode(reqData.data?.potentialDrugIndication).join(', '):'--';
      providerComments = reqData.data?.providerComments??"--";
      providerNamed = reqData.data?.providerName??"--";
    });
  }
Future<void> userAppointments(patientID) async{
  var appointmentData = await RemoteCalls().getPatientAppointments(patientID) as Appointments;
  setState(() {
    appointsDate =(appointmentData!=null?appointmentData.data:"--") as List?; 
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
                double collapseRatio = (constraints.maxHeight - kToolbarHeight) / (300 - kToolbarHeight);
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
                        const Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black54,
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

          // Dashboard content here...
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildFullWidthCard(
                  title: pName??"--",
                  subtitle:
                  'Your Current Lithium Dose is ${litDose}, Current Lithium Level is ${litLvl}, Last Drawn ${lastDrawn} and your Target Lithium Range ${litRange}',
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
                  'Your Current TSH Level is ${tshLvl}, Last Drawn on ${tshLastDrawn}, Current GFR is ${gfrLvl} Last Drawn on ${gfrDate}',
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
                  subtitle: '${diagnosis}',
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
                  subtitle: '${allergy}',
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
                  subtitle: '${potentialDrugsIndication}',
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
                        subtitle: '${appointsDate!.isNotEmpty ? appointsDate![0].appointmentDates.toString() : "--"}',
                        icon: Icons.healing,
                        backgroundColor: Colors.indigo,
                        titleColor: Colors.white,
                        subtitleColor: Colors.white70,
                      ),
                      _buildGridCard(
                        title: 'Next Appointment',
                        subtitle: '${appointsDate!.length>1 ? appointsDate![1].appointmentDates.toString() : "--"}',
                        icon: Icons.calendar_today,
                        backgroundColor: Colors.indigo,
                        titleColor: Colors.white,
                        subtitleColor: Colors.white70,
                      ),
                    ],
                  ),
                ),

                _buildFullWidthCard(
                  title: '${providerNamed}',
                  subtitle: '${providerComments}',
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
          ),
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
            break;
          case 'contact':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Contact()),
            );
            break;
          case 'logout':
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                  (route) => false,
            );
            break;
        }
      }
    });
  }
}
