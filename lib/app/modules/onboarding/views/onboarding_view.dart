import 'dart:math';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/modules/home/controllers/home_controller.dart';
import 'package:task_app/app/modules/splashscreen/controllers/splashscreen_controller.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  OnboardingView({Key? key}) : super(key: key);
  OnboardingController onboardingController = Get.put(OnboardingController());
  HomeController homeController = Get.put(HomeController());

  final int totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondsaryColor,
      body: Stack(
        children: [
          PageView(
            controller: onboardingController.pageController,
            onPageChanged: (index) {
              onboardingController.currentPage.value = index;
            },
            children: [
              OnboardingPage(
                image: "lib/app/data/images/pana.png",
                title: "Manajemen Tugas",
                description: "Mari ciptakan",
                description2: " ruang  ",
                description3: "untuk alur kerja anda. ",
              ),
              OnboardingPage(
                image: "lib/app/data/images/amico.png",
                title: "Manajemen Tugas",
                description: "Bekerja lebih",
                description2: " Terstruktur ",
                description3: "dan Terorganisir. ",
              ),
              OnboardingPage(
                image: "lib/app/data/images/rafiki.png",
                title: "Manajemen Tugas",
                description: "Kelola tugas",
                description2: " Cepat ",
                description3: "untuk hasil Maksimal. ",
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              int currentPage = onboardingController.currentPage.value;
              return Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(totalPages, (index) {
                        return Container(
                          width: 10,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                onboardingController.currentPage.value == index
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                          ),
                        );
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Lewati"),
                        Stack(
                          children: [
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                    "lib/app/data/images/Rectangle-5904.png")),
                            Positioned(
                              right: 25,
                              bottom: 50,
                              child: GestureDetector(
                                onTap: () => onboardingController.nextPage(),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String description2;
  final String description3;

  OnboardingPage(
      {required this.image,
      required this.title,
      required this.description,
      required this.description2,
      required this.description3});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    "tasks",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.34,
                  child: Image.asset(
                    image,
                    height: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 80),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 12),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: description,
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        TextSpan(
                          text: description2,
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                        ),
                        TextSpan(
                          text: description3,
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ])),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
