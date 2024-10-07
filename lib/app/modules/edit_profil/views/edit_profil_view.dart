import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';

import '../controllers/edit_profil_controller.dart';

class EditProfilView extends GetView<EditProfilController> {
  EditProfilView({Key? key}) : super(key: key);

  final EditProfilController _editProfilController =
      Get.put(EditProfilController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Edit Profil",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Text("Selesai",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor)))
          ],
        ),
        body: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      child: Stack(
                        children: [
                          Container(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(
                                    "https://randomuser.me/api/portraits/men/73.jpg"),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(Icons.add_a_photo_outlined)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 70, 30, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _editProfilController.namaTextController,
                          focusNode: _editProfilController.namaFocusNode,
                          autofocus: false,
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
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 15, 30, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller:
                              _editProfilController.namaPenggunaTextController,
                          focusNode:
                              _editProfilController.namaPenggunaFocusNode,
                          autofocus: false,
                          autofillHints: [AutofillHints.email],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            labelText: 'Nama Pengguna',
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
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 15, 30, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller:
                              _editProfilController.noTeleponTextController,
                          focusNode: _editProfilController.noTeleponFocusNode,
                          autofocus: false,
                          autofillHints: [AutofillHints.email],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            labelText: 'Nomor Telepon',
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
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your number phone';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 15, 30, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller:
                              _editProfilController.emailPenggunaTextController,
                          focusNode:
                              _editProfilController.emailPenggunaFocusNode,
                          autofocus: false,
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
                  ],
                ),
              ),
            )));
  }
}
