import 'dart:ffi';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/modules/add_tim/views/add_tim_view.dart';

import '../controllers/all_team_controller.dart';

class AllTeamView extends GetView<AllTeamController> {
  const AllTeamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final AllTeamController allTeam = Get.put(AllTeamController());
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        CarbonIcons.dot_mark,
                        size: 14,
                      ),
                      Icon(
                        CarbonIcons.dot_mark,
                        size: 14,
                      ),
                      Icon(
                        CarbonIcons.dot_mark,
                        size: 14,
                      ),
                    ],
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Obx(() => allTeam.selectFilter.value
                    ? GestureDetector(
                        onTap: () {
                          Get.toNamed('/page-search');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Text(
                                    'Search',
                                    style: TextStyle(
                                      color: Color(0xFF969696),
                                      fontSize:
                                          textScaleFactor <= 1.15 ? 15 : 13,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    allTeam.selectFilter.value = false;
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: Color(0xFF969696),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${allTeam.member.length} Anggota",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Obx(
                        () => allTeam.selectFilter.value
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  allTeam.selectFilter.value = true;
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xFF969696),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(AddTimView());
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.person_add_alt_1_rounded,
                          color: Colors.white),
                    ),
                    title: Text(
                      "Tambah Anggota",
                      style: TextStyle(
                          fontSize: textScaleFactor <= 1.15 ? 13 : 10,
                          color: Colors.black),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: allTeam.member.length,
                  itemBuilder: (context, index) {
                    final member = allTeam.member[index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ListTile(
                            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(member.image),
                            ),
                            title: Text(
                              member.nama,
                              style: TextStyle(
                                  fontSize: textScaleFactor <= 1.15 ? 13 : 10,
                                  color: Colors.black),
                            ),
                            trailing: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: member.status == 'Admin'
                                        ? Color.fromARGB(255, 231, 208, 236)
                                        : Color.fromARGB(255, 241, 226, 187)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Text(
                                    member.status,
                                    style: TextStyle(
                                        fontSize:
                                            textScaleFactor <= 1.15 ? 15 : 13,
                                        color: member.status == 'Admin'
                                            ? AppColors.quaternaryColor
                                            : AppColors.quinaryColor),
                                  ),
                                ))),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            children: [
              Icon(
                Icons.logout,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                'Keluar dari tim',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
