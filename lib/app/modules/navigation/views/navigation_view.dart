import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_app/app/modules/kalender/views/kalender_view.dart';
import 'package:task_app/app/modules/profil/views/profil_view.dart';
import 'package:task_app/app/modules/tugas/views/tugas_view.dart';

import '../../home/views/home_view.dart';
import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  NavigationView({Key? key}) : super(key: key);

  DateTime? currentBackPressTime;
  final NavigationController nav = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(
          // Perubahan di sini
          SnackBar(
            content: Text('Tekan sekali lagi untuk keluar'),
          ),
        );
        return Future.value(false);
      }
      return Future.value(true);
    }

    return Scaffold(
      backgroundColor: Colors.black, // Atur warna latar belakang Scaffold

      body: GetBuilder<NavigationController>(
        builder: (controller) {
          return IndexedStack(
            index: controller.tabIndex,
            children: [HomeView(), KalenderView(), TugasView(), ProfilView()],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<NavigationController>(
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white, // Warna latar belakang BottomNavigationBar
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.5), // Warna bayangan dengan opasitas 50%
                  spreadRadius: 2, // Jarak penyebaran bayangan
                  blurRadius: 10, // Radius blur bayangan
                  offset: Offset(
                      0, 3), // Offset untuk mengatur arah bayangan (x, y)
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation:
                  0.0, // Tidak diperlukan karena shadow ditangani oleh Container
              backgroundColor: Colors.white,
              currentIndex: controller.tabIndex,
              selectedItemColor: Color(0xFF0168A5),
              unselectedItemColor: Color(0xFFD1D1D1),
              onTap: (index) {
                nav.updateCurrentScreen(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    controller.tabIndex == 0 ? Icons.home : CarbonIcons.home,
                    size: 30,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    controller.tabIndex == 1
                        ? Icons.calendar_today_rounded
                        : CarbonIcons.calendar,
                    size: 30,
                  ),
                  label: 'Kalender',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CarbonIcons.catalog, size: 30),
                  label: 'Tugas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    controller.tabIndex == 3
                        ? CupertinoIcons.person_solid
                        : CupertinoIcons.person,
                    size: 30,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
