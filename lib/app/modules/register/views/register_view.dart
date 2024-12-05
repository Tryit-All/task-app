import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/modules/login/views/login_view.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);
  RegisterController register = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.secondsaryColor,
        title: const Text(
          'Daftar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.secondsaryColor,
          child: Column(
            children: [
              Center(
                child: Container(
                    // color: Colors.amber,
                    width: 200,
                    height: 100,
                    child: Image.asset(
                        "lib/app/data/images/check-square-blue.png")),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Buat Akun',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.57,
                      child: Text(
                        'Silakan masukkan informasi Anda dan buat akun Anda',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: register.namaTextController,
                          focusNode: register.namaTextFocusNode,
                          autofocus: true,
                          autofillHints: [AutofillHints.email],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            labelText: 'Nama',
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
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
                            fillColor: Colors.grey[100],
                          ),
                          style: Theme.of(context).textTheme.bodyText1,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: register.emailAddressTextController,
                          focusNode: register.emailAddressFocusNode,
                          autofocus: true,
                          autofillHints: [AutofillHints.email],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            labelText: 'Email',
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
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
                            fillColor: Colors.grey[100],
                          ),
                          style: Theme.of(context).textTheme.bodyText1,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 16),
                          child: Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: register.passwordTextController,
                              focusNode: register.passwordFocusNode,
                              autofocus: true,
                              autofillHints: [AutofillHints.password],
                              obscureText: register.obscureText.value,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                labelText: 'Password',
                                labelStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).dividerColor,
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
                                fillColor: Colors.grey[100],
                                suffixIcon: InkWell(
                                  onTap: () {
                                    register.toggleObscureText();
                                  },
                                  child: Icon(
                                    register.obscureText.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 24,
                                  ),
                                ),
                              ),
                              style: Theme.of(context).textTheme.bodyText1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 30),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Get.offAll(() => NavigationView());
                          // controller.register(
                          //     controller.emailAddressTextController.text,
                          //     controller.passwordTextController.text);
                          // FocusScope.of(context).requestFocus(FocusNode());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          minimumSize: Size(double.infinity, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: AppColors.primaryColor.withOpacity(0.2),
                          elevation: 3,
                        ),
                        child: Text(
                          'Daftar',
                          style: Theme.of(context).textTheme.button?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Daftar dengan",
                style: TextStyle(color: Colors.grey),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 20, 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromARGB(255, 245, 242, 255),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 15, right: 15),
                          child: Icon(Icons.apple_sharp, color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromARGB(255, 245, 242, 255),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 15, right: 15),
                          child: Container(
                            height: 24,
                            width: 24,
                            child: Image.asset(
                                "lib/app/data/images/Logo-google.png"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Sudah punya akun? ",
                    style: TextStyle(color: Colors.grey)),
                TextSpan(
                    text: "Masuk",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.offAll(() => LoginView());
                      },
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    )),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
