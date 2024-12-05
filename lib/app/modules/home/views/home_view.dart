// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_transition_mixin.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/modules/detail_tugas/views/detail_tugas_view.dart';
import 'package:task_app/app/modules/goals_crud/views/goals_crud_view.dart';
import 'package:task_app/app/modules/kebiasaan_baru/views/kebiasaan_baru_view.dart';
import 'package:task_app/app/modules/new_recurring_task/views/new_recurring_task_view.dart';
import 'package:task_app/app/modules/new_task/views/new_task_view.dart';
import 'package:task_app/app/modules/proyek_baru/views/proyek_baru_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final HomeController home = Get.put(HomeController());
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final List<Widget> tim = [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: GestureDetector(
          onTap: () {
            Get.to(DetailTugasView(), arguments: {'title': ''});
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21.0),
            child: Stack(
              fit: StackFit
                  .expand, // Menggunakan StackFit.loose agar elemen dapat melebihi batas
              children: [
                Container(
                  color: AppColors.quaternaryColor,
                ),
                Positioned(
                  left: 80,
                  bottom: 50, // Posisi container ini di kanan
                  child: Container(
                    // color: Colors.amber,
                    child: Image.asset("lib/app/data/images/Vector_50.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 35, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Design UI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: textScaleFactor <= 1.15 ? 40 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Progress", style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: 4,
                      ),
                      LinearPercentIndicator(
                        percent: 0.4,
                        lineHeight: 4,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: Colors.white,
                        backgroundColor: Colors.grey,
                        barRadius: Radius.circular(24),
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            // First Profile Image
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      "https://randomuser.me/api/portraits/men/72.jpg"),
                                ),
                                Positioned(
                                  left: 30,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        "https://randomuser.me/api/portraits/men/71.jpg"),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.quaternaryColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '2 lainnya',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21.0),
          child: Stack(
            fit: StackFit
                .expand, // Menggunakan StackFit.loose agar elemen dapat melebihi batas
            children: [
              Container(
                color: AppColors.quinaryColor,
              ),
              Positioned(
                left: 80,
                bottom: 50, // Posisi container ini di kanan
                child: Container(
                  // color: Colors.amber,
                  child: Image.asset("lib/app/data/images/Vector_51.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 35, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tugas Laravel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: textScaleFactor <= 1.15 ? 40 : 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Progress", style: TextStyle(color: Colors.black)),
                    SizedBox(
                      height: 4,
                    ),
                    LinearPercentIndicator(
                      percent: 0.4,
                      lineHeight: 4,
                      animation: true,
                      animateFromLastPercent: true,
                      progressColor: Colors.white,
                      backgroundColor: Colors.grey,
                      barRadius: Radius.circular(24),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          // First Profile Image
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    "https://randomuser.me/api/portraits/men/75.jpg"),
                              ),
                              Positioned(
                                left: 30,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      "https://randomuser.me/api/portraits/men/71.jpg"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 2,
                                color: AppColors.quinaryColor,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '2 lainnya',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(21.0),
        child: Stack(
          fit: StackFit
              .expand, // Menggunakan StackFit.loose agar elemen dapat melebihi batas
          children: [
            Container(
              color: AppColors.quinaryColor,
            ),
            Positioned(
              left: 80,
              bottom: 50, // Posisi container ini di kanan
              child: Container(
                // color: Colors.amber,
                child: Image.asset("lib/app/data/images/Vector_51.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 35, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tugas Laravel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: textScaleFactor <= 1.15 ? 40 : 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Progress", style: TextStyle(color: Colors.black)),
                  SizedBox(
                    height: 4,
                  ),
                  LinearPercentIndicator(
                    percent: 0.4,
                    lineHeight: 4,
                    animation: true,
                    animateFromLastPercent: true,
                    progressColor: Colors.white,
                    backgroundColor: Colors.grey,
                    barRadius: Radius.circular(24),
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        // First Profile Image
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/73.jpg"),
                            ),
                            Positioned(
                              left: 30,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    "https://randomuser.me/api/portraits/men/72.jpg"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: AppColors.quinaryColor,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '2 lainnya',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ];

    final List<Widget> gools = [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: GestureDetector(
          onTap: () {
            Get.to(DetailTugasView());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21.0),
            child: Stack(
              fit: StackFit
                  .expand, // Menggunakan StackFit.loose agar elemen dapat melebihi batas
              children: [
                Container(
                  color: Color(0xff0D2F77),
                ),
                Positioned(
                  left: 140,
                  bottom: 50, // Posisi container ini di kanan
                  child: Container(
                    // color: Colors.amber,
                    child: Image.asset("lib/app/data/images/Ellipse_219.png"),
                  ),
                ),
                Positioned(
                  right: 130,
                  top: 180, // Posisi container ini di kanan
                  child: Container(
                    // color: Colors.amber,
                    child: Image.asset("lib/app/data/images/Ellipse_219.png"),
                  ),
                ),
                Positioned(
                  left: 80,
                  bottom: 100, // Posisi container ini di kanan
                  child: Container(
                    // color: Colors.amber,
                    child: Image.asset("lib/app/data/images/Ellipse_220.png"),
                  ),
                ),
                Positioned(
                  left: 40,
                  bottom: 190, // Posisi container ini di kanan
                  child: Container(
                    // color: Colors.amber,
                    child: Image.asset("lib/app/data/images/Ellipse_220.png"),
                  ),
                ),
                Positioned(
                  left: 110,
                  bottom: 70, // Posisi container ini di kanan
                  child: CircularPercentIndicator(
                    radius: 40.0,
                    percent: 0.20,
                    lineWidth: 8,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.white,
                    center: Text(
                      '20%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textScaleFactor <= 1.15 ? 20 : 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pergi Liburan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: textScaleFactor <= 1.15 ? 25 : 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("3 Target",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          child: Row(
                            children: [
                              // First Profile Image
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        "https://randomuser.me/api/portraits/men/72.jpg"),
                                  ),
                                  Positioned(
                                    left: 30,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          "https://randomuser.me/api/portraits/men/71.jpg"),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 2,
                                    color: AppColors.quaternaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '2 lainnya',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21.0),
          child: Stack(
            fit: StackFit
                .expand, // Menggunakan StackFit.loose agar elemen dapat melebihi batas
            children: [
              Container(
                color: Color(0xffE4DAFD),
              ),
              Positioned(
                left: 140,
                bottom: 50, // Posisi container ini di kanan
                child: Container(
                  // color: Colors.amber,
                  child: Image.asset(
                    "lib/app/data/images/Ellipse_219.png",
                    color: Color(0xFFEEEAF8),
                  ),
                ),
              ),
              Positioned(
                right: 130,
                top: 180, // Posisi container ini di kanan
                child: Container(
                  // color: Colors.amber,
                  child: Image.asset(
                    "lib/app/data/images/Ellipse_219.png",
                    color: Color(0xFFEEEAF8),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                bottom: 100, // Posisi container ini di kanan
                child: Container(
                  // color: Colors.amber,
                  child: Image.asset(
                    "lib/app/data/images/Ellipse_220.png",
                    color: Color(0xFFEEEAF8),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                bottom: 190, // Posisi container ini di kanan
                child: Container(
                  // color: Colors.amber,
                  child: Image.asset(
                    "lib/app/data/images/Ellipse_220.png",
                    color: Color(0xFFEEEAF8),
                  ),
                ),
              ),
              Positioned(
                left: 110,
                bottom: 70, // Posisi container ini di kanan
                child: CircularPercentIndicator(
                  radius: 40.0,
                  percent: 0.20,
                  lineWidth: 8,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.black,
                  center: Text(
                    '20%',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: textScaleFactor <= 1.15 ? 20 : 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 25, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Planning Seminar',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: textScaleFactor <= 1.15 ? 25 : 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("2 Target", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: Row(
                          children: [
                            // First Profile Image
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      "https://randomuser.me/api/portraits/men/75.jpg"),
                                ),
                                Positioned(
                                  left: 30,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        "https://randomuser.me/api/portraits/men/73.jpg"),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 2,
                                  color: Color(0xffE4DAFD),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '2 lainnya',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: AppColors.secondsaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text("Selasa, 21 April 2024",
                  style: TextStyle(color: Colors.grey)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFFFFF), // Warna putih
                  Color(0xFFF8F6FF), // Warna ungu muda
                ],
                begin: Alignment.topCenter, // Awal gradien
                end: Alignment.bottomCenter, // Akhir gradien
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Spasi tambahan di atas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo Andi',
                        style: TextStyle(
                          fontSize: textScaleFactor <= 1.15 ? 37 : 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Semoga harimu menyenangkan!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: textScaleFactor <= 1.15 ? 16 : 10,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/page-search');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Text(
                                    'Search',
                                    style: TextStyle(
                                      color: Color(0xFF969696),
                                      fontSize:
                                          textScaleFactor <= 1.15 ? 15 : 13,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xFF969696),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                          height: 5), // Spasi antara indikator dan Tugas Harian
                      Text(
                        'Proyek Saya',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: textScaleFactor <= 1.15 ? 24 : 22,
                        ),
                      ),

                      Row(
                        children: List.generate(
                          home.tabs.length,
                          (index) => Obx(
                            () => GestureDetector(
                              onTap: () => home.changeTab(index),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 2,
                                ),
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: home.selectedIndex.value == index
                                      ? AppColors.trinaryColor
                                      : Colors.grey[200],
                                  border: Border.all(
                                    color: home.selectedIndex.value == index
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  home.tabs[index],
                                  style: TextStyle(
                                    color: home.selectedIndex.value == index
                                        ? AppColors.primaryColor
                                        : Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 5),
                      Obx(
                        () => SizedBox(
                          width: screenWidth,
                          child: CarouselSlider(
                            carouselController: CarouselController(),
                            options: CarouselOptions(
                              height: screenHight * 0.3,
                              // autoPlay: true,
                              onPageChanged: (index, reason) {
                                home.onPageChanged(index);
                              },
                              enableInfiniteScroll: false,
                              viewportFraction: 0.65,
                            ),
                            items: controller.selectedIndex.value == 0
                                ? tim
                                : gools,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 10), // Spasi antara carousel dan indikator
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            controller.selectedIndex.value == 0
                                ? tim.length
                                : gools.length,
                            (index) {
                              bool isSelected = home.inner.value == index;
                              return AnimatedContainer(
                                duration: Duration(
                                    milliseconds: 300), // Durasi animasi
                                width: isSelected
                                    ? 30.0
                                    : 12.0, // Lebar berbeda untuk indikasi seleksi
                                height: 10.0, // Tinggi tetap
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.quaternaryColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              20), // Spasi antara indikator dan Tugas Harian
                      Text(
                        'Tugas Harian',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: textScaleFactor <= 1.15 ? 24 : 22,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15), // Spasi tambahan di atas list tugas
                Obx(
                  () => ListView.builder(
                    shrinkWrap:
                        true, // Membatasi tinggi list agar tidak mengganggu scroll
                    physics:
                        NeverScrollableScrollPhysics(), // Menghindari konflik scroll
                    itemCount: home.tasks.length,
                    itemBuilder: (context, index) {
                      final task = home.tasks[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  task.title,
                                  style: TextStyle(
                                    fontSize: textScaleFactor <= 1.15 ? 15 : 13,
                                    fontWeight: FontWeight.bold,
                                    color: task.isCompleted.value
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                      color: task.isCompleted.value
                                          ? Colors.grey
                                          : AppColors.trinaryColor,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 1, 8, 1),
                                    child: Text(
                                      task.time,
                                      style: TextStyle(
                                        color: task.isCompleted.value
                                            ? Colors.black
                                            : AppColors.primaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          title: Obx(
                            () => Text(
                              "-  ${task.description}",
                              style: TextStyle(
                                color: task.isCompleted.value
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: task.isCompleted.value
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () => home.toggleTaskCompletion(index),
                            child: Obx(
                              () => Icon(
                                size: 30,
                                task.isCompleted.value
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            _showQuantityDialog(context);
          },
          child: Container(
            color: Colors.white,
            child: Icon(
              Icons.add_box_rounded,
              size: 50,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  void _showQuantityDialog(
    BuildContext context,
  ) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    // final controller = Get.find<DetailController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(NewTaskView());
                },
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  title: Text(
                    'Tugas',
                    style: TextStyle(
                        fontSize: textScaleFactor <= 1.15 ? 16 : 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    'Aktivitas sekali selesai dan tidak perlu pelacakan waktu progres. ',
                    style: TextStyle(
                      fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                    ),
                  ),
                  trailing: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(NewRecurringTaskView());
                },
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.repeat_rounded, color: Colors.white),
                  ),
                  title: Text(
                    'Tugas Berulang',
                    style: TextStyle(
                        fontSize: textScaleFactor <= 1.15 ? 16 : 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    'Aktivitas berkala yang dijadwalkan ulang otomatis tanpa pemantauan progres.',
                    style: TextStyle(
                      fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                    ),
                  ),
                  trailing: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(KebiasaanBaruView());
                },
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.event_repeat, color: Colors.white),
                  ),
                  title: Text(
                    'Kebiasaan',
                    style: TextStyle(
                        fontSize: textScaleFactor <= 1.15 ? 16 : 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    'Aktivitas yang berulang seiring waktu dengan pelacakan dan statistik.',
                    style: TextStyle(
                      fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                    ),
                  ),
                  trailing: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(GoalsCrudView());
                },
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Image.asset(
                      color: Colors.white,
                      'lib/app/data/images/target.png',
                      height: 25, // Sesuaikan dengan tinggi yang Anda inginkan
                      width: 25,
                    ),
                  ),
                  title: Text(
                    'Goals',
                    style: TextStyle(
                        fontSize: textScaleFactor <= 1.15 ? 16 : 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    'Aktivitas dengan pencapaian dalam jangka waktu tertentu yang terpantau.',
                    style: TextStyle(
                      fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                    ),
                  ),
                  trailing: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(ProyekBaruView());
                },
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.group_sharp, color: Colors.white),
                  ),
                  title: Text(
                    'Proyek Tim',
                    style: TextStyle(
                        fontSize: textScaleFactor <= 1.15 ? 16 : 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    'Memudahkan kolaborasi dan pelacakan progres tugas secara efisien.',
                    style: TextStyle(
                      fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                    ),
                  ),
                  trailing: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
