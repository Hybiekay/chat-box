import 'package:flutter/material.dart';
import 'package:frontend/core/constant/app_colors.dart';
import 'package:frontend/core/constant/app_images.dart';
import 'package:frontend/core/constant/app_style.dart';
import 'package:frontend/widget/app_button.dart';
import 'package:frontend/widget/image_widget.dart';
import 'package:frontend/widget/or_divide_widget.dart';
import 'package:frontend/widget/social_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Stack(
          children: [
            Positioned(
              width: MediaQuery.sizeOf(context).width,
              right: 0,
              child: ImageWidget(fit: BoxFit.cover, AppImages.onboardBg),
            ),

            SizedBox(
              width: MediaQuery.sizeOf(context).width,

              child: Column(
                spacing: 10,
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    spacing: 10,
                    children: [
                      ImageWidget(
                        AppImages.logo,
                        width: 25,
                        color: AppColors.white,
                      ),
                      Text(
                        'ChatBox',
                        style: AppStyle.circularMediumStyle.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),

                  ///// Onboarding Text
                  ///
                  ///
                  Text(
                    'Connect friends ',
                    style: AppStyle.carosLargeStyle.copyWith(
                      fontWeight: FontWeight(500),
                    ),
                  ),
                  Text('easily & quickly', style: AppStyle.carosLargeStyle),

                  Text(
                    'Our chat app is the perfect way to stay \nconnected with friends and family.',
                    textAlign: .start,

                    style: AppStyle.circularSmallStyle,
                  ),

                  SizedBox(height: 20),

                  Row(
                    spacing: 12,
                    mainAxisAlignment: .center,
                    children: [
                      SocialBotton(iconPath: AppImages.facebook),
                      SocialBotton(iconPath: AppImages.google),
                      SocialBotton(iconPath: AppImages.apple),
                    ],
                  ),
                  SizedBox(height: 20),
                  OrDivideWidget(),
                  SizedBox(height: 10),
                  AppButton(
                    textColor: AppColors.black,
                    label: 'Sign up withn mail',
                    backgroundColor: AppColors.white,
                    onTap: () {
                      Navigator.pushNamed(context, 'register');
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        'Existing account? ',
                        style: AppStyle.circularSmallStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'login');
                        },

                        child: Text(
                          ' Log in',
                          style: AppStyle.circularSmallStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
