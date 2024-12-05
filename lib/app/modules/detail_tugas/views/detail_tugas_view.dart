// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/modules/add_tim/views/add_tim_view.dart';
import 'package:task_app/app/modules/all_team/views/all_team_view.dart';
import 'package:task_app/app/modules/target_dialog/controllers/target_dialog_controller.dart';

import '../controllers/detail_tugas_controller.dart';

class DetailTugasView extends GetView<DetailTugasController> {
  DetailTugasView({Key? key}) : super(key: key);
  final DetailTugasController detailTugas = Get.put(DetailTugasController());
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    String title = args['title'];
    final query = MediaQuery.of(context);
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15),
      ),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: AppColors.secondsaryColor,
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        CarbonIcons.dot_mark,
                        size: 14,
                      ),
                      Icon(
                        CarbonIcons.dot_mark,
                        size: 14,
                      ),
                      Icon(
                        CarbonIcons.dot_mark,
                        size: 14,
                      ),
                    ],
                  ),
                ))
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF), // Warna putih
                Color(0xffF8F6FF), // Warna ungu muda
              ],
              begin: Alignment.topCenter, // Awal gradien
              end: Alignment.bottomCenter, // Akhir gradien
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Design UI',
                  style: TextStyle(
                      fontSize: textScaleFactor <= 1.15 ? 34 : 30,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/73.jpg"),
                        ),
                        title: Text(
                          'Manajer',
                          style: TextStyle(
                              fontSize: textScaleFactor <= 1.15 ? 13 : 10,
                              color: Colors.grey),
                        ),
                        subtitle: Text(
                          'Budi Nam',
                          style: TextStyle(
                              fontSize: textScaleFactor <= 1.15 ? 15 : 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.calendar_today_rounded,
                              color: Colors.white),
                        ),
                        title: Text(
                          'Tanggal Selesai',
                          style: TextStyle(
                              fontSize: textScaleFactor <= 1.15 ? 13 : 10,
                              color: Colors.grey),
                        ),
                        subtitle: Text(
                          '23/04/2024',
                          style: TextStyle(
                              fontSize: textScaleFactor <= 1.15 ? 15 : 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Deskripsi',
                  style: TextStyle(
                      fontSize: textScaleFactor <= 1.15 ? 18 : 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Antarmuka Pengguna (UI) adalah titik interaksi antara manusia dan mesin dalam perangkat lunak atau perangkat keras, memungkinkan pengguna berinteraksi dengan sistem secara efisien.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: textScaleFactor <= 1.15 ? 14 : 30,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Anggora team',
                  style: TextStyle(
                      fontSize: textScaleFactor <= 1.15 ? 18 : 15,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(AllTeamView());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/73.jpg"),
                        ),
                        Positioned(
                          left: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/72.jpg"),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/71.jpg"),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 90,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/70.jpg"),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 120,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.primaryColor,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Progress",
                    style: TextStyle(
                        fontSize: textScaleFactor <= 1.15 ? 18 : 14,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 4,
                ),
                Obx(
                  () => Stack(
                    children: [
                      LinearPercentIndicator(
                        percent: controller.progress.value,
                        lineHeight: 20,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: AppColors.primaryColor,
                        backgroundColor: Colors.grey[400],
                        barRadius: Radius.circular(24),
                        padding: EdgeInsets.zero,
                      ),
                      Center(
                          child: controller.progress.value >= 0.6
                              ? Text(
                                  "${(controller.progress.value * 100).toStringAsFixed(0)}%",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  "${(controller.progress.value * 100).toStringAsFixed(0)}%")),
                    ],
                  ),
                ),
                // Obx(() => Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text("Progres", style: TextStyle(fontSize: 18)),
                //         SizedBox(height: 10),
                //         LinearProgressIndicator(
                //           value: controller.progress.value,
                //           backgroundColor: Colors.grey[300],
                //           color: Colors.purple,
                //           minHeight: 10,
                //         ),
                //         SizedBox(height: 5),
                //         Text(
                //           "${(controller.progress.value * 100).toStringAsFixed(0)}%",
                //           style: TextStyle(fontSize: 16),
                //         ),
                //       ],
                //     )),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("tugas",
                        style: TextStyle(
                            fontSize: textScaleFactor <= 1.15 ? 18 : 14,
                            fontWeight: FontWeight.bold)),
                    title.toString() == "Proyek Baru"
                        ? GestureDetector(
                            onTap: () => showTargetDialog("proyek baru"),
                            child: Icon(
                              Icons.add_box,
                              color: AppColors.primaryColor,
                            ))
                        : SizedBox()
                  ],
                ),
                SizedBox(height: 10),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.tasks.length,
                    itemBuilder: (context, index) {
                      final task = controller.tasks[index];
                      return ListTile(
                          onTap: () => controller.toggleTaskCompletion(index),
                          leading: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  task.title,
                                  style: TextStyle(
                                    fontSize: textScaleFactor <= 1.15 ? 15 : 13,
                                    fontWeight: FontWeight.bold,
                                    color: task.isTogled.value
                                        ? Colors.grey
                                        : Colors.black,
                                    decoration: task.isTogled.value
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Obx(
                            () => Text(
                              "- ${task.description}",
                              style: TextStyle(
                                fontSize: textScaleFactor <= 1.15 ? 13 : 10,
                                color: task.isTogled.value
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: task.isTogled.value
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          trailing: Obx(
                            () => CircleAvatar(
                              radius: 15,
                              backgroundColor: task.isTogled.value
                                  ? AppColors.primaryColor
                                  : Colors.grey[300],
                              child: Icon(
                                task.isTogled.value
                                    ? Icons.check
                                    : Icons.circle_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
