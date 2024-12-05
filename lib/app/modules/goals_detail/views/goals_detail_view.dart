import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/data/model/goals_model.dart';
import 'package:task_app/app/modules/money_dialog/views/money_dialog_view.dart';
import 'package:task_app/app/modules/target_dialog/controllers/target_dialog_controller.dart';

import '../controllers/goals_detail_controller.dart';

class GoalsDetailView extends GetView<GoalsDetailController> {
  GoalsDetailView({Key? key}) : super(key: key);

  final GoalsDetailController controller = Get.put(GoalsDetailController());
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_back, color: Colors.black)),
                    SizedBox(width: 8),
                    Text(
                      "Goals",
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
                child: Row(
                  children: List.generate(
                      3, (index) => Icon(CarbonIcons.dot_mark, size: 14)),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Section
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8B78FF), // Warna ungu muda
                        Color(0xFF5451D6), // Warna ungu tua
                      ],
                      begin: Alignment.topLeft, // Awal gradien
                      end: Alignment.bottomRight, // Akhir gradien
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularPercentIndicator(
                        radius: 30.0,
                        lineWidth: 5.0,
                        percent: 0.20,
                        center: Text("20%",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.white,
                        backgroundColor: AppColors.trinaryColor,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pergi Liburan",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Rencana liburan jangka panjang\nBerakhir: 15 Okt 2024",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.rotate(
                        angle: 1.5708, // 90 derajat dalam radian (π/2)
                        child: Icon(Icons.more_vert, color: Colors.white),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 25),

                // Target Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Target",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                        onTap: () => showTargetDialog("goals baru"),
                        child: Icon(Icons.add_box_rounded,
                            color: AppColors.primaryColor)),
                  ],
                ),

                SizedBox(height: 15),

                // Target List
                Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.targetList.length,
                      itemBuilder: (context, index) {
                        final target = controller.targetList[index];
                        return GestureDetector(
                          onTap: () => showMoneyDialog(),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            target.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (target.subtitle != null)
                                            Row(
                                              children: [
                                                Image.asset(
                                                  color: Colors.grey,
                                                  'lib/app/data/images/target.png',
                                                  height:
                                                      15, // Sesuaikan dengan tinggi yang Anda inginkan
                                                  width: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  _getSubtitleText(target),
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Transform.rotate(
                                        angle:
                                            1.5708, // 90 derajat dalam radian (π/2)
                                        child: Icon(Icons.more_vert),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                LinearPercentIndicator(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  lineHeight: 6.0,
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  percent: target.progress.value,
                                  progressColor: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),

                SizedBox(height: 25),

                // History Section
                Text(
                  "Riwayat",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15),

                // History List
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Obx(() => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.historyList.length,
                        itemBuilder: (context, index) {
                          final history = controller.historyList[index];
                          return Container(
                            padding: EdgeInsets.fromLTRB(15, 7, 15, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        history.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    if (history.isCompleted)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          "+2",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    else
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          "-200.000",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.shade200,
                                )
                              ],
                            ),
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showTargetSelectionDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Select Target'),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text('Interval Pengukuran'),
                value: 'interval_pengukuran',
                groupValue: controller.targetType.value,
                onChanged: (value) =>
                    controller.changeTargetType('interval_pengukuran'),
              ),
              RadioListTile(
                title: Text('Sedang berlangsung/selesai'),
                value: 'sedang_berlangsung_selesai',
                groupValue: controller.targetType.value,
                onChanged: (value) =>
                    controller.changeTargetType('sedang_berlangsung_selesai'),
              ),
              RadioListTile(
                title: Text('Mata uang IDR'),
                value: 'mata_uang_idr',
                groupValue: controller.targetType.value,
                onChanged: (value) =>
                    controller.changeTargetType('mata_uang_idr'),
              ),
              if (controller.targetType.value == 'mata_uang_idr')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        controller.updateTarget(double.tryParse(value) ?? 0.0),
                    decoration: InputDecoration(
                      hintText: 'Enter Target',
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Handle the selected target and close the dialog
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  String _getSubtitleText(TargetItem target) {
    switch (target.subtitleType) {
      case TargetItemType.measurementInterval:
        return "1/${target.subtitle}";
      case TargetItemType.finishedOrUnfinished:
        return target.subtitle!;
      case TargetItemType.targetMoney:
        return "IDR ${target.subtitle}";
      default:
        return "";
    }
  }
}
