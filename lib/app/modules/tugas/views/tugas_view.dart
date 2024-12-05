import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/data/utils/tab_kebiasaan.dart';
import 'package:task_app/app/data/utils/tab_tugas.dart';
import 'package:task_app/app/data/utils/tab_tugas_berulang.dart';
import 'package:task_app/app/data/utils/task_manager.dart';

import '../controllers/tugas_controller.dart';
import 'package:badges/badges.dart' as badges;

class TugasView extends GetView<TugasController> {
  TugasView({Key? key}) : super(key: key);
  TugasController tugasController = Get.put(TugasController(""));

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final TaskManager taskManager = TaskManager();

    final tasks = taskManager.getAllTasks();

    final mediaHeight = MediaQuery.of(context).size.height;
    final myAppbar = AppBar(
      elevation: 5, // Menghilangkan shadow di bawah AppBar
      backgroundColor: AppColors.secondsaryColor,
      surfaceTintColor: AppColors.secondsaryColor,
      actions: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.search),
              Image.asset(
                'lib/app/data/images/Vector2.png',
                height: 40, // Sesuaikan dengan tinggi yang Anda inginkan
                width: 40,
              ),
              Image.asset(
                'lib/app/data/images/Vector.png',
                height: 40, // Sesuaikan dengan tinggi yang Anda inginkan
                width: 40,
              ),
            ],
          ),
        ),
      ],
      title: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "List Tersimpan",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
        ),
      ),
      bottom: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          controller: tugasController.tabController,
          tabs: [
            Tab(
                child: badges.Badge(
              showBadge: (true),
              badgeAnimation: badges.BadgeAnimation.slide(),
              badgeContent: Text(
                tasks.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                ),
              ),
              position: badges.BadgePosition.topEnd(top: -10, end: -15),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.orange,
              ),
              child: Text(
                "Tugas",
                style: TextStyle(
                  fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                  color: Colors.black,
                ),
              ),
            )),
            Tab(
                child: badges.Badge(
              showBadge: (true),
              badgeAnimation: badges.BadgeAnimation.slide(),
              badgeContent: Text(
                (0).toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                ),
              ),
              position: badges.BadgePosition.topEnd(top: -10, end: -15),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.orange,
              ),
              child: Text(
                "Tugas Berulang",
                style: TextStyle(
                  fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                  color: Colors.black,
                ),
              ),
            )),
            Tab(
                child: badges.Badge(
              showBadge: (true),
              badgeAnimation: badges.BadgeAnimation.slide(),
              badgeContent: Text(
                (0).toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                ),
              ),
              position: badges.BadgePosition.topEnd(top: -10, end: -15),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.orange,
              ),
              child: Text(
                "Kebiasaan",
                style: TextStyle(
                  fontSize: textScaleFactor <= 1.15 ? 12 : 10,
                  color: Colors.black,
                ),
              ),
            )),
          ],
          labelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: textScaleFactor <= 1.15 ? 12 : 10,
              color: Colors.black,
              fontWeight: FontWeight.bold, // Font Weight untuk yang terpilih
            ),
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: textScaleFactor <= 1.15 ? 12 : 10,
              fontWeight:
                  FontWeight.normal, // Font Weight untuk yang tidak terpilih
            ),
          )),
    );
    final query = MediaQuery.of(context);

    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15)),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: myAppbar,
            body: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: TabBarView(
                  controller: tugasController.tabController,
                  children: [
                    PageTugas(),
                    PageTugasBerulang(),
                    PageKebiasaan()
                  ]),
            )),
      ),
    );
  }
}
