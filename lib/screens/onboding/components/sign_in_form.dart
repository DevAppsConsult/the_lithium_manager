import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:the_lithium_management/models/Login.dart';
import 'package:the_lithium_management/screens/onboding/components/animated_btn.dart';
import 'package:the_lithium_management/Intro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_lithium_management/serviceApis/RemoteCalls.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String checkUser = "";
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  
  late SMITrigger confetti;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }
Future<void> saveData(dynamic data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> userProfiled = {
      "Name":data.firstName!=null?data.firstName:"" + " " + data.lastName!=null?data.lastName:"",
      "Email":data.email!=null?data.email:"--",
      "Phone":data.phone!=null?data.phone:"--",
      "Address":data.address!=null?data.address:"--",
      "PatientID":data.patientId !=null?data.patientId:"--"
     };
    await prefs.setString("userProfile", jsonEncode(userProfiled));
  // check login and grant access
 
}
  Future<void> signIn(BuildContext context) async {
    var data = await RemoteCalls().getLogin(emailController.text,passwordController.text) as Login;
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
      checkUser = data.operation; 
      saveData(data.patientData);
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (_formKey.currentState!.validate() && checkUser == "success") {
        // show success
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroPage()),
        );
        check.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
          confetti.fire();
        });
      } else {
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (email) {},
                    controller: emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        CupertinoIcons.envelope_fill,
                        color: Colors.black,
                      ),
                    )),
                  ),
                ),
                const Text(
                  "Password",
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (password) {},
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        CupertinoIcons.lock,
                        color: Colors.black,
                      ),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        signIn(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xB3C5F4FF),
                          minimumSize: const Size(double.infinity, 56),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)))),
                      icon: const Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.black,
                      ),
                      label: const Text("Sign In")),
                )
              ],
            )),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                "assets/RiveAssets/check.riv",
                onInit: (artboard) {
                  StateMachineController controller =
                      getRiveController(artboard);
                  check = controller.findSMI("Check") as SMITrigger;
                  error = controller.findSMI("Error") as SMITrigger;
                  reset = controller.findSMI("Reset") as SMITrigger;
                },
              ))
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
                child: Transform.scale(
                scale: 6,
                child: RiveAnimation.asset(
                  "assets/RiveAssets/confetti.riv",
                  onInit: (artboard) {
                    StateMachineController controller =
                        getRiveController(artboard);
                    confetti =
                        controller.findSMI("Trigger explosion") as SMITrigger;
                  },
                ),
              ))
            : const SizedBox()
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
