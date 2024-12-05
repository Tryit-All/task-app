import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/modules/goals_detail/views/goals_detail_view.dart';

import '../controllers/goals_controller.dart';

class GoalsView extends GetView<GoalsController> {
  const GoalsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

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
          "Goals",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
    final query = MediaQuery.of(context);

    return MediaQuery(
        data: query.copyWith(
            textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15)),
        child: Scaffold(
            appBar: myAppbar,
            backgroundColor: Colors.white,
            body: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                // final target = controller.targetList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(GoalsDetailView());
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pergi Liburan",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Rencana liburan jangka panjang\nBerakhir: 15 Okt 2024",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircularPercentIndicator(
                          radius: 30.0,
                          lineWidth: 5.0,
                          percent: 0.20,
                          center: Text("20%",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: AppColors.primaryColor,
                          backgroundColor: AppColors.trinaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )));
  }
}
