import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;

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

  void SignUp(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (_formKey.currentState!.validate()) {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInputField(
                          "First Name", CupertinoIcons.person_add, false),
                      buildInputField(
                          "Last Name", CupertinoIcons.person_add_solid, false),
                      buildInputField(
                          "Email Address", CupertinoIcons.envelope_fill, false),
                      buildInputField(
                          "Phone Number", CupertinoIcons.phone, false),
                      buildInputField(
                          "Password", CupertinoIcons.lock, true),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          SignUp(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xB3C5F4FF),
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        icon: const Icon(
                          CupertinoIcons.arrow_right,
                          color: Colors.black,
                        ),
                        label: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isShowLoading)
                  CustomPositioned(
                    child: RiveAnimation.asset(
                      "assets/RiveAssets/check.riv",
                      onInit: (artboard) {
                        StateMachineController controller =
                        getRiveController(artboard);
                        check = controller.findSMI("Check") as SMITrigger;
                        error = controller.findSMI("Error") as SMITrigger;
                        reset = controller.findSMI("Reset") as SMITrigger;
                      },
                    ),
                  ),
                if (isShowConfetti)
                  CustomPositioned(
                    child: Transform.scale(
                      scale: 6,
                      child: RiveAnimation.asset(
                        "assets/RiveAssets/confetti.riv",
                        onInit: (artboard) {
                          StateMachineController controller =
                          getRiveController(artboard);
                          confetti = controller.findSMI("Trigger explosion")
                          as SMITrigger;
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, IconData icon, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 8),
          TextFormField(
            obscureText: isPassword,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
              border: const OutlineInputBorder(),
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
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
