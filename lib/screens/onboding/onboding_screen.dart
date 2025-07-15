import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:the_lithium_management/screens/onboding/components/animated_btn.dart';
import 'package:the_lithium_management/screens/onboding/components/custom_sign_in.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          bool isMobile = screenWidth < 600;
          bool isTablet = screenWidth >= 600 && screenWidth < 1024;

          return Stack(
            children: [
              // Background Image
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/Backgrounds/bg.png'),
                  ),
                ),
              ),

              // Main Content
              AnimatedPositioned(
                duration: const Duration(milliseconds: 240),
                top: isSignInDialogShown ? -50 : 0,
                height: screenHeight,
                width: screenWidth,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile
                          ? 16
                          : isTablet
                          ? 48
                          : 64,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const SizedBox(height: 50),

                        // Logo
                        Center(
                          child: Image.asset(
                            'assets/Logo/big_logo.png',
                            width: isMobile
                                ? screenWidth * 0.5
                                : isTablet
                                ? screenWidth * 0.4
                                : screenWidth * 0.3,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Title & Description
                        SizedBox(
                          width: isMobile
                              ? screenWidth * 0.9
                              : isTablet
                              ? screenWidth * 0.7
                              : screenWidth * 0.5,
                          child: Column(
                            children: [
                              Text(
                                "Track. Manage. Thrive.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isMobile
                                      ? 32
                                      : isTablet
                                      ? 45
                                      : 57,
                                  fontFamily: "Poppins",
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "The Lithium Manager is a HIPAA compliant portal that supports you, "
                                    "the patient in properly keeping track of and clinically managing "
                                    "prescribed lithium carbonate or lithium citrate with ease and safety.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isMobile
                                      ? 12
                                      : isTablet
                                      ? 14
                                      : 16,
                                  fontFamily: "Arial",
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Animated Button
                        Center(
                          child: SizedBox(
                            width: isMobile
                                ? screenWidth * 0.6
                                : isTablet
                                ? screenWidth * 0.4
                                : screenWidth * 0.3,
                            child: AnimatedBtn(
                              btnAnimationController: _btnAnimationController,
                              press: () {
                                _btnAnimationController.isActive = true;
                                Future.delayed(const Duration(milliseconds: 800), () {
                                  setState(() {
                                    isSignInDialogShown = true;
                                  });
                                  customSigninDialog(context, onClosed: (_) {
                                    setState(() {
                                      isSignInDialogShown = false;
                                    });
                                  });
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
