import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/data/utils/task_manager.dart';
import 'package:task_app/app/modules/tugas/controllers/tugas_controller.dart';

class PageTugas extends StatefulWidget {
  const PageTugas({Key? key}) : super(key: key);

  @override
  State<PageTugas> createState() => _PageTugasState();
}

class _PageTugasState extends State<PageTugas> {
  TugasController controller = Get.find<TugasController>();
  // ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final query = MediaQuery.of(context);

    return MediaQuery(
      data: query.copyWith(
          textScaler:
              TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.15))),
      child: RefreshIndicator(
        onRefresh: () async => await controller,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                content(context),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    TugasController tugasController = Get.find<TugasController>();
    final TaskManager taskManager = TaskManager();
    final Map<String, TugasController> itemControllers = {};

    return Obx(() {
      final tasks = taskManager.getAllTasks();

      return Stack(
        children: [
          Container(
            child: Obx(() {
              final tasks = taskManager.getAllTasks();

              // Initialize controllers for new tasks
              for (var task in tasks) {
                if (!itemControllers.containsKey(task.id)) {
                  itemControllers[task.id] = TugasController(task.id);
                }
              }

              return ListView.builder(
                itemCount: tasks.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final task = tasks[index];
                  final controller = itemControllers[task.id]!;

                  return Stack(
                    children: [
                      // Delete button background
                      GestureDetector(
                        onTap: () {
                          taskManager.removeTask(task.id);
                        },
                        child: Container(
                          height: 60,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Task item with animation
                      Obx(() => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            transform: Matrix4.translationValues(
                                controller.offset.value, 0, 0),
                            child: GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                final newOffset =
                                    controller.offset.value + details.delta.dx;
                                if (newOffset <= 70 && newOffset >= 0) {
                                  controller.offset.value = newOffset;
                                }
                              },
                              onHorizontalDragEnd: (details) {
                                if (controller.offset.value > 35) {
                                  controller.offset.value = 70;
                                } else {
                                  controller.offset.value = 0;
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: _getPriorityColor(
                                                task.priority),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                task.title,
                                                style: TextStyle(
                                                  fontSize:
                                                      textScaleFactor <= 1.15
                                                          ? 15
                                                          : 11,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 0, 8, 0),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .trinaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Text(
                                                      "${task.time.hour.toString().padLeft(2, '0')}:${task.time.minute.toString().padLeft(2, '0')}",
                                                      style: TextStyle(
                                                        fontSize:
                                                            textScaleFactor <=
                                                                    1.15
                                                                ? 9
                                                                : 5,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  if (task.priority != 1) ...[
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              8, 0, 8, 0),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .trinaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            "${task.priority}",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  textScaleFactor <=
                                                                          1.15
                                                                      ? 9
                                                                      : 5,
                                                            ),
                                                          ),
                                                          Icon(Icons.flag,
                                                              size: 15)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  if (task.description
                                                      .isNotEmpty) ...[
                                                    SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        task.description,
                                                        style: TextStyle(
                                                          fontSize:
                                                              textScaleFactor <=
                                                                      1.15
                                                                  ? 9
                                                                  : 5,
                                                          color: Colors.grey,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ]
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      );
    }
        // Container(
        //     child: ListView.builder(
        //   itemCount: 2,
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemBuilder: (BuildContext context, int index) {
        //     // final orderData = controller.pesananProses.data![index];
        //     // final totalHarga = (orderData.transaksi?.totalHarga ?? 0);
        //     return GestureDetector(
        //       onTap: () {
        //         // Get.to(const DetailTransaksiView(),
        //         //     arguments: orderData.transaksi?.kodeTr);
        //       },
        //       child: Padding(
        //           padding: const EdgeInsets.only(
        //               top: 10, left: 10, right: 10, bottom: 5),
        //           child: ListTile(
        //             title: Row(
        //               children: [
        //                 Container(
        //                     padding: EdgeInsets.all(3),
        //                     decoration: BoxDecoration(
        //                         color: AppColors.primaryColor,
        //                         borderRadius: BorderRadius.circular(5)),
        //                     child: Icon(Icons.check, color: Colors.white)),
        //                 SizedBox(
        //                   width: 10,
        //                 ),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       "Membuat Dashboard UI",
        //                       style: TextStyle(
        //                           fontSize: textScaleFactor <= 1.15 ? 15 : 11),
        //                     ),
        //                     Container(
        //                         padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        //                         decoration: BoxDecoration(
        //                             color: AppColors.trinaryColor,
        //                             borderRadius: BorderRadius.circular(3)),
        //                         child: Text(
        //                           "20:00",
        //                           style: TextStyle(
        //                               fontSize: textScaleFactor <= 1.15 ? 9 : 5),
        //                         ))
        //                   ],
        //                 )
        //               ],
        //             ),
        //           )),
        //     );
        //   },
        // )

        // Obx(() {

        // if (controller.isLoading.value) {
        //   return Shimmer.fromColors(
        //     baseColor: Color(baseColorHex),
        //     highlightColor: Color(highlightColorHex),
        //     child: Padding(
        //       padding: const EdgeInsets.all(10),
        //       child: SizedBox(
        //         height: mediaHeight,
        //         child: ListView.builder(
        //             physics: const NeverScrollableScrollPhysics(),
        //             shrinkWrap: true,
        //             itemCount: 5,
        //             itemBuilder: (BuildContext context, index) {
        //               return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   height: mediaHeight * 0.25,
        //                   decoration: const BoxDecoration(
        //                     color: Colors.orange,
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(
        //                         20,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             }),
        //       ),
        //     ),
        //   );
        // } else if (controller.pesananProses.data?.isEmpty ?? true) {
        //   return SizedBox(
        //     height: mediaHeight * 0.25,
        //     child: Center(
        //       child: Lottie.asset('assets/notList.json', repeat: true),
        //     ),
        //   );
        // } else {
        //   return ListView.builder(
        //     itemCount: 2,
        //     physics: const NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     itemBuilder: (BuildContext context, int index) {
        //       // final orderData = controller.pesananProses.data![index];
        //       // final totalHarga = (orderData.transaksi?.totalHarga ?? 0);
        //       return GestureDetector(
        //         onTap: () {
        //           // Get.to(const DetailTransaksiView(),
        //           //     arguments: orderData.transaksi?.kodeTr);
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.only(
        //               top: 10, left: 10, right: 10, bottom: 5),
        //           child: Card(
        //               color: Colors.white,
        //               key: ValueKey(
        //                   orderData.transaksi?.kodeTr), // Gunakan key unik
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(
        //                     10.0), // Sesuaikan dengan radius yang diinginkan
        //               ),
        //               elevation: 5,
        //               // color: Colors.red,
        //               child: Column(
        //                 children: [
        //                   ListTile(
        //                     leading: CircleAvatar(
        //                       backgroundImage:
        //                           AssetImage("assets/logo_dikantin.png"),
        //                     ),
        //                     title: Text(
        //                       "Data 1",
        //                       style: GoogleFonts.poppins(
        //                           textStyle: const TextStyle(
        //                               fontSize: 14,
        //                               color: Colors.black,
        //                               fontWeight: FontWeight.bold)),
        //                     ),
        //                     subtitle: Text(
        //                       orderData.transaksi!.tanggal.toString(),
        //                       style: GoogleFonts.poppins(
        //                           textStyle: const TextStyle(
        //                               fontSize: 12,
        //                               fontWeight: FontWeight.normal)),
        //                     ),
        //                   ),
        //                   Container(
        //                     padding: const EdgeInsets.all(10),
        //                     // color: Colors.blue,
        //                     child: Column(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceAround,
        //                         children: [
        //                           Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Text(
        //                                 "Total Menu",
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.black,
        //                                         fontWeight: FontWeight.normal)),
        //                               ),
        //                               Text(
        //                                 "Data ",
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.black,
        //                                         fontWeight: FontWeight.bold)),
        //                               ),
        //                             ],
        //                           ),
        //                           Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Text(
        //                                 "Total",
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.black,
        //                                         fontWeight: FontWeight.normal)),
        //                               ),
        //                               Text(
        //                                 'data',
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.black,
        //                                         fontWeight: FontWeight.bold)),
        //                               )
        //                             ],
        //                           ),
        //                           Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Text("Status",
        //                                   style: GoogleFonts.poppins(
        //                                       fontSize: 14,
        //                                       color: Colors.black,
        //                                       fontWeight: FontWeight.normal)),
        //                               Text(
        //                                 "Data",
        //                                 style: GoogleFonts.poppins(
        //                                     textStyle: const TextStyle(
        //                                         fontSize: 14,
        //                                         color: Colors.red,
        //                                         fontWeight: FontWeight.bold)),
        //                               ),
        //                             ],
        //                           ),
        //                         ]),
        //                   )
        //                 ],
        //               )),
        //         ),
        //       );
        //     },
        //   );
        // }
        // }

        );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 3:
        return Colors.red;
      case 2:
        return Colors.orange;
      default:
        return AppColors.primaryColor;
    }
  }
}
