import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/model/goals_model.dart';
import 'package:task_app/app/modules/money_dialog/views/money_dialog_view.dart';

class GoalsDetailController extends GetxController {
  //TODO: Implement GoalsDetailController

  final count = 0.obs;
  final targetList = <TargetItem>[].obs;
  final historyList = <HistoryItem>[].obs;
  var targetType = 'interval_pengukuran'.obs;
  var target = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    targetList.value = [
      TargetItem(
        title: "Menabung 500.000",
        subtitle: "23000",
        subtitleType: TargetItemType.targetMoney,
        icon: Icons.account_balance_wallet_outlined,
        initialProgress: 0.20,
      ),
      TargetItem(
        title: "Mencari Referensi Travel",
        subtitle: "4",
        subtitleType: TargetItemType.measurementInterval,
        icon: Icons.search,
        initialProgress: 0.40,
      ),
      TargetItem(
        title: "Selesaikan Tugas",
        subtitle: "finished",
        subtitleType: TargetItemType.finishedOrUnfinished,
        icon: Icons.check_circle_outline,
        initialProgress: 0.80,
      ),
    ];

    historyList.value = [
      HistoryItem(
        title: "Mencari Referensi Travel",
        isCompleted: true,
        date: DateTime.now(),
      ),
      HistoryItem(
        title: "Menabung 500.000",
        isCompleted: false,
        date: DateTime.now(),
      ),
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void changeTargetType(String newType) {
    targetType.value = newType;
    update();
  }

  void updateTarget(double newTarget) {
    target.value = newTarget;
    update();
  }
}
