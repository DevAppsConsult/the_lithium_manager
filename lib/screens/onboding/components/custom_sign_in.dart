import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_lithium_management/screens/onboding/components/sign_in_form.dart';
import 'package:the_lithium_management/screens/onboding/components/custom_sign_up.dart';

Future<Object?> customSigninDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign up",
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => Center(
            child: Container(
              height: 620,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset:
                    false, // avoid overflow error when keyboard shows up
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 34, fontFamily: "Constantia"),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Welcome to The Lithium Manager",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SignInForm(),
                      TextButton(
                          onPressed: (){
                            print("Forgot Password button pressed");
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Forgot Password')),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "OR",
                              style: TextStyle(color: Colors.black26),
                            ),
                          ),
                          Expanded(
                            child: Divider(),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Text("Don´t have an account?",
                            style: TextStyle(color: Colors.black54)),

                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 0),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                              customSignupDialog(context, onClosed: (_) {

                              });
                            } ,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: const Color(0xB3C5F4FF),
                                minimumSize: const Size(double.infinity, 46),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25)))),
                            icon: const Icon(
                              CupertinoIcons.lock,
                              color: Color(0xB3C5F4FF),
                            ),
                            label: const Text("Sign Up")),
                      )
                    ]),

                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: -40,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close, color: Colors.black),
                      ),
                    )
                  ],

                ),
              ),
            ),
          )).then(onClosed);
}
