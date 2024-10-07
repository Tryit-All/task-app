// ignore_for_file: prefer_const_constructors

import 'dart:math' as math;

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_transition_mixin.dart';
import 'package:task_app/app/data/colors.dart';

import '../controllers/new_task_controller.dart';

class NewTaskView extends GetView<NewTaskController> {
  NewTaskView({Key? key}) : super(key: key);

  final NewTaskController controller = Get.put(NewTaskController());
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15),
      ),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back, color: Colors.black)),
                    SizedBox(width: 8),
                    Text(
                      "Tugas Baru",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: textScaleFactor <= 1.15 ? 24 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GestureDetector(
                  onTap: () {
                    // Get.to(AllTeamView());
                  },
                  child: Text(
                    "Selesai",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                    color: Colors.white,
                    width: double.infinity,
                    child: TextFormField(
                      // controller: login.emailAddressTextController,
                      // focusNode: login.emailAddressFocusNode,
                      autofocus: true,
                      autofillHints: [AutofillHints.email],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        labelText: 'Nama Tugas',
                        labelStyle: TextStyle(
                            fontSize: textScaleFactor <= 1.15 ? 15 : 13),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong isikan nama tugas';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Obx(
                  () => controller.isSelected.value
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            controller.isSelected.value =
                                !controller.isSelected.value;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.1), // Warna shadow dengan opacity
                                  spreadRadius:
                                      1, // Seberapa jauh shadow menyebar
                                  blurRadius: 7, // Seberapa jauh shadow blur
                                  offset: Offset(
                                      0, 8), // Mengatur posisi shadow (x,y)
                                ),
                              ],
                            ),
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Center(
                                child: Transform.rotate(
                                    angle: -math.pi / 2,
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.grey[400],
                                    ))),
                          ),
                        ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: EasyDateTimeLine(
                          initialDate: DateTime.now(),
                          onDateChange: (selectedDate) {
                            //`selectedDate` the new date selected.
                          },
                          activeColor: AppColors.primaryColor,
                          headerProps: EasyHeaderProps(
                            showSelectedDate: false,
                            centerHeader: true,
                            monthStyle: TextStyle(fontWeight: FontWeight.bold),
                            monthPickerType: MonthPickerType.switcher,
                            // dateFormatter: DateFormatter.fullDateDayAsStrMY(),
                          ),
                          dayProps: const EasyDayProps(
                            activeDayStyle: DayStyle(
                              borderRadius: 32.0,
                            ),
                            inactiveDayStyle: DayStyle(
                              borderRadius: 32.0,
                            ),
                            todayStyle: DayStyle(
                              borderRadius: 32.0,
                            ),
                          ),
                          timeLineProps: const EasyTimeLineProps(
                            hPadding: 16.0, // padding from left and right
                            separatorPadding: 16.0, // padding between days
                          ),
                        ),
                      ),
                      Obx(() => AnimatedSize(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOutBack,
                            child: controller.isSelected.value
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(
                                              0.1), // Warna shadow dengan opacity
                                          spreadRadius:
                                              1, // Seberapa jauh shadow menyebar
                                          blurRadius:
                                              7, // Seberapa jauh shadow blur
                                          offset: Offset(0,
                                              8), // Mengatur posisi shadow (x,y)
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            autofocus: false,
                                            autofillHints: [
                                              AutofillHints.email
                                            ],
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 0, 0, 0),
                                              labelText: 'Deskripsi (Optional)',
                                              labelStyle: TextStyle(
                                                  fontSize:
                                                      textScaleFactor <= 1.15
                                                          ? 15
                                                          : 13),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              children: [
                                                Icon(Icons.add_box_rounded,
                                                    color:
                                                        AppColors.primaryColor),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Tambahkan sub-tugas",
                                                  style: TextStyle(
                                                    fontSize:
                                                        textScaleFactor <= 1.15
                                                            ? 13
                                                            : 10,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              children: [
                                                Icon(CupertinoIcons.bell,
                                                    color:
                                                        AppColors.primaryColor),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Pengikut",
                                                  style: TextStyle(
                                                    fontSize:
                                                        textScaleFactor <= 1.15
                                                            ? 13
                                                            : 10,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Spacer(),
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      AppColors.trinaryColor,
                                                  child: Text(
                                                    "0",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .primaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showQuantityDialog(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                children: [
                                                  Icon(CupertinoIcons.flag,
                                                      color: AppColors
                                                          .primaryColor),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "Prioritas",
                                                    style: TextStyle(
                                                      fontSize:
                                                          textScaleFactor <=
                                                                  1.15
                                                              ? 13
                                                              : 10,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: AppColors
                                                          .trinaryColor,
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                20, 5, 20, 5),
                                                        child: Obx(
                                                          () => Text(
                                                            controller.selectProritas
                                                                        .value ==
                                                                    0
                                                                ? "Defauld"
                                                                : controller
                                                                    .selectProritas
                                                                    .value
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .primaryColor),
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              children: [
                                                Icon(Icons.task,
                                                    color:
                                                        AppColors.primaryColor),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Tunda Tugas",
                                                  style: TextStyle(
                                                    fontSize:
                                                        textScaleFactor <= 1.15
                                                            ? 13
                                                            : 10,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.check_circle,
                                                  color: AppColors.primaryColor,
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.isSelected.value =
                                                  false;
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 5),
                                              child: Center(
                                                  child: Transform.rotate(
                                                      angle: -math.pi / 2,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_back_ios_rounded,
                                                        color: Colors.grey[400],
                                                      ))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox
                                    .shrink(), // Use SizedBox.shrink() to collapse the widget
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    print(controller.selectedTime.value);
                  },
                  child: Text(
                    "Pilih Waktu",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontSize: textScaleFactor <= 1.15 ? 20 : 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ClockWidget(size: 250)
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Tambah Anggota",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textScaleFactor <= 1.15 ? 18 : 16),
                  )
                ],
              ),
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
    final controller = Get.find<NewTaskController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
            "Tentukan Prioritas",
            style: TextStyle(
                fontSize: textScaleFactor <= 1.15 ? 18 : 16,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFEAE7FF),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: controller.decrement,
                          ),
                          Text(
                            controller.prioritas.string,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: controller.increment,
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(
                  'Prioritas tertinggi akan diletakkan paling atas dalam list',
                  style: TextStyle(
                    fontSize: textScaleFactor <= 1.15 ? 14 : 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.updatePrioritas();
                      Get.back();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class ClockWidget extends StatelessWidget {
  final double size;

  ClockWidget({required this.size});

  @override
  Widget build(BuildContext context) {
    final NewTaskController controller = Get.put(NewTaskController());

    return Obx(() {
      return Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTapUp: (details) {
              _handleTouch(details.localPosition, context, controller, size);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEAE7FF),
                shape: BoxShape.circle,
              ),
              child: CustomPaint(
                size: Size(size, size),
                painter: ClockPainter(
                  controller.selectedHour.value,
                  controller.selectedMinute.value,
                  controller.isSelectingHour.value,
                ),
              ),
            ),
          ),
          Container(
            width: size,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.selectHour();
                  },
                  child: Text(
                    controller.selectedHour.value != -1
                        ? controller.selectedHour.value
                            .toString()
                            .padLeft(2, '0')
                        : '00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: controller.isSelectingHour.value
                          ? AppColors.primaryColor
                          : Colors.black,
                    ),
                  ),
                ),
                Text(":"),
                GestureDetector(
                  onTap: () {
                    controller.selectMinute();
                  },
                  child: Text(
                    controller.selectedMinute.value != -1
                        ? controller.selectedMinute.value
                            .toString()
                            .padLeft(2, '0')
                        : '00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: !controller.isSelectingHour.value
                          ? AppColors.primaryColor
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  void _handleTouch(Offset position, BuildContext context,
      NewTaskController controller, double size) {
    double radius = size / 2;
    Offset center = Offset(radius, radius);

    if (controller.isSelectingHour.value) {
      // Handle hour selection
      for (int i = 1; i <= 12; i++) {
        double angle = math.pi / 6 * (i - 3);
        Offset offset = Offset(
          center.dx + radius * 0.75 * math.cos(angle),
          center.dy + radius * 0.75 * math.sin(angle),
        );

        if ((offset - position).distance <= 20) {
          controller.updateSelectedHour(i);
          return;
        }
      }

      for (int i = 13; i <= 24; i++) {
        double angle = math.pi / 6 * (i - 15);
        Offset offset = Offset(
          center.dx + radius * 0.5 * math.cos(angle),
          center.dy + radius * 0.5 * math.sin(angle),
        );

        if ((offset - position).distance <= 20) {
          controller.updateSelectedHour(i);
          return;
        }
      }
    } else {
      // Handle minute selection
      for (int i = 0; i < 60; i += 5) {
        double angle = math.pi / 30 * (i - 15);
        double distanceFromCenter = radius * 0.75;
        Offset offset = Offset(
          center.dx + distanceFromCenter * math.cos(angle),
          center.dy + distanceFromCenter * math.sin(angle),
        );

        if ((offset - position).distance <= 20) {
          controller.updateSelectedMinute(i);
          return;
        }
      }
    }
  }
}

class ClockPainter extends CustomPainter {
  final int? selectedHour;
  final int? selectedMinute;
  final bool selectingHour;

  ClockPainter(this.selectedHour, this.selectedMinute, this.selectingHour);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Offset center = Offset(radius, radius);

    if (selectingHour) {
      // Draw hours
      for (int i = 1; i <= 12; i++) {
        _drawClockNumber(canvas, size, center, radius, i,
            outerCircle: true, selectedNumber: selectedHour);
      }

      for (int i = 13; i <= 24; i++) {
        _drawClockNumber(canvas, size, center, radius, i,
            outerCircle: false, selectedNumber: selectedHour);
      }
    } else {
      // Draw minutes
      for (int i = 0; i < 60; i += 5) {
        _drawMinuteNumber(canvas, size, center, radius, i,
            outerCircle: true, selectedMinute: selectedMinute);
      }
    }
  }

  void _drawClockNumber(
      Canvas canvas, Size size, Offset center, double radius, int number,
      {required bool outerCircle, int? selectedNumber}) {
    double angle = math.pi / 6 * (number - (outerCircle ? 3 : 15));
    double distanceFromCenter = outerCircle ? radius * 0.75 : radius * 0.5;
    Offset offset = Offset(
      center.dx + distanceFromCenter * math.cos(angle),
      center.dy + distanceFromCenter * math.sin(angle),
    );

    double containerSize = outerCircle ? 40 : 30;
    RRect containerRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: offset, width: containerSize, height: containerSize),
      Radius.circular(30),
    );

    if (selectedNumber == number) {
      Paint containerPaint = Paint()..color = AppColors.primaryColor;
      canvas.drawRRect(containerRect, containerPaint);
    }

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: number.toString(),
        style: TextStyle(
          fontSize: outerCircle ? 14 : 12,
          color: selectedNumber == number ? Colors.white : Colors.black,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      offset - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  void _drawMinuteNumber(
      Canvas canvas, Size size, Offset center, double radius, int minute,
      {required bool outerCircle, int? selectedMinute}) {
    double angle = math.pi / 30 * (minute - 15);
    double distanceFromCenter = outerCircle ? radius * 0.75 : radius * 0.5;
    Offset offset = Offset(
      center.dx + distanceFromCenter * math.cos(angle),
      center.dy + distanceFromCenter * math.sin(angle),
    );

    double containerSize = outerCircle ? 40 : 30;
    RRect containerRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: offset, width: containerSize, height: containerSize),
      Radius.circular(30),
    );

    if (selectedMinute == minute) {
      Paint containerPaint = Paint()..color = AppColors.primaryColor;
      canvas.drawRRect(containerRect, containerPaint);
    }

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: minute.toString().padLeft(2, '0'),
        style: TextStyle(
          fontSize: 12,
          color: selectedMinute == minute ? Colors.white : Colors.black,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      offset - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
