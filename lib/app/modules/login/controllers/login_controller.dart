import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final count = 0.obs;

  final TextEditingController emailAddressTextController =
      TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final FocusNode emailAddressFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool passwordVisibility = false;
  final RxBool obscureText = true.obs;
  var sosMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    MethodChannel('com.taskapp.task_app/sos')
        .setMethodCallHandler((call) async {
      print("MethodChannel called with method: ${call.method}");
      if (call.method == 'sosMessage') {
        sosMessage.value = call.arguments as String;
        print("SOS Message Received: ${sosMessage.value}");
      } else {
        print("Unknown method called: ${call.method}");
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailAddressTextController.dispose();
    passwordTextController.dispose();
    emailAddressFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void increment() => count.value++;
}
