import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';

import '../controllers/target_dialog_controller.dart';

class TargetDialogView extends GetView<TargetDialogController> {
  TargetDialogView({Key? key}) : super(key: key);
  final controller = Get.put(TargetDialogController());
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    String title = args['title'];
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name Input Field
            TextField(
              decoration: InputDecoration(
                labelText:
                    title == "proyek baru" ? "Nama proyek" : "Nama target",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              controller: controller.nameController,
            ),
            SizedBox(height: 20),

            // Target Type Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title == "proyek baru" ? "Tipe proyek" : "Tipe target",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),

            Divider(thickness: 1),

            // Radio Buttons
            Obx(() => Column(
                  children: [
                    _buildRadioOption(
                      'Interval pengukuran',
                      TargetType.interval,
                    ),
                    _buildIntervalInputs(),
                    _buildRadioOption(
                      'Sedang berlangsung/selesai',
                      TargetType.ongoing,
                    ),
                    _buildGotoOrDoneButton(),
                    _buildRadioOption(
                      'Mata uang',
                      TargetType.currency,
                    ),
                    if (controller.selectedType.value == TargetType.currency)
                      _buildCurrencyInputs(),
                  ],
                )),

            SizedBox(height: 5),

            title == "proyek baru" ? _penerimaTugas() : SizedBox.shrink(),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => controller.saveTarget(),
                  child: Text('Selesai',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, TargetType type) {
    return Row(
      children: [
        Radio<TargetType>(
          value: type,
          groupValue: controller.selectedType.value,
          onChanged: (value) => controller.updateType(value!),
        ),
        Text(label),
      ],
    );
  }

  Widget _penerimaTugas() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          Divider(thickness: 1),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text("Penerima tugas",
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600)),
              Container(
                margin: EdgeInsets.only(left: 80),
                height: 40,
                width: 40,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 11,
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/men/73.jpg"),
                    ),
                    Positioned(
                      left: 15,
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
                          radius: 10,
                          backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/72.jpg"),
                        ),
                      ),
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
                          radius: 10,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/71.jpg"),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 45,
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
                          radius: 10,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/70.jpg"),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
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
                            size: 20,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGotoOrDoneButton() {
    if (controller.selectedType.value != TargetType.ongoing) {
      return SizedBox.shrink();
    }
    return Container(
      height: 35,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: Row(
        children: List.generate(
          controller.tabs.length,
          (index) => Expanded(
            child: Obx(
              () => GestureDetector(
                onTap: () => controller.changeTab(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.selectedTabIndex.value == index
                        ? AppColors.primaryColor
                        : AppColors.trinaryColor,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      controller.tabs[index],
                      style: TextStyle(
                        color: controller.selectedTabIndex.value == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntervalInputs() {
    if (controller.selectedType.value != TargetType.interval) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(left: 32),
      child: Row(
        children: [
          Column(
            children: [
              Text("Mulai"),
              Container(
                width: 60,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.trinaryColor),
                    color: AppColors.trinaryColor),
                child: TextField(
                  controller: controller.startController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.arrow_forward,
              color: AppColors.primaryColor,
            ),
          ),
          Column(
            children: [
              Text(
                "Target",
              ),
              Container(
                width: 60,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.trinaryColor),
                    color: AppColors.trinaryColor),
                child: TextField(
                  controller: controller.targetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyInputs() {
    return Padding(
      padding: EdgeInsets.only(left: 32),
      child: Row(
        children: [
          Text('Rp'),
          SizedBox(width: 8),
          Container(
            width: 120,
            child: TextField(
              controller: controller.currencyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
