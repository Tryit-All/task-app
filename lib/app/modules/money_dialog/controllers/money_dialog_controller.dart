import 'package:get/get.dart';

class MoneyDialogController extends GetxController {
  //TODO: Implement MoneyDialogController

  final count = 0.obs;
  final RxDouble progress = 0.20.obs;
  final amount = 200000.0.obs;
  final availableBalance = 500000.0.obs;
  @override
  void onInit() {
    super.onInit();
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

  void updateAmount(double value) {
    amount.value = value;
  }
}
