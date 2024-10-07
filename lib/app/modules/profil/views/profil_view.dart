import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/modules/edit_profil/views/edit_profil_view.dart';

import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profil Saya'),
          centerTitle: true,
        ),
        body: MediaQuery(
            data: query.copyWith(
                textScaler:
                    TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.15))),
            child: SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/men/73.jpg"),
                    ),
                  ),
                  Text('Haza Amri',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text('+62 832-1141-674', style: TextStyle(fontSize: 15)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 16, 40, 30),
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.to(() => EditProfilView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: Size(double.infinity, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadowColor: AppColors.primaryColor.withOpacity(0.2),
                        elevation: 3,
                      ),
                      child: Text(
                        'Edit',
                        style: Theme.of(context).textTheme.button?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(child: Icon(CarbonIcons.settings), flex: 2),
                          Expanded(child: Text('Setting'), flex: 8)
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                              child: Icon(CarbonIcons.user_avatar), flex: 2),
                          Expanded(child: Text('Friend'), flex: 8)
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                              child: Icon(CarbonIcons.user_multiple), flex: 2),
                          Expanded(child: Text('New Group'), flex: 8)
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                              child: Icon(CarbonIcons.user_online), flex: 2),
                          Expanded(child: Text('Support'), flex: 8)
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(child: Icon(CarbonIcons.share), flex: 2),
                          Expanded(child: Text('Share'), flex: 8)
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                              child: Icon(CarbonIcons.information), flex: 2),
                          Expanded(child: Text('About Us'), flex: 8)
                        ],
                      ))
                ],
              ),
            ))));
  }
}
