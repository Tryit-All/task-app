import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/app/data/colors.dart';
import '../controllers/money_dialog_controller.dart';

class MoneyDialogView extends GetView<MoneyDialogController> {
  MoneyDialogView({Key? key}) : super(key: key);
  final controller = Get.put(MoneyDialogController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        // padding: EdgeInsets.all(20),
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

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Menabung 500.000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: _buildBalanceDisplay(),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white),
              child: Column(children: [
                _buildAmountInput(),
                _buildActionButtons(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceDisplay() {
    return Column(
      children: [
        Obx(
          () => SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 5,
                disabledThumbRadius: 2,
              ),
              overlayShape: RoundSliderOverlayShape(
                overlayRadius: 15,
              ),
            ),
            child: Slider(
              value: controller.progress.value,
              divisions: 100,
              thumbColor: AppColors.quaternaryColor,
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.trinaryColor,
              label: '${controller.progress.value * 100}%',
              min: 0,
              max: 1,
              onChanged: (value) {
                controller.progress.value = value;
              },
            ),
          ),
        ),
        Row(children: [
          Text(
            "Rp. 0",
            style: TextStyle(color: Colors.white),
          ),
          Spacer(),
          Text("Rp. 500.000", style: TextStyle(color: Colors.white)),
        ])
      ],
    );
  }

  Widget _buildAmountInput() {
    return Obx(() {
      final formattedAmount = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(controller.amount.value);
      return Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saat ini: ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Rp. 300.000"),
              Container(
                height: 42,
                width: 130,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller:
                            TextEditingController(text: formattedAmount),
                        onChanged: (value) {
                          final parsedValue = double.parse(value) ?? 0.0;
                          controller.updateAmount(parsedValue);
                        },
                        decoration: InputDecoration(
                          hintText: 'Rp 0',
                          border: UnderlineInputBorder(),
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Icon(Icons.add_box_outlined))
                  ],
                ),
              ),
              Text("Rp. 500.000"),
            ]),
            Text(
              'Saat ini: ',
              style: TextStyle(fontSize: 16, color: Colors.transparent),
            )
          ],
        ),
      );
    });
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => Get.back(result: controller.amount.value),
          child: Text('Simpan',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16)),
        ),
      ],
    );
  }
}

void showMoneyDialog() {
  Get.dialog(MoneyDialogView()).then((value) {
    if (value != null) {
      // Handle the saved amount
      print('Saved amount: $value');
    }
  });
}
